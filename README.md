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

### To run tests ###
`rspec` from the parent directory
