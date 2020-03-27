require 'space'
require 'user'

describe Space do

  context '.create' do
    it 'creates a new space' do
      user = User.create(name: 'Jara', email: 'testemail.test.com', password: 'password')
      space = Space.create(space_name: 'Jara home', description: 'Nice Cozy room', price: 40.00, user_id: user.user_id)
      expect(space.space_name).to eq 'Jara home'
    end
  end

  context '.all' do
    it 'knows the list of available spaces' do
      user = User.create(name: 'Jara', email: 'testemail.test.com', password: 'password')
      Space.create(space_name: 'Jara home', description: 'Nice Cozy room', price: 40.00, user_id: user.user_id)
      Space.create(space_name: 'Ben flat', description: 'Bright and airy, 2 beds', price: 75.00, user_id: user.user_id)
      spaces = Space.all
      expect(spaces[0]['space_name']).to eq 'Jara home'
      expect(spaces[0]['description']).to eq 'Nice Cozy room'
      expect(spaces[0]['price']).to eq '40.00'
      expect(spaces[1]['space_name']).to eq 'Ben flat'
      expect(spaces[1]['description']).to eq 'Bright and airy, 2 beds'
      expect(spaces[1]['price']).to eq '75.00'
    end
  end

  context '.book' do
    it 'knows when it is booked' do
      user = User.create(name: 'Jara', email: 'testemail.test.com', password: 'password')
      space = Space.create(space_name: 'Jara home', description: 'Nice Cozy room', price: 40.00, user_id: user.user_id)
      Space.book(space_id: space.space_id)
      spaces = Space.all
      expect(spaces[0]['available']).to eq 'f'
    end
  end
end
