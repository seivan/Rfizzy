require "active_support/core_ext/object/blank"
class Rfizzy
  attr_reader :namespace, :redis

  def initialize(options)
    if options.instance_of? Hash
      possible_namespace = options[:namespace].match(/[\w]+/).to_s unless options[:namespace].blank?
      if possible_namespace.blank?
        @namespace = "Rfizzy:"
      else
        @namespace = possible_namespace
      end
      raise RedisMissingException, "You need to pass a redis driver {:redis => your_driver}" if options[:redis] == nil
      @redis = options[:redis]
    else
      raise RedisMissingException, "You need to pass a redis driver {:redis => your_driver}" if options == nil || !options.instance_of?(Redis)
      @redis = options
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
  
  def search_index(options)
    interstore_cache = Time.now.to_f.to_s
    results = []
    search_keys_array = search_keys(options)
    @redis.multi do |red|
      red.sinterstore interstore_cache, *search_keys_array
      
    end
    results = @redis.smembers interstore_cache
    @redis.del interstore_cache
    # puts @redis.sinterstore interstore_cache, *search_keys_array
    # puts search_keys_array.inspect
    # results = @redis.smembers interstore_cache
    results
  end
  
  private
  def search_keys(options)
    association = options[:association]
    attribute_namespace = options[:attribute_namespace]
    search_text = options[:search_text]
    search_keys = search_text.split(" ").map do |word|
      "#{@namespace}:word:#{association}:#{attribute_namespace}:#{word}"
    end
    search_keys
  end


end

