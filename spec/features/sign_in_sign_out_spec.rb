# frozen_string_literal: true

feature 'sign_in' do
  scenario 'user can sign in' do
    sign_up_1
    sign_in_1
    expect(page).to have_content 'Welcome, Neha Singh!'
  end
end

feature 'sign out' do
  scenario 'user can sign out' do
    sign_up_1
    sign_in_1
    sign_out
    expect(page).not_to have_content 'Welcome, Neha Singh!'
  end
end
