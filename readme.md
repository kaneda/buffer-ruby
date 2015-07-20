# Buffer Gem

Modelled after [Octokit](https://github.com/octokit/octokit.rb) <3, this is a lightweight client for the [Buffer API](https://buffer.com/developers/api), which is intended to return (mostly) JSON as opposed to objects.

[![Code Climate](https://codeclimate.com/github/kaneda/buffer-ruby/badges/gpa.svg)](https://codeclimate.com/github/kaneda/buffer-ruby)
[![Test Coverage](https://codeclimate.com/github/kaneda/buffer-ruby/badges/coverage.svg)](https://codeclimate.com/github/kaneda/buffer-ruby/coverage)
[![Build Status](https://travis-ci.org/kaneda/buffer-ruby.svg?branch=master)](https://travis-ci.org/kaneda/buffer-ruby)

## Table of Contents

* [Ruby Versions](https://github.com/kaneda/buffer-ruby#ruby-versions)
* [Client API](https://github.com/kaneda/buffer-ruby#client-api)
** [What's Implemented](https://github.com/kaneda/buffer-ruby#whats-imlemented)
** [Installing](https://github.com/kaneda/buffer-ruby#installing)
** [Basic Usage](https://github.com/kaneda/buffer-ruby#basic-usage)
** [Available Calls](https://github.com/kaneda/buffer-ruby#available-calls)
** [Helper Methods](https://github.com/kaneda/buffer-ruby#helper-methods)
** [Defining a Schedule](https://github.com/kaneda/buffer-ruby#defining-a-schedule)
* [Contributing](https://github.com/kaneda/buffer-ruby#contributing)
* [Contact](https://github.com/kaneda/buffer-ruby#contact)

## Ruby Versions

This gem is built to work with Ruby 1.9.3+

See the Travis-CI build information above for build status on 1.9.3 and 2.1.2

## Client API

### What's Imlemented?
* [OAuth](https://buffer.com/developers/api/oauth)
* [Users](https://buffer.com/developers/api/user)
* [Profiles](https://buffer.com/developers/api/profiles)
* [Updates](https://buffer.com/developers/api/updates)
* [Links](https://buffer.com/developers/api/links)
* [Info](https://buffer.com/developers/api/info)
* [Errors](https://buffer.com/developers/api/errors)
* Automated builds through Travis-CI
* Automated tests using RSpec

### Installing

Put this sucker in your Gemfile and bundle install

```ruby
gem "buffer-app", :git => "git://github.com/kaneda/buffer-ruby", :tag => "v1.2"
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

auth_tok = buffer_client.get_auth_token

buffer_client.configure({
  :auth_token => auth_tok
})

# Subsequent calls here (see below)
```

### Available Calls

| Client call | Input | Output | Notes
| :---------: | :------ | :------ | :---------
| [get_auth_token](https://buffer.com/developers/api/oauth) | | Auth Token:String | ENV variables "BUFFER_KEY" and "BUFFER_SECRET" must be defined here |
| get_user_id | | ID:String | Convenience wrapper, calls get_user_json under the hood |
| [get_user_json](https://buffer.com/developers/api/user#user) | | User:Hash | |
| [deauthorize](https://buffer.com/developers/api/user#deauthorize) | | Success:Boolean | |
| [get_user_profiles](https://buffer.com/developers/api/profiles#profiles) | | Profiles:Array<Hash> | |
| [get_user_profile](https://buffer.com/developers/api/profiles#profilesid) | Profile ID:String | Profile:Hash | |
| [get_schedule](https://buffer.com/developers/api/profiles#schedules) | Profile ID:String | Schedule:Hash | |
| [update_schedule](https://buffer.com/developers/api/profiles#schedulesupdate) | Profile ID:String, Schedule:Hash | Success:Boolean | See below for schedule representation |
| [get_update](https://buffer.com/developers/api/updates#updatesid) | Social Media Post ID:String | Update:Hash | |
| [get_pending_updates](https://buffer.com/developers/api/updates#updatespending) | Profile ID:String, Options:Hash (optional) | UpdateResult:Hash | See Buffer API doc (link to the left) for optional parameters. "updates" key contains the Updates:Array<Hash> |
| [get_sent_updates](https://buffer.com/developers/api/updates#updatessent) | Profile ID:String, Options:Hash (optional) | UpdateResult:Hash | See Buffer API doc (link to the left) for optional parameters. "updates" key contains the Updates:Array<Hash> |
| [get_interactions](https://buffer.com/developers/api/updates#updatesinteractions) | Social Media Post ID:String, Event:ENUM, Options:Hash (optional) | Interactions:Hash | See [event types](https://bufferapp.com/developers/api/info#configuration) for possible event values and Buffer API doc (link to the left) for optional parameters. "interactions" key contains the Interactions:Array<Hash> |
| [reorder_updates](https://buffer.com/developers/api/updates#updatesreorder) | Profile ID:String, Updates:Array, Options:Hash (optional) | Updates:Array<Hash> | |
| [shuffle_updates](https://buffer.com/developers/api/updates#updatesshuffle) | Profile ID:String, Options:Hash (optional) | Updates:Array<Hash> | |
| [create_update](https://buffer.com/developers/api/updates#updatescreate) | Profile IDs:Array, Options:Hash (optional) | Update:Hash | Note that for the "media" option, please specify each media option in the hash separately, e.g. ```{ "media[link]" => "http%3A%2F%2Fgoogle.com", "media[description]" => "The%20google%20homepage" }```. See all available options in the Buffer docs (link to the left) |
| [update_status](https://buffer.com/developers/api/updates#updatesupdate) | Social Media Post ID:String, Text:String, Options:Hash (optional) | Update:Hash | For the "media" option see the note on create_update above |
| [share_update](https://buffer.com/developers/api/updates#updatesshare) | Social Media Post ID:String | Success:Boolean | |
| [destroy_update](https://buffer.com/developers/api/updates#updatesdestroy) | Social Media Post ID:String | Success:Boolean | |
| [move_to_top](https://buffer.com/developers/api/updates#updatesmovetotop) | Social Media Post ID:String | Success:Boolean | |
| [get_shares](https://buffer.com/developers/api/links#shares) | Unencodded URL:String | Shares:Integer | You can pass a normal URL here, the client will encode it. This is one of the only calls to not require an auth_token |
| [get_configuration](https://buffer.com/developers/api/info#configuration) | | Configuration:Hash | "services" key has internal keys for each service |

### Helper Methods
| Method | Description |
| :---------: | :----- |
| configure | Takes in a hash (as above) and reconfigures all API objects |
| has_error? | Returns true if an error has been set in the client |
| get_error | Returns the current error and wipes it out in the client |
| error | Returns the current error, leaving it in tact |


### Defining a Schedule

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

Note that you can make the keys symbols or strings, the client will accept either one.

## Contributing

To contribute simply:

1. Fork this project
2. Make your changes in a new branch
3. Create a PR
4. Once approved [squash your commits](http://davidwalsh.name/squash-commits-git)
5. Party

## Contact Me

Email: kanedasan@gmail.com

Twitter: [@kanedasan](https://twitter.com/kanedasan)

IRC: kaneda^ on FreeNode (##hackers)
