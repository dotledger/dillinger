$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'dillinger'
require 'support/fixtures_helper'

RSpec.configure do |config|
  config.include FixturesHelper
end
