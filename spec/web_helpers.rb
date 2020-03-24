def sign_up
  fill_in('name', with: 'Neha Singh')
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
