require 'spec_helper'

require 'net/http'
require 'iconv'

describe 'Translate Google Api' do
  class BeTraslateGoogleApiContent
    def initialize(expected)
      @expected = expected
    end

    def matches?(actual)
      @actual = actual

      (actual['sentences'].is_a? Array) &&
      (actual['sentences'].length == 1) &&
      (actual['sentences'][0]['trans'] == @expected) &&

      (actual['dict'].blank?) ||
      (actual['dict'].is_a? Array)
    end

    def failure_message
      "expected translated word '#{@expected}' but got content '#{@actual}'"
    end

    def negative_failure_message
      "expected something else then translated word '#{@expected}' but got content '#{@actual}'"
    end
  end

  def be_api_content(expected)
    BeTraslateGoogleApiContent.new(expected)
  end

  def get_prepared_content(response)
    # hack (I don't know how making this nice)
    content = Iconv.iconv('UTF-8', 'KOI8-R', response.body)
    if content.present?
      content = JSON.parse(content[0])
    else
      nil
    end
  end

  before :all do
    @googleapi_url = 'http://translate.google.ru/translate_a/t?client=x&text=%{text}&sl=en&tl=ru'
  end

  it 'should translatiog "world"' do
    uri = URI(@googleapi_url % {
      text: 'world'
    })
    response = Net::HTTP.get_response(uri)

    content = get_prepared_content(response)

    true.should be_false unless content
    content.should be_api_content('мир')
  end

  it 'should translation "hello world"' do
    uri = URI(@googleapi_url % {
      text: 'hello world'.sub(' ', '%20')
    })
    response = Net::HTTP.get_response(uri)

    content = get_prepared_content(response)

    true.should be_false unless content
    content.should be_api_content('привет мир')
  end
end
