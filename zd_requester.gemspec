lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'version'

Gem::Specification.new do |s|

  s.name    = "zd_requester"
  s.version = ZdRequester::VERSION
  s.date    = ZdRequester::VERSION_DATE
  s.summary = "Multi HTTP request wrapper for Zd"
  s.description = "Launch multi http requests to create data in Zd"
  s.authors = ["Anthony Woo"]

  s.add_dependency('faraday')
  s.add_dependency('typhoeus')
  s.add_dependency('json')

  s.require_paths = ["lib"]
  s.files = `git ls-files`.split("\n")

end