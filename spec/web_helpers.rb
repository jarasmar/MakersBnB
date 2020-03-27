def sign_up_1
  visit '/sign_up'
  fill_in('name', with: 'Neha Singh')
  fill_in('email', with: 'myemail@test.com')
  fill_in('password', with: 'password')
  click_button('Submit')
end

def sign_up_2
  visit '/sign_up'
  fill_in('name', with: 'Ben')
  fill_in('email', with: 'ben@test.com')
  fill_in('password', with: '1234')
  click_button('Submit')
end

def create_new_space
  visit '/my_spaces/create_space'
  fill_in('space_name', with: 'Jara home')
  fill_in('description', with: 'Nice Cozy room')
  fill_in('price', with: 40.00)
  click_button('Submit')
end

def clear_test_database
  p 'Setting up the test database..'
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec('TRUNCATE TABLE users CASCADE;')
  # cascade should also cause any dependent tables to be truncated
end

def setup
  sign_up_1
  sign_in_1
  create_new_space
end

def sign_in_1
  visit '/sign_in'
  fill_in('email', with: 'myemail@test.com')
  fill_in('password', with: 'password')
  click_button('sign_in')
end

def sign_in_2
  visit '/sign_in'
  fill_in('email', with: 'ben@test.com')
  fill_in('password', with: '1234')
  click_button('sign_in')
end

def sign_out
  visit '/user'
  click_button('dropbtn')
  click_button('sign_out')
end

def book_space
  visit('/user')
  first('.space').click_button 'Book'
  click_button('confirm')
end

def confirm_booking
  visit('/my_spaces/manage')
  click_button('Accept')
end

def decline_booking
  visit('/my_spaces/manage')
  click_button('Decline')
end
