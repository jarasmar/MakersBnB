# frozen_string_literal: true
require 'pg'
require_relative 'database_connection'

class Booking

  attr_reader :booking_id, :user_id, :space_id, :date, :status

  def initialize(booking_id:, user_id:, space_id:, date: date = nil, status: status = 0)
    @booking_id = booking_id
    @user_id = user_id
    @space_id = space_id
    @date = date
    @status = status
  end

  def self.create(user_id:, space_id:, date: date = '2020-03-23')
    result = DatabaseConnection.query("INSERT INTO bookings (user_id , space_id, date ) VALUES('#{user_id}', '#{space_id}', '#{date}') RETURNING booking_id, user_id , space_id , date, status;")
    Booking.new(booking_id: result[0]['booking_id'], user_id: result[0]['user_id'], space_id: result[0]['space_id'], date: result[0]['date'])
  end

  def my_bookings(user_id:, status:)
    DatabaseConnection.query("SELECT * FROM bookings WHERE status = '#{status}';")
  end

  def self.all
    DatabaseConnection.query("Select * FROM bookings;")
  end

  # def self.my_space_bookings(user_id:, status:)
  #   my_spaces = Space.my_spaces(user_id: user_id)
  #   my_spaces.map do |space|
  #     bookings = DatabaseConnection.query("SELECT * FROM bookings WHERE status = '#{status}' AND space_id = '#{space.space_id}';")
  #     bookings.map do |booking|
  #       Booking.new(
  #         booking_id: booking['booking_id'], 
  #         user_id: booking['user_id'], 
  #         space_id: booking['space_id'], 
  #         date: booking['date'],
  #         status: booking['status']
  #       )
  #     end
  #   end
  # end

  def self.my_space_bookings(user_id:, status: )
    bookings = DatabaseConnection.query("SELECT * FROM bookings INNER JOIN spaces ON bookings.space_id = spaces.space_id WHERE spaces.user_id = '#{user_id}' AND bookings.status = '#{status}';")
    bookings.map do |booking|
      Booking.new(
        booking_id: booking['booking_id'], 
        user_id: booking['user_id'], 
        space_id: booking['space_id'], 
        date: booking['date'], 
        status: booking['status']
      )
    end
  end

  def self.my_bookings(user_id:, status: )
    bookings = DatabaseConnection.query("SELECT * FROM bookings WHERE bookings.user_id = '#{user_id}' AND bookings.status = '#{status}';")
    bookings.map do |booking|
      Booking.new(
        booking_id: booking['booking_id'], 
        user_id: booking['user_id'], 
        space_id: booking['space_id'], 
        date: booking['date'], 
        status: booking['status']
      )
    end
  end

  def space
    Space.find_space(space_id: @space_id)
  end

  def user(user_id: user_id = @user_id)
    User.find(user_id: user_id)
  end

  def self.accept(booking_id:, space_id:)
    Space.book(space_id: space_id)
    result = DatabaseConnection.query("UPDATE bookings SET status = '1' WHERE booking_id = #{booking_id} RETURNING booking_id, user_id, space_id, date, status;")
    Booking.new(
      booking_id: result[0]['booking_id'], 
      user_id: result[0]['user_id'], 
      space_id: result[0]['space_id'], 
      date: result[0]['date'], 
      status: result[0]['status']
    )
  end

  def self.decline(booking_id:)
    result = DatabaseConnection.query("UPDATE bookings SET status = '2' WHERE booking_id = #{booking_id} RETURNING booking_id, user_id, space_id, date, status;")
    Booking.new(
      booking_id: result[0]['booking_id'], 
      user_id: result[0]['user_id'], 
      space_id: result[0]['space_id'], 
      date: result[0]['date'], 
      status: result[0]['status']
    )
  end
end
