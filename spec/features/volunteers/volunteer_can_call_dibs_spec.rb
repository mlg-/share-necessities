require "rails_helper"

feature "Volunteer can promise an item when logged in", %{
  As a volunteer
  I want to call dibs on an item that an organization needs
  So that they know I will get it for them
} do

  # Acceptance Criteria
  # [ ] Volunteer can select multiple items for an “order” from a single organization’s   wishlist.
  # [ ] Orders may not span multiple organizations (for now)
  # [ ] Volunteer can specify quantity.
  # [ ] When volunteer commits to items, the quantities needed are updated on the organization’s wishlist
  # [ ] The volunteer is shown the organization’s delivery information when they submit the “order” form

  scenario "Volunteer is asked to log in or sign up before calling dibs" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)

    visit organization_path(organization.id)

    click_button("I'll get this!")

    expect(page).to have_content("Please sign in or sign up before
                                  promising an item.")
  end


end