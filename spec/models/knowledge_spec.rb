require 'spec_helper'

describe Knowledge do
  describe '.validate method' do
    before :each do
      @valid_attributes = {
        translation_id: 1,
        user_id: 1,
        dictionary_id: 1,
        rating: 10,
        level: 10
      }
    end

    it 'should be valid' do
      knowledge = Knowledge.new(@valid_attributes)
      knowledge.valid?().should be_true
    end

    it 'should be invalid' do
      situations = [
        {translation_id: nil},
        {user_id: nil},
        {dictionary_id: nil},

        {level: -1},
        {level: 101},
      ]

      situations.each do |situation|
        knowledge = Knowledge.new(@valid_attributes.merge(situation))
        knowledge.valid?().should be_false
      end
    end
  end
end
