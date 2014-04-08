module TestUser
  def test_user
    @test_user ||= User.create!(
      email: "mail@example.com",
      password: "Pa$$w0rd",
      confirmed_at: Time.now()
    )
  end
end
