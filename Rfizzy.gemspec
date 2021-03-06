# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{Rfizzy}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Seivan Heidari"]
  s.date = %q{2011-07-18}
  s.description = %q{Full text search engine with Redis. Works in all Ruby projects. Very simple built, source code is < 300loc including tests. Was built because it's cheaper to go with the 20mb Redis solution with redis than using PostgreSQL's full text search. Also I needed background jobs and might as well use Resque for that.}
  s.email = %q{seivan@kth.se}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "Rfizzy.gemspec",
    "VERSION",
    "example_usage/FullTextSearch.rb",
    "example_usage/Tagging.rb",
    "example_usage/installation_and_setup.rb",
    "lib/Rfizzy.rb",
    "spec/.DS_Store",
    "spec/initialization/rfizzy_searching_initialize_spec.rb",
    "spec/searching/.DS_Store",
    "spec/searching/rfizzy_searching_create_spec.rb",
    "spec/searching/rfizzy_searching_destroy_spec.rb",
    "spec/searching/rfizzy_searching_search_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/.DS_Store",
    "spec/support/Factories/search_factories.rb",
    "spec/support/Factories/tagging_factories.rb",
    "spec/tagging/rfizzy_tagging_create_spec.rb",
    "spec/tagging/rfizzy_tagging_search_spec.rb"
  ]
  s.homepage = %q{http://github.com/seivan/Rfizzy}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Full text search engine with Redis. Works in all Ruby projects}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<autotest>, [">= 0"])
      s.add_development_dependency(%q<syntax>, [">= 0"])
      s.add_development_dependency(%q<reek>, ["~> 1.2.8"])
    else
      s.add_dependency(%q<redis>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<autotest>, [">= 0"])
      s.add_dependency(%q<syntax>, [">= 0"])
      s.add_dependency(%q<reek>, ["~> 1.2.8"])
    end
  else
    s.add_dependency(%q<redis>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<autotest>, [">= 0"])
    s.add_dependency(%q<syntax>, [">= 0"])
    s.add_dependency(%q<reek>, ["~> 1.2.8"])
  end
end

