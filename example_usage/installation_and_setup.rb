#Rfizzy is a ORM agnostic library where full text searching, tagging and social graph can be implemented in very few lines of code and extrmly low learning curve. Basically plug'n'play. 

# ***

###Installation
#### Dependency

#In your gemfile.
gem "Rfizzy"
#      bundle install

#### Initializer
##### inside config/initializers/load_rfizzy.rb

#Create an Rfizzy with your namespace.
# Default namespace is "Rfizzy".
PostSearcher = Rfizzy.new(:namespace => "PostSearcher", :redis => R)

#Make sure to pass a reference to the Redis connection.
FullOfShizzly = Rfizzy.new(:redis => R)


#This also works (Redis will default to localhost).
KissMyTizzly = Rfizzy.new(Redis.new)
##### RedisMissingException will be raised if no Redis is passed - that means if the @redis attribute reader is nil.


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