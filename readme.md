# Buffer Gem

Modelled after Octokit <3. This is a lightweight client for the Buffer API (https://buffer.com/developers/api), which is intended to return JSON as opposed to objects.

## Client API

### What's Imlemented?
* https://buffer.com/developers/api/oauth
* https://buffer.com/developers/api/user
* https://buffer.com/developers/api/profiles
* https://buffer.com/developers/api/errors


### What's Missing?
* https://buffer.com/developers/api/updates
* https://buffer.com/developers/api/links
* https://buffer.com/developers/api/info

### Installing

Put this sucker in your Gemfile and bundle install

```ruby
gem "buffer-app", :git => "git://github.com/kaneda/buffer-ruby", :tag => "v1.0"
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
| Client call | Description | Notes
| :-----------: | :----------- | :-----
| get_auth_token | Returns the user's long-lasting auth token | user_code must be defined in the buffer_client, as well as the ENV variables "BUFFER_KEY" and "BUFFER_SECRET" |
| get_user_id | Returns the user's Buffer ID | auth_token must be defined in the buffer client |
| get_user_json | Returns the entirety of the user JSON | auth_token must be defined in the buffer client |
| get_user_profiles | Returns the entirety of the profile JSON | auth_token must be defined in the buffer client |

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
