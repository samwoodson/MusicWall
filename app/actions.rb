# Homepage (Root path)
enable :sessions

helpers do 
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  def current_votes(id)
    Vote.where(song_id: id).count
  end
end

get '/' do
  redirect '/songs'
end

get '/songs' do
  @songs = Song.select("songs.id, songs.link, songs.title, songs.artist, count(votes.id) AS votes_count").
  joins(:votes).group("songs.id").order('votes_count DESC')
  erb :'songs/index'
end

get '/songs/new' do
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

get '/users/login' do
  erb :'users/login'
end

get '/users/new_user' do
  erb :'users/new_user'
end

get '/users/home' do
  erb :'users/home'
end

get '/users/logout' do
  session[:user_id] = nil if current_user
  redirect '/'
end

post '/users/login' do
  user = User.find_by(email: params[:email])

  if user && user.password == params[:password]
    session[:user_id] = user.id
    redirect '/'
  else
    # implement @login_error
    redirect '/'
  end
end

post '/users/new_user' do
  user = User.new(
    email: params[:email],
    password: params[:password]
    )
  user.save
  redirect '/users/login'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    link: params[:link],
    artist: params[:artist],
    user_id: current_user.id
  )
  @song.save
  redirect '/songs'
end

post '/songs/upvote/:id' do
  @upvote = Vote.new(
    user_id: current_user.id,
    song_id: params[:id]
    )
  @upvote.save
  redirect "/songs/#{params[:id]}"
end