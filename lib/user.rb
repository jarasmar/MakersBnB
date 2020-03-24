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

  def self.create(name:, email:, password:)
    # if ENV['ENVIRONMENT'] == 'test'
    #   connection = PG.connect(dbname: 'makersbnb_test')
    # else
    #   connection = PG.connect(dbname: 'makersbnb')
    # end
    result = DatabaseConnection.query("INSERT INTO users (name, email, password) VALUES('#{name}', '#{email}', '#{password}') RETURNING user_id, name, email, password;")
    User.new(user_id: result[0]['user_id'], name: result[0]['name'], email: result[0]['email'], password: result[0]['password'])
  end

  def self.authenticate(email:, password:)
    return false unless exists?(email: email)
    result = DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'")
    p result[0]
    p result[0]['password']
    result[0]['password'] == password ? true : false
  end

private

  def self.exists?(email:)
    !DatabaseConnection.query("SELECT * FROM users WHERE email = '#{email}'") == nil
  end
end
