
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'rack/test'
require_relative '../../config/routes'

class RouterTest < Minitest::Test
  def setup
    # Restablece las rutas antes de cada prueba
    Router.routes = []
  end

  def test_register_get_route
    Router.get('/users', to: 'users#getAllUsers')

    assert_equal 1, Router.routes.size
    assert_equal '/users', Router.routes.first[:path]
    assert_equal 'GET', Router.routes.first[:verb]
    assert_equal 'users#getAllUsers', Router.routes.first[:to]
  end

  def test_register_post_route
    Router.post('/users', to: 'users#create')

    assert_equal 1, Router.routes.size
    assert_equal '/users', Router.routes.first[:path]
    assert_equal 'POST', Router.routes.first[:verb]
    assert_equal 'users#create', Router.routes.first[:to]
  end

  def test_find_existing_route
    Router.get('/users', to: 'users#getAllUsers')
    
    route = Router.find_route('/users', 'GET')
    
    assert_equal 'users#getAllUsers', route[:to]
  end

  def test_find_non_existing_route
    Router.get('/users', to: 'users#getAllUsers')
    
    route = Router.find_route('/posts', 'GET')
    
    assert_nil route
  end
end