email = 'guest@gmail.com'
if not User.exists?(email: email)
    User.create!(
      email: email,
      password: 'TQFul5nI9f',
      confirmed_at: Time.now(),
      role: User::ROLES.fetch(:guest)
    )
end
