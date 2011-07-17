require 'singleton'
class SearchFactory
  include Singleton
  
  def namespace
    "short"
  end
  
  def document_id
    tweet[:document_id]
  end
  
  def tweet    
    {:attribute_namespace => :tweet,
    :document_id => "MyPost",
    :association => "MyUser",
    :words => "should create the document set with proper key names filled with words"}
  end
  
  def document_key_name
    "#{namespace}:document:#{tweet[:association]}:#{tweet[:attribute_namespace]}:#{tweet[:document_id]}"
  end
  
  def word_key_name
    "#{namespace}:word:#{tweet[:association]}:#{tweet[:attribute_namespace]}:"
  end
  
  def word_list
    tweet[:words].split(" ").uniq
  end
  
  def word_size
    word_list.count
  end

end

