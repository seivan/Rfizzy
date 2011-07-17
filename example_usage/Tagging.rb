### Tagging
#

#We are using an ActiveRecord model here.
class Article < ActiveRecord::Base 
  
  # With it's complimentary callbacks
  after_create :create_search_index
  before_destroy :destroy_search_index

  # But you can just as well use any other orm that gives it's documents/tables unique identifiers (id's)

  private
  def create_search_index
    # So we set the namespace we want the searching to be on by setting it's name :article_tags
    # We pass the article's id to it so we can find it
    #And we pass the articles tags as an array
    #Naturally the tags can just be a virtual attribute as an array of tags when posting the article
    TaggyMcFaggy.create_index :attribute_namespace => :article_tags,
                                :document_id => id,
                                :words => tags
                              
  end
  
  def destroy_search_index
    #Same concept applies here, except we don't care about the tags themselves.
    TaggyMcFaggy.destroy_index  :attribute_namespace => :article_text,
                                  :document_id => id
    
  end
end



#Pass in an array of tags, or a single tag as a text
set_of_ids = TaggyMcFaggy.search_index :attribute_namespace => :article_text,
                                         :search => "food"
                                         
#And no matter if you're using Mongoid, ActiveRecord or DataMapper, you can now query the ID's.
Article.where(:id => set_of_ids)


#Now lets assume we want to limit to who can search what by setting an association

  def create_search_index
    #Notice the assoction on article.user.id
    TaggyMcFaggy.create_index :attribute_namespace => :article_text,
                                :document_id => id,
                                :words => text_content,
                                :association => user.id
                              
  end
  
  def destroy_search_index
    #Same concept applies here, except we really do not care about the tags when deleting
    TaggyMcFaggy.destroy_index  :attribute_namespace => :article_text,
                                  :document_id => id,
                                  :association => user.id,

  end

#And when the current_user searches he will only find on his own associated tweets
set_of_ids = TaggyMcFaggy.search_index  :attribute_namespace => :article_text,
                                          :association => current_user.id,
                                          :search => ["Food", "gaming", "Balls"]
  
# ***

### But wait! ... there's more
#
#### What can I do with this?
#
#
# * [Tagging - find posts through tagging, find tags through posts][tagging]
#
# * [Full text search -through association or attributes][search]
#
# * Social Graph, friends, followers, followees
#
# You can find more advanced examples by using the "Jumper" placed at the upper right corner
#
#  [tagging]: https://github.com/fabrik42/acts_as_api/wiki/
#  [search]: https://github.com/fabrik42/acts_as_api/wiki/Calling-a-method-of-the-model

# ***

### Links
# * [Check out the source code on Github][source]
# * [Found a bug or do you have a feature request?][issue]
# * [Continues build and testing status][build]
#
# [source]: https://github.com/seivan/Rfizzy
# [issue]: https://github.com/seivan/Rfizzy/issues
# [build]: http://travis-ci.org/seivan/Rfizzy
