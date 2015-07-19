require "rails_helper"

feature "Organizer can see list of all organizers in their org", %{
  As an organizer
  I want to know who else is on my team
  So I can manage permissions
} do
  # Acceptance Criteria:
  # [X] Organizer can see list with email & full name of each
  #     other organizer in their organization.
  # [] If organizer is the only one, they are told about invitation
  #     feature

  scenario "Organizer can see all organizers on edit page" do
    organizer_1 = FactoryGirl.create(:organizer)
    organizer_2 = FactoryGirl.create(:organizer,
                                     organization: organizer_1.organization)
    organizer_3 = FactoryGirl.create(:organizer,
                                     organization: organizer_1.organization)

    sign_in_as(organizer_1.user)

    visit edit_organization_path(organizer_1.organization)

    expect(page).to have_content("Current Organizers")
    expect(page).to have_content(organizer_2.user.first_name)
    expect(page).to have_content(organizer_2.user.last_name)
    expect(page).to have_content(organizer_2.user.email)
    expect(page).to have_content(organizer_3.user.first_name)
    expect(page).to have_content(organizer_3.user.last_name)
    expect(page).to have_content(organizer_3.user.email)
  end

  scenario "Founding organizer is the only organizer" do
    organizer = FactoryGirl.create(:organizer)

    sign_in_as(organizer.user)

    visit edit_organization_path(organizer.organization)

    expect(page).to have_content("You are the only organizer.
                                  Invite others below!")
  end
end