# frozen_string_literal: true

feature ' creating spaces' do
  scenario 'user can create a new space' do
    create_new_space
    expect(page).to have_content 'Jara home'
  end
end
