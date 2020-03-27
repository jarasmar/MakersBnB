feature 'sign_in' do
  scenario 'user can sign in' do
    sign_up_1
    fill_in('email', with: 'myemail@test.com')
    fill_in('password', with: 'password')
    click_button('sign_in')
    expect(page).to have_content 'Welcome, Neha Singh!'
  end
end
