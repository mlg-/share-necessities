require "rails_helper"

feature "Organizer can see items promised to them by volunteers", %{
  As an organizer
  I want to see the items that are promised
  So I know what we can expect
} do
  # Acceptance Criteria
  # [X] Organizer can see promised items when logged in
  # [X] Promised item list changes if volunteer cancels

  scenario "Organizer can see items promised to them" do
    organizer = FactoryGirl.create(:organizer)
    item = FactoryGirl.create(:item, organization: organizer.organization)
    volunteer = FactoryGirl.create(:user)
    dib = FactoryGirl.create(:dib, user: volunteer,
                             item: item)
    
    sign_in_as(organizer.user)

    visit organization_path(organizer.organization)

    click_link("See Incoming Items")

    expect(page).to have_content("Incoming Items")
    expect(page).to have_content(item.name)
    expect(page).to have_content(volunteer.first_name)
    expect(page).to have_content(dib.created_at.strftime("%B %d, %Y"))
  end

  scenario "Volunteer promises and then cancels an item" do
    organizer = FactoryGirl.create(:organizer)
    FactoryGirl.create(:item, organization: organizer.organization)
    volunteer = FactoryGirl.create(:user)

    sign_in_as(volunteer)

    visit organization_path(organizer.organization.id)

    fill_in("Quantity", with: 1)
    click_button("I'll get this!")

    click_link("My Items (1)")

    click_button("I can no longer provide this item.")

    click_link("Sign Out")

    sign_in_as(organizer.user)

    click_link(organizer.organization.name)

    click_link("See Incoming Items")

    expect(page).to have_content("No incoming items")
  end
end
