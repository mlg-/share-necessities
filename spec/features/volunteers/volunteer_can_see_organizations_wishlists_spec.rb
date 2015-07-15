require "rails_helper"

feature "Volunteer can see organization's wishlists", %{
  As a volunteer, I want to find out what food pantries,
  shelters, and human service organizations near me
  actually need so that I can donate or buy those things
  and be a helpful human being!
} do

  # Acceptance Criteria
  # [ ] Volunteer can see index of all organizations,
  #     paginated and ordered alphabetically.
  # [ ] Volunteer can click on an organization’s name
  #       to be taken to their wishlist page.
  # [ ] Volunteer can browse organizations and wishlists
  #       without being signed in.

  scenario "Volunteer can see a list of all organizations" do
    visit "/"

  end

end