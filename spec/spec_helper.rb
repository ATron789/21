require 'simplecov'
SimpleCov.start

ENV["RUBY_ENV"] = "test"

RSpec.configure do |config|
  config.warnings = true
end
