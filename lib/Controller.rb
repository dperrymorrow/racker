class Controller
  include Utils

  def initialize(params)
    # determine the action method to be called
    @params = params
  end

  def render(content=debug(@params), type="text/html", status=200)
    [
      status,
      {
        "Cache-Control" => "no-cache, no-store, max-age=0, must-revalidate",
        "Pragma"        => "no-cache",
        "Expires"       => "Fri, 29 Aug 1997 02:14:00 EST",
        "Content-Type"  => type
      },
      [content]
    ]
  end

  def render_404
    self.render("<h1>404 Not Found!</h1>#{debug(@params)}", "text/html", 404)
  end
end
