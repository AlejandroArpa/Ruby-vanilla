require 'swagger/blocks'

class SwaggerSetup
  include Swagger::Blocks

  swagger_root do
    key :openapi, '3.0.0'  # Usando OpenAPI 3.0 correctamente, sin 'swagger'
    info do
      key :version, '1.0.0'
      key :title, 'My API'
      key :description, 'API documentation for my app.'
    end
    key :host, 'localhost:3000'  # Verifica que esté correctamente configurado el host
    key :basePath, '/'
  end

  swagger_path '/users' do
    operation :get do
      key :description, 'Returns all users'
      key :operationId, 'findUsers'
      key :produces, ['application/json']
      key :tags, ['user']
      response 200 do
        key :description, 'User response'
        schema type: :array do
          items do
            key :'$ref', :User
          end
        end
      end
    end
  end

  swagger_schema :User do
    key :required, [:id, :name]
    property :id do
      key :type, :integer
      key :format, :int64
    end
    property :name do
      key :type, :string
    end
  end
end
