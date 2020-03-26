feature 'show spaces' do
  scenario 'user can see all spaces' do
    setup
    sign_out
    visit '/'
    expect(first('.space')).to have_content('Jara home')
    expect(first('.space')).to have_content('Nice Cozy room')
    expect(first('.space')).to have_content('40.00')
  end

  scenario 'user sees only available spaces' do 
    setup
    book_space
    expect(first('.space')).not_to have_content('Jara home')
    expect(first('.space')).not_to have_content('Nice Cozy room')
    expect(first('.space')).not_to have_content('40.00')
  end
end
