class Router
  include Utils

  def initialize(request)
    @request        = request
    @request_method = @request.request_method
    self.parse_params()
    self.parse_uri()
    self.vars()
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
    @segments[0].to_s
  end

  def vars
    @params.merge!(
      :segments   => @segments, 
      :controller => self.parse_controller, 
      :action     => self.parse_action,
      :method     => @request_method,
      :url        => @request.url
    )
  end

  def render
    file = "#{ROOT_PATH}/app/controllers/#{@params[:controller].capitalize}Controller.rb"
    if File.exists?(file)
      require file
      @controller = Object.const_get(@params[:controller].capitalize + "Controller").new(self.vars)
      @controller.respond_to?(@params[:action]) ? @controller.send(@params[:action]) : @controller.render_404
    else
      Controller.new(self.vars).render_404
    end
  end
end

