require 'rack'
require_relative 'app/app'
require_relative 'app/middlewares/RouterMiddleware'

use RouterMiddleware

run MyAPI.new