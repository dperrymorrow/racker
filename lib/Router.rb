class Router
  include Utils

  def initialize(request)
    @request        = request
    @request_method = @request.request_method
    self.parse_params()
    self.parse_uri()
  end

  def parse_params
    @params = symbolize_keys(@request.params) # convert the params to symbols
    @params ||= {} # empty hash if no params
  end

  def parse_uri
    @segments = @request.fullpath.split('?').first().split('/') - [""]
    @segments = ["home", "index"] if @segments.empty? # if empty then home/index
  end

  def parse_action
    action = ""
    if @segments.length == 1 and @request.request_method == "GET" # if no action, then index
      action = "index"
    else
      action = @segments[1]
    end
  end

  def parse_controller
    @segments[0]
  end

  def vars
    @params.merge(
      :segments   => @segments, 
      :controller => self.parse_controller, 
      :action     => self.parse_action,
      :method     => @request_method,
      :url        => @request.url
    )
  end

  def render
    Controller.new(self.vars).render
  end
end

