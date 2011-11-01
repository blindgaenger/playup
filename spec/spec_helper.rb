require 'rspec/core'
require 'playup'
require 'pp'

Dir['./spec/support/**/*.rb'].map {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding :broken => true
end
