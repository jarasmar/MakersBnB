# frozen_string_literal: true

require 'pg'
require_relative 'database_connection' 

class Space
  attr_reader :space_id, :space_name, :description, :price, :user_id
  def initialize(space_id:, space_name:, description:, price:, user_id:)
    @space_id = space_id
    @space_name = space_name
    @description = description
    @price = price
    @user_id = user_id
    @available = true
  end

  def self.create(space_name:, description:, price:, user_id:)
    # connection = if ENV['ENVIRONMENT'] == 'test'
    #                PG.connect(dbname: 'makersbnb_test')
    #              else
    #                PG.connect(dbname: 'makersbnb')
    #                end
    result = DatabaseConnection.query("INSERT INTO spaces (space_name, description, price,user_id) VALUES('#{space_name}', '#{description}', '#{price}','#{user_id}') RETURNING space_id, space_name, description, price, user_id, available;")
    Space.new(space_id: result[0]['space_id'], space_name: result[0]['space_name'], description: result[0]['description'], price: result[0]['price'], user_id: result[0]['user_id'])
  end
end
