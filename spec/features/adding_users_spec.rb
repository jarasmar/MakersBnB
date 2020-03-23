feature 'sign up' do
  scenario 'users can sign up for MakersBnB' do
    visit '/'
    sign_up
    expect(page).to have_content("Welcome, Neha Singh!")
  end
end
