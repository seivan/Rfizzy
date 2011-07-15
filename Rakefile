# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "Rfizzy"
  gem.homepage = "http://github.com/seivan/Rfizzy"
  gem.license = "MIT"
  gem.summary = %Q{Full text search engine with Redis. Works in all Ruby projects}
  gem.description = %Q{Full text search engine with Redis. Works in all Ruby projects. Very simple built, source code is < 300loc including tests. Was built because it's cheaper to go with the 20mb Redis solution with redis than using PostgreSQL's full text search. Also I needed background jobs and might as well use Resque for that.}
  gem.email = "seivan@kth.se"
  gem.authors = ["Seivan Heidari"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'reek/rake/task'
Reek::Rake::Task.new do |t|
  t.fail_on_error = true
  t.verbose = false
  t.source_files = 'lib/**/*.rb'
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end


RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
  spec.rspec_opts = ["--color", "--format", "documentation", "--tag"]
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
