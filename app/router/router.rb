
class Router
  @routes = []

  class << self #Singleton para definir que cualquier metodo o atributo sera un metodo de clase y no de instancia
    attr_accessor :routes #efinir metodos getter y setter para cambiar @routes desde fuera de la clase

    def draw(&block)
      instance_eval(&block)
    end

    def get(path, has_param, to: )
      if has_param 
        route = path.split('/')[0]
      else
        route = path
      end
      @routes << { path: route, verb: "GET", to: to, param: has_param}
    end

    def post(path, to: )
      @routes << { path: path, verb: "POST", to: to, param: false }
    end

    def delete(path, has_param, to:  )
      if has_param
        route = path.split('/')[0]
      end
      @routes << { path: route, verb: "DELETE", to: to, param: has_param }
    end
    
    def patch(path, to:)
      
    end

    def put( path, to: )
      @routes << { path: path, verb: "PUT", to: to, param: true }
    end
    
  end

  def self.find_route(path, verb)
    cleaned_path = path.start_with?('/') ? path[1..-1] : path
    pathway, param = cleaned_path.split('/')
    par = param ? true : false
    route = @routes.find { |route| route[:path] == pathway && route[:verb] == verb && route[:param] == par }
    return route
  end
end
