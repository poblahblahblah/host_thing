# host_thing
[![Dependency Status](https://gemnasium.com/badges/github.com/poblahblahblah/host_thing.svg)](https://gemnasium.com/github.com/poblahblahblah/host_thing)

## Setup
```
bundle
docker-compose up # bring up the database
rake db:migrate
rake db:seed
rails server
```

## Creating a local user
Sign up is disabled, so in order to create a new user
```
User.create!(
  {
    email: 'admin@example.com',
    password: 'foobar',
    password_confirmation: 'foobar'
  }
)
```

## Creating an LDAP user
```
# FIXME
```

## Generating JWT based API Auth Tokens
```
# Find the user to create the token for
user = User.find_by(email: 'admin@example.com')

# The default token expiration is 720 hours. Setting this is optional. If you
# want to override this you can. Below is changing the expiration to 90 days.
expiration = 24 * 90

# create the token
token = JWTWrapper.encode({user_id: user.id}, expiration)

# decode the token to verify
JWTWrapper.decode(token)
```

### Using API Auth Token with curl
```
curl -X GET --header 'Authorization: Bearer auth-token-goeshere' 'http://localhost:3000/nodes'
```
