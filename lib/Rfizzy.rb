
class Rfizzy
  attr_reader :namespace, :redis

  def initialize(params)
    if params.instance_of? Hash
      possible_namespace = params[:namespace].match(/[\w]+/).to_s unless blank? params[:namespace]
      if blank? possible_namespace
        @namespace = "Rfizzy:"
      else
        @namespace = possible_namespace
      end
      raise RedisMissingException, "You need to pass a redis driver {:redis => your_driver}" if params[:redis] == nil
      @redis = params[:redis]
    else
      raise RedisMissingException, "You need to pass a redis driver {:redis => your_driver}" if params == nil || !params.instance_of?(Redis)
      @redis = params
      @namespace = "Rfizzy:"
    end
  end

  def create_index(params)
    @redis.multi do |red|
      params[:text].split(" ").each do |word|
        red.sadd "#{@namespace}:document:#{params[:association]}:#{params[:attribute_namespace]}:#{params[:document_id]}", word
        red.sadd "#{@namespace}:word:#{params[:association]}:#{params[:attribute_namespace]}:#{word}", params[:document_id]
      end
    end
  end
  
  def search_index(params)
    interstore_cache = Time.now.to_f.to_s
    results = []
    search_keys_array = search_keys(params)
    @redis.multi do |red|
      red.sinterstore interstore_cache, *search_keys_array
    end
    results = @redis.smembers interstore_cache
    @redis.multi do |red|
      red.del interstore_cache
    end

    # puts @redis.sinterstore interstore_cache, *search_keys_array
    # puts search_keys_array.inspect
    # results = @redis.smembers interstore_cache
    results
  end
  
  def destroy_index(params)      
    document_id = params[:document_id]
    words_array = @redis.smembers "#{@namespace}:document:#{params[:association]}:#{params[:attribute_namespace]}:document_id"
    words = words_array.join(" ")
    params.merge!({:search_text => words})
    keys_to_delete = search_keys(params)
    @redis.multi do |red|
      keys_to_delete.each do |key|
        red.srem key, document_id
      end
    end
  end
  
  private
  def search_keys(params)
    association = params[:association]
    attribute_namespace = params[:attribute_namespace]
    search_text = params[:search_text]
    search_keys = search_text.split(" ").map do |word|
      "#{@namespace}:word:#{association}:#{attribute_namespace}:#{word}"
    end
    search_keys
  end
  
  def blank?(obj)
    obj.strip! if obj.instance_of? String
    obj.respond_to?(:empty?) ? obj.empty? : !obj
  end


end

