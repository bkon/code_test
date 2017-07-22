require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
end

require "codecov"
SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Codecov
]

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "piawe"

require "support/factory_girl"
