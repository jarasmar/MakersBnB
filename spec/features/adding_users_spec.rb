feature 'sign up' do
  scenario 'users can sign up for MakersBnB' do
    visit '/'
    click_button('Sign Up')
    sign_up
    expect(current_path).to eq '/user'
    expect(page).to have_content("Welcome, Neha Singh!")
  end
end
