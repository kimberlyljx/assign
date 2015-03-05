enable :sessions

helpers do
  def current_user
    if session[:user_id]
      User.find session[:user_id]
    else
      nil
    end
  end

  def logged_in?
    if current_user
      true
    else
      false
    end
  end
end

before do
  pass if ["/", "/users/sign_up", "/users/login"].include?request.path
  redirect '/' unless logged_in?
end

get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/decks' do
  @user = current_user
  if @user
    @decks = Deck.all
    erb :decks
  else
    redirect to '/'
  end
end

post '/decks' do
  @deck = Deck.create(params[:deck])
  erb :decks
end

# e.g., /q6bda
get '/decks/:deck_id' do
  @deck_id = params[:deck_id]
  @deck = Deck.where(id: @deck_id).first
  @deck.increment!(:round_count)
  if Round.all.count > 0
  @rounds = Round.all.where(deck_id: @deck_id)
  end
  erb :rounds
end

post '/users/sign_up' do
  @user = User.create(params[:user])
  # @user = User.create(username: params[:username],
   # email: params[:email], password: params[:password])
  session[:user_id] = @user.id
  erb :decks
end

post '/users/login' do
  @user = User.authenticate(params[:user][:username], params[:user][:password])
  if @user
    session[:user_id] = @user.id
    redirect to '/decks'
  else
    redirect to '/'
  end
end

delete '/logout' do
  session.clear
  redirect to '/'
end

post '/round' do
  @n = 0
  @round = Round.create(deck_id: 1)
  @deck = Deck.where(id: 1).first
  z = @deck

  erb :plays
end

post '/play' do
  if card[other] == @d.other
    puts "correct"
    @round.total_card += 1
    @round.total_correct += 1
  else
    puts "wrong"
    @round.total_card += 1
    @round.total_incorrect += 1
    erb :plays
  end
end
