# frozen_string_literal: true

require 'sinatra'
require 'tty-table'
require 'yaml'

get '/' do
  @title         = 'Service Status - Monarch'
  @content       = YAML.load_file('status.yaml')
  @color         = 'greens'
  @statusText    = 'Operational'
  @copyright     = 'Powered by <a href="https://github.com/td512/heartbeat" class="links">Monarch Heartbeat</a>.'
  @bannerText    = 'All systems are operational'
  @service_color = 'success'
  if request.user_agent.match?(/wget|curl/i)
    content_type :text
    erb :index_text
  else
    erb :index
  end
end
