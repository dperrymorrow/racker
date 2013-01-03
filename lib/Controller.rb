require 'erb'

class Controller
  include Utils

  def initialize(params)
    # determine the action method to be called
    @params = params
  end

  def render(params={})
    params.with_defaults!(:template => "#{@params[:controller]}/#{@params[:action]}", :type => "text/html", :status => 200)
    params[:content] = self.template(params[:template]) unless params[:content]

    [
      params[:status],
      {
        "Cache-Control" => "no-cache, no-store, max-age=0, must-revalidate",
        "Pragma"        => "no-cache",
        "Expires"       => "Fri, 29 Aug 1997 02:14:00 EST",
        "Content-Type"  => params[:type]
      },
      [params[:content]]
    ]
  end

  def render_404
    self.render(:template => '404', :status => 404)
  end

  def template(file)
    file.gsub!('.erb', '')
    contents = File.read("#{ROOT_PATH}/app/views/#{file}.erb")
    template = ERB.new(contents).result(binding)
  end
end
