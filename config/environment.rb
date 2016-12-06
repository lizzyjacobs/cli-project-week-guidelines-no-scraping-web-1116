require 'bundler/setup'
Bundler.require(:default, :development)
$: << '.'

require_relative '../lib/data_fetchers/violation_api_adapter'
require_relative '../lib/models/violation_output'
require_relative '../lib/runners/violations_cli'

# Dir["lib/concerns/*.rb"].each {|f| require f}
# Dir["lib/models/*.rb"].each {|f| require f}
# Dir["lib/data_fetchers/*.rb"].each {|f| require f}
# Dir["lib/runners/*.rb"].each {|f| require f}

require "open-uri"
require "json"
