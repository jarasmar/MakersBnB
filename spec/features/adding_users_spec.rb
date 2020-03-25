feature 'sign up' do
  scenario 'users can sign up for MakersBnB' do
    visit '/'
    click_button('Sign Up')
    sign_up
    expect(current_path).to eq '/sign_in'
    expect(page).to have_content("Please Sign In")
  end
end
