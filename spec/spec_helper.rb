$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'Rfizzy'
require "redis"
R = Redis.new
R.select 10
# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    
  end

  config.before(:each) do
  end

  config.after(:each) do
  end

  config.before(:all) do
   R.select 0
   R.flushdb

  end
  config.after(:all) do
    R.select 10
    R.flushdb
  end

end
