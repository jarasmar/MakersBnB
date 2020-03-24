# frozen_string_literal: true

feature 'testing infrastructure' do
  scenario 'testing setup working' do
    visit '/'
    expect(page).to have_content('Welcome to MakersBnB!')
  end
end
