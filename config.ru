require_relative './boot'
require 'lite_cable/server'

LiteCable.anycable!

$stdout.sync = true

app = Rack::Builder.new do
  map '/cable' do
    # You have to specify your app's connection class
    use LiteCable::Server::Middleware, connection_class: Websocket::Connection
    run(proc { |_| [200, { 'Content-Type' => 'text/plain' }, ['OK']] })
  end
end

run app
