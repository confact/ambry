require File.expand_path("../lib/prequel/version", __FILE__)

Gem::Specification.new do |s|
  s.authors           = "Norman Clarke"
  s.email             = "norman@njclarke.com"
  s.files             = `git ls-files`.split("\n").reject {|f| f =~ /^\./}
  s.has_rdoc          = true
  s.homepage          = "http://github.com/norman/prequel"
  s.name              = "prequel"
  s.platform          = Gem::Platform::RUBY
  s.rubyforge_project = "[none]"
  s.summary           = "An ActiveModel-compatible ORM-like library for storing model instances in an in-memory Hash."
  s.test_files        = Dir.glob "test/**/*_test.rb"
  s.version           = Prequel::Version::STRING
  s.description       = <<-EOD
    Prequel is a database and ORM replacement for (mostly) static models and
    small datasets. It provides ActiveModel compatibility, and flexible
    searching and storage.
  EOD
  s.add_development_dependency "ffaker"
  s.add_development_dependency "minitest", "~> 2.2.2"
  s.add_development_dependency "mocha"
  s.add_development_dependency "activesupport", "~> 3.0"
  s.add_development_dependency "activemodel", "~> 3.0"
end