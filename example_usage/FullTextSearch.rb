### Full Text Searching
#

#We are using an ActiveRecord model here.
class Tweet < ActiveRecord::Base 
  
  # With it's complimentary callbacks
  after_create :create_search_index
  before_destroy :destroy_search_index

  # But you can just as well use any other orm that gives it's documents/tables unique identifiers (id's)

  private
  def create_search_index
    # So we set the namespace we want the searching to be on by setting it's name :tweet_text_content
    # We pass the tweets id to it so we can find it
    #And we pass the tweets text_content, so we can match our search
    FullTextSearch.create_index :attribute_namespace => :tweet_text_content,
                                :document_id => id
                              
  end
  
  def destroy_search_index
    #Same applies here to as to create, except we are removing the records indices
    #No need to pass the words here, just what records index to remove
    FullTextSearch.destroy_index  :attribute_namespace => :tweet_text_content,
                                  :document_id => id
    
  end
end



#Now you can search through your indices easily
#By passing what namespace you want to search on with the words you are searching with
set_of_ids = FullTextSearch.search_index :attribute_namespace => :tweet_text_content,
                                         :search => "jquery mobile"
                                         
#And no matter if you're using Mongoid, ActiveRecord or DataMapper, you can now query the ID's.
Article.where(:id => set_of_ids)

# ***

### Association

#Now lets assume we want to limit to who can search what by setting an association
  def create_search_index
    #Notice the assoction on the tweets user.id
    FullTextSearch.create_index :attribute_namespace => :tweet_text_content,
                                :document_id => id,
                                :words => text_content,
                                :association => user.id
                              
  end
  
  def destroy_search_index
    #Same concept applies here as well
    FullTextSearch.destroy_index  :attribute_namespace => :tweet_text_content,
                                  :document_id => id,
                                  :association => user.id,
    
  end

#And when the current_user searches he will only find on his own associated tweets
set_of_ids = FullTextSearch.search_index :attribute_namespace => :tweet_text_content,
                                         :search => "jQuery map",
                                         :association => current_user.id
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