require 'user'

describe User do

  # let(:user) { double(user) }

  context '.create' do

    it 'creates a user with a name' do
      user = User.create(name: "Neha Singh", email: "myemail@test.com", password: "password")
      expect(user.name).to eq("Neha Singh")
    end

    it 'creates a user with an email address' do
      user = User.create(name: "Neha Singh", email: "myemail@test.com", password: "password")
      expect(user.email).to eq("myemail@test.com")
    end

    it 'creates a user with a password' do
      user = User.create(name: "Neha Singh", email: "myemail@test.com", password: "password")
      expect(user.password).to eq("password")
    end
  end

  context '.authenticate' do

    it 'authenticates a user and returns true if the user exists' do
      User.create(name: "Neha Singh", email: "myemail@test.com", password: "password")
      expect(User.authenticate(email: "myemail@test.com", password: "password")).to be true
    end

    it 'authenticates a user and returns false if the user does not exist' do
      User.create(name: "Neha Singh", email: "myemail@test.com", password: "password")
      expect(User.authenticate(email: "email@hello.com", password: "12345")).to be false
    end
  end
end
