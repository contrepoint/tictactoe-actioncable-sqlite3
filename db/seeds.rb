# Users
['a@a.com', 'b@b.com', 'c@c.com'].each do |email|
  User.create(email: email, password: '123456', password_confirmation: '123456')
end

# Games
Game.create!(challenger_id: 1, challenged_id: 2, status: 'challenge accepted', challenger_user_marker: 'x', challenged_user_marker: 'o', active_player_id: 1)
Game.create!(challenger_id: 1, challenged_id: 3, status: 'challenge accepted', challenger_user_marker: 'x', challenged_user_marker: 'o', active_player_id: 1)
Game.create!(challenger_id: 2, challenged_id: 1, status: 'challenge accepted', challenger_user_marker: 'x', challenged_user_marker: 'o', active_player_id: 1)