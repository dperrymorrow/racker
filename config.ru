ROOT_PATH   = File.dirname(__FILE__)
require "#{ROOT_PATH}/lib/Router.rb"
require 'rack/request'
require 'rack/response'

module Rack
  class App
    def call(env)
      req    = Request.new(env)
      router = Rackup::Router.new(req)
      return router.render()
    end
  end
end

use Rack::ShowExceptions
use Rack::CommonLogger
run Rack::App.new
