feature 'show spaces' do
  scenario 'user can see all available spaces' do
    visit '/sign_up'
    sign_up
    create_new_space
    visit '/'
    expect(first('.space')).to have_content('Jara home')
    expect(first('.space')).to have_content('Nice Cozy room')
    expect(first('.space')).to have_content('40.00')
  end
end
