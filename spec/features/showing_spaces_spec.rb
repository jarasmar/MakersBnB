feature 'show spaces' do
  scenario 'user can see all spaces' do
    setup
    sign_out
    visit '/'
    expect(first('.space')).to have_content('Jara home')
    expect(first('.space')).to have_content('Nice Cozy room')
    expect(first('.space')).to have_content('40.00')
  end

  scenario 'user sees only available spaces' do
    setup
    sign_out
    sign_up_2
    sign_in_2
    book_space
    sign_out
    sign_in_1
    confirm_booking
    sign_out
    sign_in_2
    expect(page).not_to have_content('Jara home')
    expect(page).not_to have_content('Nice Cozy room')
    expect(page).not_to have_content('40.00')
  end
end
