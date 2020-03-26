def sign_up
  visit '/sign_up'
  fill_in('name', with: 'Neha Singh')
  fill_in('email', with: 'myemail@test.com')
  fill_in('password', with: 'password')
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
  p "Setting up the test database.."
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE TABLE users CASCADE;")
  #cascade should also cause any dependent tables to be truncated
end

def setup
  sign_up
  sign_in
  create_new_space
end

def sign_in
  visit '/sign_in'
  fill_in('email', with: 'myemail@test.com')
  fill_in('password', with: 'password')
  click_button('sign_in')
end

def sign_out
  visit'/user'
  click_button('dropbtn')
  click_button('sign_out')
end

def book_space
  visit('/user')
  first('.space').click_button 'Book'
  click_button('confirm')
end
