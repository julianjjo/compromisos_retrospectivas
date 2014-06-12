# myapp.rb
require 'sinatra'
require 'digest'
require 'data_mapper'

set :root, File.dirname(__FILE__)
set :public_folder, Proc.new { File.join(root, "public") }
set :views, Proc.new { File.join(root, "vistas") }
set :environment, :development
enable :sessions
set :sessions, true

DataMapper.setup :default, "sqlite://#{Dir.pwd}/database.db"

class Compromiso
  include DataMapper::Resource
  property :id, 			Serial
  property :compromiso, 		Text
  property :realizado,        	Boolean,  :default => false
end

DataMapper.auto_migrate!
DataMapper.auto_upgrade!

get "/" do
  erb :index
end

post '/logueo' do 
	if params[:usuario] == 'admin' && params[:contrasena] == 'locxue2540'		
		session[:usuario] = 'admin'
		session[:contrasena] = 'locxue2540'
		return "ingreso"
	else		
		return "noingreso"
	end
end

get '/home' do
	if session[:usuario].nil? && session[:contrasena].nil?
		redirect '/'
	else
		@compromisos = Compromiso.all
		erb :home		
	end
end

get '/crearcompromiso' do
	if session['usuario'].nil? && session['contrasena'].nil?
		redirect '/'
	else		
		erb :crearcompromiso	
	end
end

post '/crearcompromiso' do
	if session[:usuario].nil? && session[:usuario].nil?
		redirect '/'
	else	
		compromiso = Compromiso.create(:compromiso => params[:compromiso])	
		redirect '/home'	
	end
end

put '/actualizarealizado' do
	if session[:usuario].nil? && session[:usuario].nil?
		redirect '/'
	else	
		@compromisos = Compromiso.all
		@compromisos.each do |compromiso|
			if params["realizado-#{compromiso.compromiso}"] == "on"
				zoo  = Compromiso.first(:compromiso => compromiso.compromiso)  
				zoo.update(:realizado => true)	
			else 
				zoo  = Compromiso.first(:compromiso => compromiso.compromiso) 
				zoo.update(:realizado => false)	
			end
		end
		
		redirect '/home'	
	end
end