require 'spec_helper'
require 'capybara/rspec'

module TestUser
  def test_user
    @test_user ||= User.create!(
      email: "mail@example.com",
      password: "Pa$$w0rd",
      confirmed_at: Time.now()
    )
  end
end

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include TestUser

  config.before(:each) do
    Warden.test_mode!
  end

  config.after(:each) do
    Warden.test_reset!
  end
end