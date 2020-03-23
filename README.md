# MakersBnB

## Views Plan: ##

```
get '/'                   -->  display index.erb (link to sign_up - spaces list)
get '/sign_up'            -->  display sign_up.erb (sign_up form, submit button)
post '/sign_up'           -->  redirect to ./user (saves data to users table in DB)
get '/user'               -->  display user.erb (link to create_space - space list with links to book_space)
get '/create_space'       -->  display create_space.erb (create_space form, authenticate, save_button)
post '/create_space       -->  redirect to ./user (confirm authentication with users table in DB, saves space to spaces table in DB)
get '/book_space/:id'     -->  display book_space.erb (space, authenticate, confirm_booking_button)
post '/book_space/:id'    -->  redirect to ./user (confirm authentication with users table in DB, change space availability in spaces table in DB)
```
