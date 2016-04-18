# Homepage (Root path)
get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  erb :'songs/new'
end

post '/songs' do
  
  @song = Song.new(
    title: params[:title],
    link: params[:link],
    artist: params[:artist]
  )
  @song.save
  @song.update(link: @song.youtube_embed)
  redirect '/songs'
end