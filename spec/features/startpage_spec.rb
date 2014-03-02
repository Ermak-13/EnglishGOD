require 'capybara_spec_helper'

feature 'Visit start page' do
  scenario 'unathorized user' do
    visit '/'
    page.has_field?('translation[text]').should be_true
    page.has_selector?('#info-for-unauthorized-user').should be_true
  end

  scenario 'authorized user' do
    login_as test_user
    visit '/'
    page.has_field?('translation[text]').should be_true
    page.has_selector?('#last-words').should be_true
  end

  scenario 'pass params' do
    visit '/?text=world'
    page.has_field?('translation[text]').should be_true
    page.has_selector?('#translated-word').should be_true
    page.has_text?('world').should be_true
  end
end