feature 'showing my spaces' do
  scenario 'user can see all their spaces' do
    setup
    visit '/my_spaces'
    expect(page).to have_content("Jara home")
    expect(page).to have_content("40.00")
  end

  scenario 'user can accept a booking' do
    setup
    visit '/my_spaces/manage'
    click_button('accept')
    expect(first('.pending')).not_to have_content("Jara home")
    expect(first('.pending')).not_to have_content("40.00")
    expect(first('.accepted')).to have_content("Jara home")
    expect(first('.accepted')).to have_content("40.00")
  end

  scenario 'user can decline a booking' do
    setup
    visit '/my_spaces/manage'
    click_button('decline')
    expect(first('.pending')).not_to have_content("Jara home")
    expect(first('.pending')).not_to have_content("40.00")
    expect(first('.declined')).to have_content("Jara home")
    expect(first('.declined')).to have_content("40.00")
  end
end
