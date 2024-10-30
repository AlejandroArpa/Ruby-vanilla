require_relative '../router/router'
require_relative '../router/routes'


class RouterMiddleware
  def initialize(app)
    @app = app  # Almacena la aplicación o el siguiente middleware en la pila
  end

  def call(env)
    req = Rack::Request.new(env)
    route = Router.find_route(req.path_info, req.request_method)
    puts route
    if route
      # Ruta encontrada, procesar el controlador y la acción
      controller_name, action_name = route[:to].split('#')
      env['controller_name'] = controller_name
      env['action_name'] = action_name
      @app.call(env)
    else
      res = Rack::Response.new
      res.status = 404
      res['Content-Type'] = 'application/json'
      res.write({ error: "Not Found" }.to_json)
      res.finish
      
    end
  end
end
