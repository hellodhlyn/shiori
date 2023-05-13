class PingController < ApplicationController
  newrelic_ignore

  def ping
    render(plain: "pong")
  end
end
