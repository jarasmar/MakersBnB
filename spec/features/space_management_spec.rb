feature 'showing my spaces' do
  scenario 'user can see all their spaces' do
    setup
    visit '/my_spaces'
    expect(page).to have_content("Jara home")
    expect(page).to have_content("40.00")
  end

  scenario 'user can accept a booking' do
    setup
    sign_out
    sign_up_2
    sign_in_2
    book_space
    sign_out
    sign_in_1
    confirm_booking
    expect(first('.confirmed_bookings')).to have_content("Jara home")
    expect(first('.confirmed_bookings')).to have_content("40.00")
  end

  scenario 'user can decline a booking' do
    setup
    sign_out
    sign_up_2
    sign_in_2
    book_space
    sign_out
    sign_in_1
    decline_booking
    expect(first('.declined_bookings')).to have_content("Jara home")
    expect(first('.declined_bookings')).to have_content("40.00")
  end
end
