# frozen_string_literal: true

require 'pg'
require_relative 'database_connection'

class Space
  attr_reader :space_id, :space_name, :description, :price, :user_id, :available
  def initialize(space_id:, space_name:, description:, price:, user_id:)
    @space_id = space_id
    @space_name = space_name
    @description = description
    @price = price
    @user_id = user_id
    @available = true
  end

  def self.create(space_name:, description:, price:, user_id:)
    result = DatabaseConnection.query("INSERT INTO spaces (space_name, description, price, user_id) VALUES('#{space_name}', '#{description}', '#{price}','#{user_id}') RETURNING space_id, space_name, description, price, user_id, available;")
    Space.new(space_id: result[0]['space_id'], space_name: result[0]['space_name'], description: result[0]['description'], price: result[0]['price'], user_id: result[0]['user_id'])
  end

  def self.all
    DatabaseConnection.query("SELECT * FROM spaces;")
  end

  def self.book(space_id:)
    DatabaseConnection.query("UPDATE spaces SET available = FALSE WHERE space_id = '#{space_id}';")
    @available = false
  end



end
