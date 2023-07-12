class ApplicationController < ActionController::Base
  def index
    render html: "hello!"
  end
end
