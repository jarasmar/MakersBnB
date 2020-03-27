require 'booking'
require './lib/user'
require './lib/space'

describe Booking do
  context '.create' do
    it 'creates a new booking' do
      user = User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      space = Space.create(space_name: 'Jara home', description: 'Nice Cozy room', price: 40.00, user_id: user.user_id)
      booking = Booking.create(user_id: user.user_id, space_id: space.space_id, date: '2020-03-24')
      expect(booking.user_id).to eq user.user_id
      expect(booking.space_id).to eq space.space_id
      expect(booking.date).to eq '2020-03-24'
    end
  end

  context '.my_spaces' do
    it 'displays pending bookings by default' do
      user = User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      space = Space.create(space_name: 'Jara home', description: 'Nice Cozy room', price: 40.00, user_id: user.user_id)
      booking = Booking.create(user_id: user.user_id, space_id: space.space_id, date: '2020-03-24')
      expect(booking.status).to eq 0 # pending
    end

    it 'displays confirmed bookings' do
      user = User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      space = Space.create(space_name: 'Jara home', description: 'Nice Cozy room', price: 40.00, user_id: user.user_id)
      booking = Booking.create(user_id: user.user_id, space_id: space.space_id, date: '2020-03-24')
      booking = Booking.accept(booking_id: booking.booking_id, space_id: booking.space_id)
      expect(booking.status).to eq '1' # confirmed
    end

    it 'displays declined bookings' do
      user = User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      space = Space.create(space_name: 'Jara home', description: 'Nice Cozy room', price: 40.00, user_id: user.user_id)
      booking = Booking.create(user_id: user.user_id, space_id: space.space_id, date: '2020-03-24')
      booking = Booking.decline(booking_id: booking.booking_id)
      expect(booking.status).to eq '2' # declined
    end
  end
end
