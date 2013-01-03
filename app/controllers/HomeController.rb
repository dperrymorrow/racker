class HomeController < ApplicationController

  def index
    @title = "Hello There..."
    self.render
  end
end
