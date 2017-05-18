require "bundler/setup"
require 'pry'
require "pry-byebug"

Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
enable  :sessions, :logging

get "/" do
  erb :index
end

post "/attendee/signup" do
  attendee_name = params['name']
  attendee_username = params['username']
  attendee_password = params['password']
  @artists = Artist.all
  @attendee = Attendee.create(:name => attendee_name, :username => attendee_username, :password => attendee_password, :id => nil)
  if @attendee.save
    erb :attendee
  else
    erb :security
  end
end

get "/attendee/signin" do
  erb :attendee_login
end

get "/attendee/:id" do |id|
  @attendee = Attendee.find(id)
  @artists = Artist.all
  @attendee_artist = @attendee.artists
  @artists = Artist.all - @attendee_artist
  erb :attendee
end

post "/attendee/signed-in" do
  @attendee = Attendee.find_by(:username => params.fetch('username'))
  @artists = Artist.all
  if @attendee.password == params.fetch('password')
    session[:user_id] = @attendee.id
    redirect "/attendee/#{@attendee.id}"
  else
    erb :security
  end
end

post "/attendee/:id/add_artist" do
  @attendee = Attendee.find(params['id'])
  @artist = Artist.find(params['artists_id'])
  @attendee.artists.push(@artist)
  @artists = Artist.all
  redirect "/attendee/#{@attendee.id}"
end

delete "/attendee/:id/remove_artist" do
  @attendee = Attendee.find(params['id'])
  artist_id = params["artist_id"]
  @attendee.artists.destroy(Artist.find(artist_id))
  redirect "/attendee/#{@attendee.id}"
end

get "/artist/:id" do
  id = params.fetch('id')
  @artist = Artist.find(id)
  erb :artist
end

get('/attendee/:attendee_id/remove_artist/:artist_id') do |attendee_id, artist_id|
  attendee = Attendee.find(attendee_id)
  artist = Artist.find(artist_id)
  attendee.artists.destroy(artist)
  redirect to("/attendee/#{attendee_id}")
end

# ******** PRODUCER/ADMIN SIDE ********

get "/producer/signin" do
  erb :producer_login
end

post "/producer/signed-in" do
  if @producer = Producer.find_by(:username => params.fetch('username'))
    if @producer.password == params.fetch('password')
      session[:user_id] = @producer.id
      @stages = Stage.all
      @artists = Artist.all
      redirect "/producer/#{@producer.id}"
    else
      @message = "Invalid username or password"
      redirect back
    end
  else
    @message = "Invlaid username or password"
    redirect back
  end
end

get "/producer/signup" do
  erb :producer_create_account
end

post "/producer" do
  producer_data = params.fetch('producer')
  @producer = Producer.create(producer_data)
  if @producer.save
    redirect "/producer/#{@producer.id}"
  else
    @message = "Please enter correct information"
    redirect back
  end
end

get "/producer/:id" do
  @producer = Producer.find(params.fetch('id'))
  @stages = Stage.all
  @artists = Artist.all
  erb :producer
end

get "/producer/:id/add-artists" do |id|
  @producer = Producer.find(id)
  @artists = Artist.all
  erb :producer_add_artists
end

post "/producer/:id/add-artists" do |id|
  artist_data = params.fetch('artist')
  @artist = Artist.create(artist_data)
  redirect back
end


# PRODUCER ARTIST CRUD *********


get "/producer/artist/:id" do |id|
  @stages = Stage.all
  @artist = Artist.find(id)
end

get "/producer/:prod_id/artist/:artist_id" do |prod_id, artist_id|
  @producer = Producer.find(prod_id)
  @stages = Stage.all
  @artist = Artist.find(artist_id)
  erb :producer_artist
end

patch "/producer/:prod_id/artist/:artist_id/update" do |prod_id, artist_id|
  name = params.fetch('name')
  @artist = Artist.find(artist_id)
  @artist.update(name: name)
  redirect "/producer/#{prod_id}"
end





# PRODUCER STAGE CRUD **********

get "/producer/:prod_id/stage/add" do |prod_id|
  @producer = Producer.find(prod_id)
  @stages = Stage.all
  erb :add_stage
end

post "/producer/:prod_id/stage/new" do
  stage_name = params["stage_name"]
  @stage = stage_name
  @new_stage = Stage.create({:name => stage_name})
  if @new_stage.save
    redirect
  else
    redirect back
  end
end

get "/producer/:prod_id/stage/:stage_id" do |prod_id, stage_id|
  @producer = Producer.find(prod_id)
  @stage = Stage.find(stage_id)
  @performances = Performance.all
  erb :producer_stage
end


get '/producer/:prod_id/stage/:stage_id/:artist_id/delete_artist' do |prod_id, stage_id, artist_id|
  producer = Producer.find(prod_id)
  stage = Stage.find(stage_id)
  artist = Artist.find(artist_id)
  stage.artists.destroy(artist)
  redirect to("/producer/#{prod_id}/stage/#{stage_id}")
end


patch "/producer/:prod_id/stage/:stage_id/update" do |prod_id, stage_id|
  name = params.fetch('name')
  @stage = Stage.find(stage_id)

  @stage = Stage.update(name: name)

  @stage.update(name: name)

  redirect "/producer/#{prod_id}"
end

delete "/producer/:prod_id/stage/:stage_id/delete" do |prod_id, stage_id|
  @stage = Stage.find(stage_id)
  @stage.delete
  redirect "/producer/#{prod_id}"
end

get "/producer/:prod_id/stage/:stage_id/add_artists" do |prod_id, stage_id|
  @producer = Producer.find(prod_id)
  @performances = Performance.all
  @stage = Stage.find(stage_id)
  @artists = Artist.all
  erb :add_artists_to_stages
end

patch "/producer/:prod_id/stage/:stage_id/artists" do |prod_id, stage_id|
  @stage = Stage.find(stage_id)
  artist_id = params.fetch('artist_id')
  performance_time = params.fetch('performance_time')
  @stage.performances << Performance.create({:stage_id => stage_id, :artist_id => artist_id, :performance_time => performance_time})
  redirect "/producer/#{prod_id}/stage/#{stage_id}"
end

delete "/producer/:prod_id/delete" do |prod_id|
  stage_id = params.fetch("stage_id")
  Stage.where(id: stage_id).destroy_all
  redirect "/producer/#{prod_id}"
end
