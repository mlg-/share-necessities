require "rails_helper"

feature "Organizer can mark item as received", %{As an organizer
I want to mark an item as received
So I can confirm that we got it
} do
  # Acceptance Criteria
  # [ ] Organizer can mark promised items as received when logged in.
  # [ ] The volunteer who promised the item can see the item marked
  #      as received when logged in.


  scenario "Organizer can mark item as received" do
    organizer = FactoryGirl.create(:organizer)
    item = FactoryGirl.create(:item, organization: organizer.organization)
    volunteer = FactoryGirl.create(:user)
    dib = FactoryGirl.create(:dib, user: volunteer,
                             item: item)
    
    sign_in_as(organizer.user)

    visit organization_path(organizer.organization)

    click_link("See Incoming Items")

    click_link("Mark Item as Received")
    expect(page).to have_content("This item has been marked as received,
                                  and the provider has been notified.")
  end

  scenario "Volunteer can see that their item has been received" do
    organizer = FactoryGirl.create(:organizer)
    item = FactoryGirl.create(:item, organization: organizer.organization)
    volunteer = FactoryGirl.create(:user)
    dib = FactoryGirl.create(:dib, user: volunteer,
                             item: item)
    
    sign_in_as(organizer.user)

    visit organization_path(organizer.organization)

    click_link("See Incoming Items")

    click_link("Mark Item as Received")
    expect(page).to have_content("This item has been marked as received,
                                  and the provider has been notified.")

    click_link("Sign Out")

    sign_in_as(volunteer)

    expect(page).to have_content("My Items (0)")
    click_link("My Items (0)")

    expect(page).to have_content("This item has been received. Thank you!")
  end
end
