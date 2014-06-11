# myapp.rb
require 'sinatra'
require 'digest'
require 'data_mapper'

set :public_folder, 'publico'
set :environment, :development
set :sessions, true

get "/" do
  erb :index
end

post '/logueo' do 
	if params[:usuario] == 'admin' && params[:contrasena] == 'locxue2540'
		return "ingreso"
		session[:usuario] = 'admin'
		session[:contrasena] = 'locxue2540'
	else		
		return "noingreso"
	end
end

get '/home' do
	erb :home
end