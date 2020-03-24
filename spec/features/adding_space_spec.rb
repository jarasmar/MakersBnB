# frozen_string_literal: true

feature ' creating spaces' do
  scenario 'user can create a new space' do
    visit('/create_space')
    fill_in('name', with: 'Jara home')
    fill_in('description', with: 'Nice Cozy room')
    fill_in('price', with: 40)
    fill_in('email', with: 'testemail@test.com')
    fill_in('password', with: 'password')
    click_button('Submit')
    expect(page).to have_content 'Jara home'
  end
end
