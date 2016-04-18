# Homepage (Root path)
get '/' do
  redirect '/songs'
end

get '/songs' do
  @songs = Song.all.order(created_at: :desc)
  erb :'songs/index'
end

get '/songs/new' do
  erb :'songs/new'
end

get '/songs/:id' do
  @song = Song.find_by params[:id]
  erb :'songs/show'
end

post '/songs' do
  @song = Song.new(
    title: params[:title],
    link: params[:link],
    artist: params[:artist]
  )
  @song.save
  redirect '/songs'
end