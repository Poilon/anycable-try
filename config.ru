# frozen_string_literal: true

lib = File.expand_path('../../lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rack'
require 'anycable'
require 'litecable'
require 'lite_cable/server'
require 'pry'

require './app'

LiteCable.anycable!

app = Rack::Builder.new do
  map '/cable' do
    # You have to specify your app's connection class
    use LiteCable::Server::Middleware, connection_class: App::Connection
    run(proc { |_| [200, { 'Content-Type' => 'text/plain' }, ['OK']] })
  end
end

run app
