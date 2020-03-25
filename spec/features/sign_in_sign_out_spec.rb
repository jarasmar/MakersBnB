feature 'sign_in' do
  scenario 'user can sign in' do
    sign_up
    sign_in
    expect(page).to have_content 'Welcome, Neha Singh!'
  end
end

feature 'sign out' do
  scenario 'user can sign out' do
    sign_up
    sign_in
    sign_out
    expect(page).not_to have_content 'Welcome, Neha Singh!'
  end
end
