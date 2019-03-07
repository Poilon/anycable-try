CABLE_URL = ENV['ANYCABLE'] ? 'ws://localhost:9293/cable' : '/cable'

require './app/connection'
require './app/channel'

module App
end
