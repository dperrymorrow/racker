class Controller
  include Utils

  def initialize(params)
    # determine the action method to be called
    @params = params
  end



  def render(content="", type="text/html", status=200)
    [
      status,
      {
        "Cache-Control" => "no-cache, no-store, max-age=0, must-revalidate",
        "Pragma"        => "no-cache",
        "Expires"       => "Fri, 29 Aug 1997 02:14:00 EST",
        "Content-Type"  => type
      },
      [debug(@params)]
    ]
  end
end
