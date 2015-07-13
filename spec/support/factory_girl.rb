require 'factory_girl'

FactoryGirl.define do
  factory :user do
    first_name "Cappy"
    last_name "Barra"
    sequence(:email) {|n| "user#{n}@example.com" }
    bio "This is a bio of a rodent"
    password 'password'
    password_confirmation 'password'
  end

  factory :organization do
    name "Sojourner House"
    address "85 Rockland Street"
    city "Roxbury"
    state "Massachusetts"
    zip "02119"
    description "Sojourner House opened its doors in 1981 as Boston’s only
                 homeless shelter to house families that include both female
                 and / or male parents and children of all ages. "
    phone "617-442-0590"
    email "soj@mailinator.com"
    url "http://sojournerhouseboston.org/"
    delivery_instructions "For material donations please call in
                           advance as we have limited storage for
                           items and clothes."
  end

  factory :organizer do
    user
    organization
  end

end
