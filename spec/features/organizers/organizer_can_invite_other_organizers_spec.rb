require "rails_helper"

feature "Organizer can invite other organizers to their org", %{
  As an organizer
  I want to invite other people from my organization
  So we can all manage our wishlist together
} do
  # Acceptance Criteria:
  # [] Organizer can navigate to invitation form
  # [] Organizer can invite a non-user
  # [] Organizer can invite an existing user
  # [] After being invited, organizer can see organization page and
  #    add or interact with wishlist items.

  scenario "Organizer can navigate to invitation form" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization

    sign_in_as(organizer.user)

    click_link("#{organization.name}")

    click_link("Edit Organization Settings")

    expect(page).to have_content("Invite Organizers")
    expect(page).to have_content("Send invitation")
  end
end

