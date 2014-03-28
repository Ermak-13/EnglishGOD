User.create!(
  email: 'guest@gmail.com',
  password: 'TQFul5nI9f',
  confirmed_at: Time.now(),
  role: User::ROLES.fetch(:guest)
)