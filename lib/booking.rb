# frozen_string_literal: true

require 'pg'
require_relative 'database_connection'
class Booking
  def initialize(booking_id:, user_id:, space_id:, date:)
    @booking_id = booking_id
    @user_id = user_id
    @space_id = space_id
    @date = date
  end

  def self.create(user_id:, space_id:, date:)
    result = DatabaseConnection.query("INSERT INTO bookings (user_id , space_id , date) VALUES('#{user_id}', '#{space_id}', '#{date}') RETURNING booking_id, user_id , space_id , date;")
    Booking.new(booking_id: result[0]['booking_id'], user_id: result[0]['user_id'], space_id: result[0]['space_id'], date: result[0]['date'])
  end
end
