require 'rack'
require_relative 'config/routes'
require_relative 'app/app'

# map "/swagger-ui" do
#   puts "hola"
#   run Rack::Files.new(File.expand_path('./public/swagger', __FILE__))
# end

map "/swagger-ui" do
  puts "Serving Swagger UI files from #{File.expand_path('../public/swagger', __FILE__)}"
  run Rack::Files.new(File.expand_path('../public/swagger', __FILE__))
end


run MyAPI.new