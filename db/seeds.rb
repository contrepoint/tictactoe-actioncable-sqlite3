# Users
['a@a.com', 'b@b.com', 'c@c.com'].each do |email|
  User.create(email: email, password: '123456', password_confirmation: '123456')
end
