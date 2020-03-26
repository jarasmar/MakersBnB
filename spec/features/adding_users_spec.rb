# frozen_string_literal: true

feature 'sign up' do
  scenario 'users can sign up for MakersBnB' do
    visit '/'
    click_button('Sign Up')
    sign_up_1
    expect(current_path).to eq '/sign_in'
    expect(page).to have_content('Please Sign In')
  end
end
