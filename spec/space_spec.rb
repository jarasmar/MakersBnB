# frozen_string_literal: true

require 'space'
require 'user'

describe Space do
  describe '.create' do
    it 'creates a new space' do
      user = User.create(name: 'Jara', email: 'testemail.test.com', password: 'password')
      space = Space.create(space_name: 'Jara home', description: 'Nice Cozy room', price: 40, user_id: 1)
      expect(space.space_name).to eq 'Jara home'
    end
  end
end
