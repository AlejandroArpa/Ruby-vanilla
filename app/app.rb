require 'active_record'
require 'yaml'
require 'json'
require 'swagger/blocks'

db_config = YAML.load_file('config/database.yml')['development']
ActiveRecord::Base.establish_connection(db_config)

require_relative '../db/schema'
require_relative 'models/report'
require_relative './controllers/reports_controller'
require_relative './controllers/swagger'

class MyAPI
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'My Rack API'
      key :description, 'API for managing resources'
    end
    key :host, 'localhost:9292'
    key :basePath, '/api'
  end

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new

    route = Router.find_route(req.path_info, req.request_method)
    puts req.path_info
    if route
      controller_name, action_name = route[:to].split('#')
      controller_class = Object.const_get("#{controller_name.capitalize}Controller")
      controller = controller_class.new

      status, contentType, data, error = controller.send(action_name, req)
      res.status = status
      res["contentType"] = contentType 
      if data
        res.write({data: data}.to_json)
      elsif error
        res.write({error: error}.to_json)
      end
    else
      # Ruta no encontrada
      res.status = 404
      res['Content-Type'] = 'application/json'
      res.write({ error: "Not Found" }.to_json)
    end
    res.finish
  end
end