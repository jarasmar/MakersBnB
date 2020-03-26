# frozen_string_literal: true

require 'pg'
require_relative 'database_connection'

class User
  attr_reader :user_id, :name, :email, :password

  def initialize(user_id:, name:, email:, password:)
    @user_id = user_id
    @name = name
    @email = email
    @password = password
  end

  def my_bookings(status:)
    Booking.my_bookings(user_id: @user_id, status: status)
  end

  def my_space_bookings(status:)
    Booking.my_space_bookings(user_id: @user_id, status: status)
  end

  def self.create(name:, email:, password:)
    result = DatabaseConnection.query("INSERT INTO users (name, email, password) VALUES('#{name}', '#{email}', '#{password}') RETURNING user_id, name, email, password;")
    User.new(user_id: result[0]['user_id'], name: result[0]['name'], email: result[0]['email'], password: result[0]['password'])
  end

  def self.authenticate(email:, password:)
    unless exists(email: email)
      return false
    end # checks if a user with this email exists in our database

    if correct_password(email: email, password: password) # if the password if correct it will return true, if not correct, it will return false
      true
    else
      false
    end
  end

  def self.sign_in(email:, password:)
    if User.authenticate(email: email, password: password) == true
      result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'")
      @user = User.new(user_id: result[0]['user_id'], name: result[0]['name'], email: result[0]['email'], password: result[0]['password'])
    else
      'Log In Unsuccessful'
    end
  end

  def sign_out
    @user = nil
  end

  def self.find_id(email:)
    result = DatabaseConnection.query("SELECT user_id FROM users WHERE email = '#{email}'")
    result[0]['user_id']
  end

  def self.find(user_id:)
    result = DatabaseConnection.query("SELECT * FROM users WHERE user_id = '#{user_id}'")
    User.new(
      user_id: result[0]['user_id'],
      name: result[0]['name'],
      email: result[0]['email'],
      password: result[0]['password']
    )
  end

  def self.instance
    @user
  end

  private

  def self.exists(email:)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'")
    if result.ntuples == 1
      true
    end # ntuples is the number of rows returned from our query (if an entry exists we should return 1 row)
  end

  def self.correct_password(email:, password:)
    result = DatabaseConnection.query("SELECT password FROM users WHERE email = '#{email}'")
    result[0]['password'] == password
  end
end
