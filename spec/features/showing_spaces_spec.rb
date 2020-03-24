feature 'show spaces' do
  scenario 'user can see all available spaces' do
    create_new_space
    visit '/'
    expect(page).to have_content('Jara home')
    expect(page).to have_content('Nice Cozy room')
    expect(page).to have_content('40.00')
  end
end
