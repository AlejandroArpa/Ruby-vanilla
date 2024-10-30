require 'active_record'
require 'yaml'
require 'json'
require_relative 'middlewares/RouterMiddleware'
require_relative 'controllers/reports_controller'


db_config = YAML.load_file('app/config/database.yml')['development']
ActiveRecord::Base.establish_connection(db_config)

require_relative 'config/db/schema'

class MyAPI

  def call(env)

    req = Rack::Request.new(env)
    res = Rack::Response.new
    controller_class = Object.const_get("#{env['controller_name'].capitalize}Controller")
      controller = controller_class.new
      status, content_type, data, error = controller.send(env['action_name'], req)
      res = Rack::Response.new
      res.status = status
      res["Content-Type"] = content_type
      if data
        res.write({ data: data }.to_json)
      elsif error
        res.write({ error: error }.to_json)
      end
      res.finish
  end
end