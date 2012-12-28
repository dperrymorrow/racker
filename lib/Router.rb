require 'rack/response'
require "#{ROOT_PATH}/lib/Utils.rb"

module Rackup
  class Router
    include Utils

    def initialize(request)
      @params   = symbolize_keys(request.params)
      @segments = request.fullpath.split('?').first().split('/')
    end

    def render(content="", type="text/html", status=200)
      [
        status,
        {'Content-Type' => type},
        ["<pre>#{@params.to_s}</pre><pre>#{@segments.to_s}</pre>"]
      ]
    end
  end
end
