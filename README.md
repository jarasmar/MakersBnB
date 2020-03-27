# MakersBnB #

## DESCRIPTION OF THE PROJECT ##

 Create a clone app of Airbnb in Ruby. This is a group project focused on building and MPV
 utilising XP principles.

## WHAT WE HAVE DONE ##

 - Our app allows user to sign_up
 - Allows user to sign_in.
 - Once we are identified by the system we can create a space or book one.
 - As part of our implementation we can add a name to the space, a price and a description.

### Our user stories implementation had followed this check points: ###

Any signed-up user can list a new space.
  - As a user, I need to sign-up.  (name, username, email, password)✅
  - As a user, I need to log-in. (username, password) ✅
  - As a user, I need to log-out.✅
  - As a Owner, I want to be able to list a new space ✅

Users can list multiple spaces ✅

As A Owner, I want to be able to list multiple spaces.✅
  - Users should be able to name their space, provide a short description of the space, and a price per     night.
  - As a Owner, I want to be able to name my spaces.✅
  - As a Owner, I want to be able to be able to add a description to my spaces✅
  - As a Owner, I want to be able to add a price per night to my spaces✅

Any signed-up user can request to hire any space for one night, and this should be approved by the user that owns that space.
  - As a Client, I would like to request a space for a night.✅
  - As a Owner, I would like to be able to approve requests to stay at my space✅
  - As a Owner, I would like to be able to decline requests to stay at my space✅
  - Nights for which a space has already been booked should not be available for users to book that space ✅
  - As a Client, I don't want to see rooms that have an accepted booking request for my chosen dates (not available).✅
  - Until a user has confirmed a booking request, that space can still be booked for that night. ✅
  - As a client, I can make a booking request for a room with an existing booking request that has not yet been approved. (maybe available)✅


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

To set up the appropriate tables, connect to the database in `psql` and run the SQL scripts in the `db/migrations` directory in the given folder.

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

## TEAM MEMBERS ##
  - Ben Galley.
  - Neha Singh
  - Jara Santamaria Martinez.
  - Patrick Oliver.
  - Rafa Hernandez.


## TRELLO BOARD ##

 In our trello pannel is defined how our work was organised.

 We agreed to organise the week's work by establishing a rota since the beginning with
 a daily rotation.

 The rota was established for roles and pairings

 The link is below:

  https://trello.com/b/4E76SK8e/makersbnb


## IDEAS TO IMPROVE OUR APPLICATION ##

## Dates implementation ##
Ideally it would have a calendar and be able to book range of dates but for now we will focus on booking an specific date at a time.

- In the view user, we will ask for a date input that will display only the spaces available for that specific date.
- Once we choose a space, we press 'book' and it will be saved in the DB as 'pending'.
- Owner accepts your booking and the status change to 'accepted'.
- If we search again for the same date, that space will not be shown.

Technical Plan:
- User view has a form with an input selected_date that we submit and store as a param
- Display a new list with spaces available in selected_date: (method will map all existent spaces and with each space_id will go to bookings table and check there is not accepted bookings with each space_id for selected_date). Display those with no coincidences.
- From the new list of available spaces we can do the booking (that will create a new booking in the table and save the selected_date)
- Owner can accept or decline (changes status in booking as usual).
