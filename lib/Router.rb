class Router
  include Utils

  REST_MEMBER = {
    'GET'    => 'show',
    'PUT'    => 'update',
    'DELETE' => 'destroy'
  }

  REST_COLLECTION = {
    'GET'  => 'index',
    'POST' => 'create'
  }

  def initialize(request)
    @request        = request
    @request_method = @request.request_method
    self.parse_params()
    self.parse_uri()
    self.vars()
  end

  def parse_params
    @params = symbolize_keys(@request.params) || {}
  end

  def parse_uri
    @segments = @request.fullpath.split('?').first().split('/') - [""]
    @segments = ["home", "index"] if @segments.empty? # if empty then home/index
    @format   = @segments.last().split('.')[1] || 'html'
    @segments.last.gsub!(".#{@format}", '')
  end

  def parse_action
    action = @segments[1]
    action = REST_COLLECTION[@request_method] unless action

    if action and action.is_i?
      @params[:id] = action.to_i
      action = REST_MEMBER[@request_method]
    end

    return action
  end

  def parse_controller
    @segments[0]
  end

  def vars
    @params.merge!(
      :segments   => @segments, 
      :controller => self.parse_controller, 
      :action     => self.parse_action,
      :method     => @request_method,
      :url        => @request.url,
      :format     => @format
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

