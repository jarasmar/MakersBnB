require 'user'

describe User do

  context '.create' do
    it 'creates a user with a name' do
      user = User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      expect(user.name).to eq('Neha Singh')
    end

    it 'creates a user with an email address' do
      user = User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      expect(user.email).to eq('myemail@test.com')
    end

    it 'creates a user with a password' do
      user = User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      expect(user.password).to eq('password')
    end
  end

  context '.authenticate' do
    it 'authenticates a user and returns true if the user exists and password is correct' do
      User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      expect(User.authenticate(email: 'myemail@test.com', password: 'password')).to be true
    end

    it 'authenticates a user and returns false if the user exists but wrong password' do
      User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      expect(User.authenticate(email: 'myemail@test.com', password: '12345')).to be false
    end

    it 'authenticates a user and returns false if the user does not exist' do
      User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      p 'authenticating false user'
      expect(User.authenticate(email: 'email@hello.com', password: '12345')).to be false
    end
  end

  context '.sign_in' do
    it 'a user can sign in' do
      User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      user = User.sign_in(email: 'myemail@test.com', password: 'password')
      expect(user.name).to eq 'Neha Singh'
    end
  end

  context '.sign_out' do
    it 'user can sign out' do
      User.create(name: 'Neha Singh', email: 'myemail@test.com', password: 'password')
      user = User.sign_in(email: 'myemail@test.com', password: 'password')
      expect(user.sign_out).to eq nil
    end
  end
end
