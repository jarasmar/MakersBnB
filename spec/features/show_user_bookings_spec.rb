feature 'show user bookings' do
  scenario 'users can view their bookings' do
    setup
    visit '/'
    click_button('log in')
    log_in
    click_button('my bookings')
    expect(current_path).to eq '/bookings/:user_id'
    expect(first('.pending')).to have_content('Jara home')
  end
end