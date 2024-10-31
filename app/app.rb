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

    controller_class = Object.const_get("#{env['controller_name'].capitalize}Controller")
      controller = controller_class.new
      controller.send(env['action_name'], env)
  end
end