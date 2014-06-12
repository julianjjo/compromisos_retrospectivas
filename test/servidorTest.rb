ENV['RACK_ENV'] = 'test'

require '../servidor'
require 'minitest/autorun'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Retrospectiva compromisos" do
  it "ingresar a la aplicacion" do
    get '/'
    assert last_response.ok?
  end
  it "se ingresa a la dirrecion de logueo con el metodo post" do
    post '/logueo'
    assert last_response.ok?
  end
  it "no ingreso a la aplicacion" do
    post '/logueo', {:usuario => "" , :contrasena => ""}
    assert_equal 'noingreso', last_response.body
  end
  it "ingreso a la aplicacion" do
    post '/logueo', {:usuario => "admin" , :contrasena => "locxue2540"}
    assert_equal 'ingreso', last_response.body
  end
  it "no tener acceso a la pagina inicial" do
    get '/home'
    assert_equal 302, last_response.status
  end
  it "no tener acceso a formulario crear compromiso de retrospectiva" do
    get '/crearcompromiso'
    assert_equal 302, last_response.status
  end
  it "no tener acceso a crear compromiso de retrospectiva" do
    post '/crearcompromiso'
    assert_equal 302, last_response.status
  end
  it "actualizar si esta o no realizado de compromiso" do
    put '/actualizarealizado'
    assert_equal 302, last_response.status
  end
end
