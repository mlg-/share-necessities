require 'rails_helper'

feature 'user can create an organization and become an organizer', %{
  As an organizer,
  I want to add my organization to the directory
  So that we can benefit from helpful volunteers
} do

  # [ ] Organizer can add their organization’s profile page using a form
  # [ ] Organizer is then the owner of the organization
  # [ ] Organizations must have a name, address, email,
  #     delivery instructions, and description.
  #     URL, phone number, hours, description,
  #     and profile/organization photo are optional.

  scenario 'logged in user can navigate to a new organization form' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    visit '/'
    click_link("I am... an organizer, and I want to add my organization.")
    expect(page).to have_content("Add Your Organization")
    # expect(page).to have_content("Create Organization")
  end
end