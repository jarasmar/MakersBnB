def sign_up
  visit '/sign_up'
  fill_in('name', with: 'Neha Singh')
  fill_in('email', with: 'myemail@test.com')
  fill_in('password', with: 'password')
  click_button('Submit')
end

def create_new_space
  visit '/create_space'
  fill_in('space_name', with: 'Jara home')
  fill_in('description', with: 'Nice Cozy room')
  fill_in('price', with: 40.00)
  fill_in('email', with: 'myemail@test.com')
  fill_in('password', with: 'password')
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
  create_new_space
end

def log_in
  visit '/'
  click_button('log in')
  fill_in('email', with: 'myemail@test.com')
  fill_in('password', with: 'password')
  click_button('Submit')
end
