= Rfizzy 

{<img src="https://travis-ci.org/seivan/Rfizzy.png?branch=master" alt="Build Status" />}[https://travis-ci.org/seivan/Rfizzy]

== Installation
gem install Rfizzy

== {Documentation}[http://seivan.github.com/Rfizzy/]

== Why?
Because it was cheaper for me to use Redis 20mb than 15 gb PostgreSQL (not sure about the soft limit)
And also, because I want people to realize how powerful Redis actually is.

== Don't forget running things asynchronously - I recommend resque ;-)

== A ruby library utilizing Redis for

* {Full text search engine}[http://seivan.github.com/Rfizzy/FullTextSearch.html]
* {Tagging library}[http://seivan.github.com/Rfizzy/Tagging.html]
* Social Graph with friends, followers, followees, circles and etc. - (not in 0.1.0, gotta pick your battles)
* Messages, tweets, inbox, outbox and etc. - (not in 0.1.0, gotta pick your battles)

== Key Features

* Very unobtrusiv.
* Very easy to add to a project.
* Very easy to remove from a project.
* Small memory foot print.
* Very tiny code base compared to other libraries and in contrast to what it adds to a project.
* Fast.
* No learning curve.
* Works with any ORMs out of the box...
* ... Since it's not attached to any of ORMs


Works in all Ruby projects, regardless of ORM as long as an attribute has a way to identify it (e.g ID column). 
Very simple built, source code is < 100 loc and has full test coverage. 
Easy to tap into any project without high learning curve or code breakage. Easy to remove as well.
VERY unobtrusive.

== Introduction

```ruby
  class Tweet < ActiveRecord::Base 
    after_create :create_search_index
    before_destroy :destroy_search_index
  
    private
    def create_search_index
      FullTextSearch.create_index  :attribute_namespace => :tweet_text_content,
                                   :document_id => id,
                                   :words => text_content
                            
    end
  
    def destroy_search_index
      FullTextSearch.destroy_index  :attribute_namespace => :,
                                    :document_id => id
    
    end
  end


  set_of_ids = FullTextSearch.search_index :attribute_namespace => :tweet_text_content
                                           :search => "bieber"
                                         
  Twéet.where(:id => set_of_ids)
```

== Travis CI build status http://travis-ci.org/seivan/Rfizzy.png

Specs run with 1.9.2: http://travis-ci.org/#!/seivan/rfizzy

== Todo
* Refactor
* Add a index-cleaner to remove old/unused indices
* Add friendships
* Add messages
* Refactor some more
* Write internal documentation if the specs won't cut it.

== Contributing to Rfizzy
 
* Make sure you got Redis running locally on standard port.
* Make sure you can have up to 10 databases with redis, since the test suite uses db 10.
* Check out the latest develop to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/my_feature or hotfix/ branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

== Copyright

Copyright © 2011 Seifvan Heifdari af Awesomeness Von Cheeseburger

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. By not reading this fine print your soul is now the exclusive property of Seivan Heidari Productions and its Subsidiaries. Unauthorized use of Seivans code, images, materials, souls, odors and oxygen is strongly discouraged. We know where you sleep. Also, I might have banged your mums pool boy. Sorry about that.

