require 'user'

describe User do

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

end
