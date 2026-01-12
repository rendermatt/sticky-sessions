require 'sinatra'
require 'json'
require 'puma'

get '/' do
  headers = request.env.select { |k, v| k.start_with?('HTTP_') }

  # Get the sticky session header value
  sticky_header_name = ENV['STICKY_SESSION_HEADER']
  sticky_header_value = nil

  if sticky_header_name
    # Convert header name to Rack format (HTTP_ prefix, uppercase, dashes to underscores)
    rack_header_name = "HTTP_#{sticky_header_name.upcase.tr('-', '_')}"
    sticky_header_value = request.env[rack_header_name]
  end

  response = "#{Time.now}: serving a request from #{ENV['RENDER_INSTANCE_ID']}"
  response += "\nSticky Session Header (#{sticky_header_name}): #{sticky_header_value || 'not set'}\n"
  response
end

get '/health' do
  status 200
  "orl korrect"
end
