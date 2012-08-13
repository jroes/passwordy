require 'rubygems'
gem 'test-unit'
require 'test/unit'

tests = Dir[File.expand_path("#{File.dirname(__FILE__)}/test_*.rb")]
tests.each do |file|
  require file
end
