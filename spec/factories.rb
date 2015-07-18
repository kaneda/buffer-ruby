require_relative '../lib/api/base_api.rb'
require_relative '../lib/api/auth_api.rb'
require_relative '../lib/api/user_api.rb'
require_relative '../lib/api/profile_api.rb'
require_relative '../lib/api/update_api.rb'
require_relative '../lib/api/link_api.rb'
require_relative '../lib/api/info_api.rb'

FactoryGirl.define do
  trait :api_traits do
    user_code  "123456789"
    auth_token "123456789abcd"
  end

  factory :base_api, traits: [:api_traits] do
    skip_create
    initialize_with { new(attributes) }
  end

  factory :auth_api, traits: [:api_traits] do
    skip_create
    initialize_with { new(attributes) }
  end

  factory :user_api, traits: [:api_traits] do
    skip_create
    initialize_with { new(attributes) }
  end

  factory :profile_api, traits: [:api_traits] do
    skip_create
    initialize_with { new(attributes) }
  end

  factory :update_api, traits: [:api_traits] do
    skip_create
    initialize_with { new(attributes) }
  end

  factory :link_api, traits: [:api_traits] do
    skip_create
    initialize_with { new(attributes) }
  end

  factory :info_api, traits: [:api_traits] do
    skip_create
    initialize_with { new(attributes) }
  end
end
