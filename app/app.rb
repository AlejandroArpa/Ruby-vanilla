require 'active_record'
require 'yaml'
require 'json'

db_config = YAML.load_file('config/database.yml')['development']
ActiveRecord::Base.establish_connection(db_config)

require_relative '../db/schema'
require_relative 'models/report'
require_relative './controllers/reports_controller'

class MyAPI
  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new

    route = Router.find_route(req.path_info, req.request_method)
    if route
      controller_name, action_name = route[:to].split('#')
      controller_class = Object.const_get("#{controller_name.capitalize}Controller")
      controller = controller_class.new

      # Ejecutar la acción del controlador
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