# MakersBnB


### To set up the databases ###

#### database ####
Connect to `psql` and create the `makersbnb` database:

```
CREATE DATABASE makersbnb;
```

#### Test database ####
Connect to `psql` and create the `makersbnb_test` database:

```
CREATE DATABASE makersbnb_test;
```

To set up the appropriate tables, connect to the datatbase in `psql` and run the SQL scripts in the `db/migrations` directory in the given folder.

KEY:
Bookings Table Status column Integer -
0 = pending
1 = confirmed
2 = declined
<!-- 3 = cancelled  -->

### To run tests ###
`rspec` from the parent directory
## Views Plan: ##

```
get '/'                     -->  display index.erb (link to sign_up and sign_in - spaces list)

get '/sign_up'              -->  display sign_up.erb (sign_up form, submit button)
post '/sign_up'             -->  redirect to ./sign_in (saves data to users table in DB)

get '/sign_in'              -->  display sign_in.erb (sign in form)
post '/sign_in'             -->  redirect to ./user (authenticates and gets new user from DB)

post '/sign_out'            -->  removes current user data

get '/user'                 -->  display user.erb (link to my_bookings - link to my_spaces - space list with links to book_space - menu)

get '/my_bookings/:user_id' -->  display my_bookings.erb (list of bookings with status - link to '/user')

get '/my_spaces'            -->  display my_spaces.erb (list of my spaces - link to create_space - link to manage_spaces - link to user)

get '/my_spaces/create_space'  -->  display spaces/create.erb (create_space form, save_button, link to my_spaces)
post '/my_spaces/create_space  -->  redirect to ./my_spaces (saves space to spaces table in DB)

get '/my_spaces/manage'     -->  display space_management.erb (list of my spaces with booking requests and accept/decline options)
post '/my_spaces/manage'    -->  redirect to ./my_spaces/manage (modifies availability in spaces DB)

get '/book_space/:id'     -->  display book_space.erb (space, confirm_booking_button)
post '/book_space/:id'    -->  redirect to ./my_bookings/user (creates a new booking instance, save data into bookings DB)
```

---- Data for api google calendar.---- (just trying this shit.)
Client ID
1097043031635-u70ead24ht5kasqlgpjgbau7ddtica3b.apps.googleusercontent.com
Client Secret
4pBOyjT7mIwQWGxTn27TGSVW

----------------------------------------
