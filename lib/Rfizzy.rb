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
  
  
end

