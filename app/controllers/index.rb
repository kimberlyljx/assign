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
  @user = current_user
  @deck = Deck.create(name: params[:name], user_id: @user.id)
  erb :cards
end

post '/cards' do
  @deck = Deck.find(params[:deck_id])
  @card = Card.create(english: params[:english], other: params[:other], deck_id: params[:deck_id])
  erb :cards
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
  session[:user_id] = @user.id
  @decks = Deck.all
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
  @round = Round.create(deck_id: params[:deck_id])
  @deck = Deck.find(params[:deck_id])
  erb :plays
end

post '/play' do
  @deck = Deck.find(params[:current_deck_id])
  @round = Round.find(params[:round_id])

  if params[:other] == params[:word]
    puts "correct"
    @round.total_card += 1
    @round.total_correct += 1
    @round.total_guess += 1
    @round.save
    byebug
    redirect to "/decks"
  else
    puts "wrong"
    @round.total_guess += 1
    @round.total_card += 1
    @round.total_incorrect += 1
    @round.save
    erb :plays
  end
end

get '/logout' do
  session.clear
end
