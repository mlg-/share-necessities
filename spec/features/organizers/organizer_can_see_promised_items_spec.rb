require "rails_helper"

feature "Organizer can see items promised to them by volunteers", %{
  As an organizer
  I want to see the items that are promised
  So I know what we can expect
} do
  # Acceptance Criteria
  # [ ] Organizer can see promised items when logged in
  # [ ] Promised item list changes if volunteer cancels

  scenario "Organizer can see items promised to them" do
    organizer = FactoryGirl.create(:organizer)
    item = FactoryGirl.create(:item)
    volunteer = FactoryGirl.create(:user)
    dib = FactoryGirl.create(:dib, user: volunteer,
                             item: item)
    
    sign_in_as(organizer.user)

    visit organization_path(organizer.organization)

    click_link("See Incoming Items")

    expect(page).to have_content("All Incoming Items")
    expect(page).to have_content(item.name)
    expect(page).to have_content(volunteer.first_name)
    expect(page).to have_content(dib.created_at)
  end
end