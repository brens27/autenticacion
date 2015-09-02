get '/' do
@user = User.all
  erb :index
end

get '/registration' do

	erb :registration
end

post '/registration' do
	user_name = params[:name]
	user_email = params[:email]
	user_password = params[:password]
	p params
	@registration = User.new(name: user_name, email: user_email, password: user_password)
	if @registration.save
		session[:user_id] = @registration.id
		erb :user_home
	else
		redirect '/registration'
	end
end


get '/login' do
	erb :user_home
end

post '/login' do
	@user = User.all
	user_email = params[:user_email]
	user_password = params[:user_password]
	registration = User.authenticate(user_email, user_password)
		if registration 
			id = registration.id
 			redirect ("/user_home/#{id}")
		end
	session[:user_id] = registration.id
	erb :user_home
end

get '/edit_user/:id' do 
	id = params[:id]
	@user = User.find(id)
	
	erb :edit_user
end

post '/edit_user/:id' do
	name = params[:name]
	last_name = params[:last_name]
	email = params[:email]
	password = params[:password]
	user_id = params[:id]

	@user = User.find(user_id)
	@user.name = name
	@user.last_name = last_name
	@user.email = email
	@user.password = password
	@user.save
	redirect("/show_user/#{user_id}")

	# erb :show_user
end

get '/show_user/:id' do
	id = params[:id]
	@user = User.find(id)
	erb :show_user
end

get '/user_home/:id' do
	id = params[:id]
	@user = User.find(id)
 erb :user_home
end

get '/delete_user/:id' do
	delete = params[:id]
	delete_user = User.find(delete)
	delete_user.destroy

	erb :delete_user
end

get '/logout' do 
	session.clear
	redirect '/'
end