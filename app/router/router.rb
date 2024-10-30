
class Router
  @routes = []

  class << self #Singleton para definir que cualquier metodo o atributo sera un metodo de clase y no de instancia
    attr_accessor :routes #efinir metodos getter y setter para cambiar @routes desde fuera de la clase

    def draw(&block)
      instance_eval(&block)
    end

    def get(path, to:)
      @routes << { path: path, verb: "GET", to: to }
    end

    def post(path, to:)
      @routes << { path: path, verb: "POST", to: to }
    end

    def delete(path, to:)
      
    end
    
    def patch(path, to:)
      
    end

    def put(path, to:)
      
    end
    
  end

  def self.find_route(path, verb)
    @routes.find { |route| route[:path] == path && route[:verb] == verb }
  end
end
