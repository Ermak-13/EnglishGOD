require 'spec_helper'

feature 'Visit start page' do
  scenario 'unathorized user' do
    visit '/dictionary'
    current_path.should eq('/users/sign_in')
  end

  scenario 'authorized user' do
    login_as test_user

    word = 'world'
    trans = 'мир'
    dictionary = test_user.dictionary
    dictionary.stub(:google_translate) {
      GoogleApi::response({
        trans: trans,
        orig: word,
        translit: 'mir'
      })
    }
    dictionary.translate(word)

    visit '/dictionary'

    page.has_text?(@word).should be_true
    page.has_text?(@trans).should be_true
  end
end
