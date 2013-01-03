ROOT_PATH = File.dirname(__FILE__)

require "rubygems"
require "#{ROOT_PATH}/lib/Router.rb"
require "#{ROOT_PATH}/lib/Utils.rb"
require "#{ROOT_PATH}/lib/Model.rb"
require "#{ROOT_PATH}/lib/Controller.rb"

require 'rack/request'
require 'rack/response'
require 'rack/reloader'
require 'rack/nocache'
require 'rack/response'

module Rack
  class App
    def call(env)
      req = Request.new(env)
      router = Router.new(req)
      return router.render()
    end
  end
end

app = Rack::Builder.new do
  use Rack::ShowExceptions
  use Rack::CommonLogger
  use Rack::Reloader
  use Rack::Nocache
  run Rack::App.new
end.to_app

Rack::Handler::Thin.run app, :Port => 4000
