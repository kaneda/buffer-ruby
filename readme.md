# Buffer Gem

Modelled after Octokit <3. This is a lightweight client for the Buffer API (https://buffer.com/developers/api), which is intended to return JSON as opposed to objects.

[![Code Climate](https://codeclimate.com/github/kaneda/buffer-ruby/badges/gpa.svg)](https://codeclimate.com/github/kaneda/buffer-ruby)

## Client API

### What's Imlemented?
* https://buffer.com/developers/api/oauth
* https://buffer.com/developers/api/user
* https://buffer.com/developers/api/profiles
* https://buffer.com/developers/api/links
* https://buffer.com/developers/api/errors


### What's Missing?
* https://buffer.com/developers/api/updates (WIP)
* https://buffer.com/developers/api/info
* Rspecs

### Installing

Put this sucker in your Gemfile and bundle install

```ruby
gem "buffer-app", :git => "git://github.com/kaneda/buffer-ruby", :tag => "v1.1"
```

Then drop this into your config/application.rb (or wherever you want to use it)

```ruby
require 'buffer_app'
```

### Basic Usage

You can define the client up front or configure it later. The options array the BufferClient (and the API objects behind the scenes) uses takes in the following parameters:
* :user_code
* :auth_token
* :logger

```ruby
buffer_client = BufferClient.new({
  :user_code => "yourcode"
})
```

```ruby
buffer_client = BufferClient.new

buffer_client.configure({
  :user_code => "yourcode"
})
```

### Available Calls
| Client call | Input | Description | Notes
| :-----------: | :----- | :----------- | :-----
| get_auth_token | | Returns the user's long-lasting auth token | user_code must be defined in the buffer_client, as well as the ENV variables "BUFFER_KEY" and "BUFFER_SECRET" |
| get_user_id | | Returns the user's Buffer ID | |
| get_user_json | | Returns the entirety of the user JSON | |
| get_user_profiles | | Returns the entirety of the profile JSON | |
| get_user_profile | Profile ID | Get a single profile as JSON by ID | |
| get_schedule | Profile ID | Get the schedule of a profile as JSON by ID | |
| update_schedule | Profile ID, Schedule Hash | Set the schedule of a profile as JSON by ID | auth_token must be defined in the buffer client. See below for schedule representation |
| get_update | Social Media Post ID | Gets an update by post ID | |
| get_pending_updates | Profile ID, Options Hash (optional) | Gets pending updates as JSON by profile ID | Takes in hash of options, see Buffer API docs for optional parameters |
| get_sent_updates | Profile ID, Options Hash (optional) | Gets sent updates as JSON by profile ID | Takes in hash of options, see Buffer API docs for optional parameters |
| get_interactions | Social Media Post ID, Event, Options Hash (optional) | Gets interactions based on event type (see https://bufferapp.com/developers/api/info#configuration) | Takes in a hash of options, see Buffer API docs for optional parameters |
| reorder_updates | Profile ID, Updates Array, Options Hash (optional) | Updates order of updates in a profile based on updates array | |
| shuffle_updates | Profile ID, Options Hash (optional) | Randomize the order of updates to be sent | |
| create_update | Profile ID Array, Options Hash (optional) | Create a new post | Note that for the "media" option, please specify each media option in the hash separately, e.g. ```{ "media[link]" => "http%3A%2F%2Fgoogle.com", "media[description]" => "The%20google%20homepage" }``` |
| update_status | Social Media Post ID, Text, Options Hash (optional) | Update an existing status | For the "media" option see the note on create_update |
| share_update | Social Media Post ID | Share a post immediately | |
| destroy_update | Social Media Post ID| Permanently destroy an update | |
| move_to_top | Social Media Post ID| Move post to top of queue | |
| get_shares | URL (unencoded) | Gets the number of shares for a given URL through Buffer | You can pass a normal URL here, the client will encode it. This is one of the only calls to not require an auth_token |

### Helper methods
| Method | Description |
| :---------: | :----- |
| configure | Takes in a hash (as above) and reconfigures all API objects |
| has_error? | Returns true if an error has been set in the client |
| get_error | Returns the current error and wipes it out in the client |
| error | Returns the current error, leaving it in tact |


### Defining a schedule

To update a schedule the BufferClient is expecting a schedule of the form:

```ruby
[
  {
    :days  => ['mon', 'tue', 'thu'],
    :times => ['12:45', '15:30', '17:43']
  },
  .
  .
  .
]
```

## Contributing

To contribute simply:

1. Fork this project
2. Make your changes in a new branch
3. Create a PR
4. Once approved squash your commits (http://davidwalsh.name/squash-commits-git)
5. Party

## Contact

Email: kanedasan@gmail.com

Twitter: @kanedasan

IRC: kaneda^ on FreeNode (##hackers)
