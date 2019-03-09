require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'active_support/inflector'

require 'lite_cable/server'

Dir['app/graphql/*'].select { |f| File.directory?(f) }.map do |dir|
  domain = dir.split('/').last.camelize
  Object.const_set(domain.to_sym, Module.new)
  domain.constantize.const_set(:Mutations, Module.new)
end
Dir['*/**/**.rb'].sort.each { |file| require_relative file }

Ohm.redis = Redic.new('redis://127.0.0.1:6379')

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
