feature ' creating spaces' do
  scenario 'user can create a new space' do
    sign_up_1
    sign_in_1
    create_new_space
    expect(page).to have_content 'Jara home'
  end
end
