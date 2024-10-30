require_relative '../../config/swagger'

class SwaggerController
  def doc(_env)
    [200, { 'Content-Type' => 'application/json' }, [Swagger::Blocks.build_root_json([SwaggerSetup])]]
  end
end