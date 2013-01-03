class HomeController < ApplicationController

  def index
    @title = "Hello There..."
    self.render
  end

  def update()
    render :content => "update -- #{debug(@params)}"
  end

  def destroy()
    render :content => "destroy -- #{debug(@params)}"
  end

  def show()
    render :content => "show -- #{debug(@params)}"
  end

  def create()
    render :content => "create -- #{debug(@params)}"
  end

  def new()
    render :content => "new -- #{debug(@params)}"
  end
end
