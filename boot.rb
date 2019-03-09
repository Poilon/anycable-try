require 'rubygems'
require 'bundler'
Bundler.require(:default)
require 'active_support/inflector'

Dir['app/graphql/*'].select { |f| File.directory?(f) }.map do |dir|
  domain = dir.split('/').last.camelize
  Object.const_set(domain.to_sym, Module.new)
  domain.constantize.const_set(:Mutations, Module.new)
end
Dir['*/**/**.rb'].each { |file| require_relative file }

Ohm.redis = Redic.new('redis://127.0.0.1:6379')
