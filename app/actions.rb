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

before do
  @user = nil
  if session[:user_id]
    @user = User.find(session[:user_id])
  end
end

get '/' do
  redirect '/songs'
end

get '/songs' do
  @songs = Song.all.to_a
  @songs.sort_by!{ |song| -song.votes.count }
  erb :'songs/index'
end

get '/songs/new' do
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find params[:id]
  @reviews = Review.where(song_id: params[:id]).order('created_at DESC')
  erb :'songs/show'
end

get '/users/login' do
  if params[:redirect]
    session[:redirect] = params[:redirect]
  end
  erb :'users/login'
end

get '/users/new_user' do
  erb :'users/new_user'
end

get '/users/home' do
  @songs = Song.where(user_id: current_user.id)
  erb :'users/home'
end

get '/users/logout' do
  session[:user_id] = nil if current_user
  session[:redirect] =  nil
  redirect '/'
end

post '/users/login' do
  user = User.find_by(email: params[:email])
  if user.password == params[:password]
    session[:user_id] = user.id
    if session[:redirect]
      redirect session[:redirect]
    else
      redirect '/'
    end
  else
    # implement @login_error
    redirect '/users/login'
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
    user_id: @user.id
  )
  @song.save
  redirect '/songs'
end

post '/songs/upvote/:id' do
  @upvote = Vote.new(
    user_id: @user.id,
    song_id: params[:id]
    )
  @upvote.save
  redirect "/songs/#{params[:id]}"
end

delete '/reviews/delete/:id' do
  song_id = Review.find(params[:id]).song_id
  Review.find(params[:id]).destroy
  redirect "/songs/#{song_id}"
end

post '/reviews/new/:id' do
  @review = Review.new(
    user_id: @user.id,
    song_id: params[:id],
    message: params[:message],
    stars: params[:rating]
    )
  @review.save
  redirect "/songs/#{params[:id]}"
end


