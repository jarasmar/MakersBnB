feature 'show user bookings' do
  scenario 'users can view their bookings' do
    setup
    sign_out
    sign_up_2
    sign_in_2
    book_space
    expect(current_path).to include "/my_bookings/"
    expect(first('.pending')).to have_content('Jara home')
  end
end
