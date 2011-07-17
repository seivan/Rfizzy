require 'singleton'
class TaggingFactory
  include Singleton
  
  def namespace
    "bali"
  end
  
  def document_id
    article[:document_id]
  end
  
  def article    
    {:attribute_namespace => :article,
    :document_id => "MyPost",
    :association => "MyUser",
    :words => "food game sleep booze gaysex".split(" ")}
  end
  
  def document_key_name
    "#{namespace}:document:#{article[:association]}:#{article[:attribute_namespace]}:#{article[:document_id]}"
  end
  
  def word_key_name
    "#{namespace}:word:#{article[:association]}:#{article[:attribute_namespace]}:"
  end
  
  def tag_list
    article[:words].uniq
  end
  
  def tag_size
    tag_list.count
  end

end

