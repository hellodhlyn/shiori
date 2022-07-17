class PingController < ApplicationController
  def ping
    render(plain: "pong")
  end
end
