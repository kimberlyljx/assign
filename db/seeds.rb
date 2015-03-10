@user_create = User.create(username: 'kim', password: '123')

@deck = Deck.create(name: "English-Malaysian", user_id: 1)

array = []
IO.foreach("db/english-malaysian.txt") do |x|
  array << x.downcase.split(' ')
end

array.each do |word|
  @card = Card.create(english: word[0], other: word[1], deck_id: 1)
end


