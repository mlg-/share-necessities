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

end
