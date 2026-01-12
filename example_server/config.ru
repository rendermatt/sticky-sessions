require './app'

puts "starting app instance  #{ENV['RENDER_INSTANCE_ID']}"

run Sinatra::Applications
