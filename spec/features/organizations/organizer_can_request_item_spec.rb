require "rails_helper"

feature "organizer can request item for organization", %{
  As an organizer
  I want to post items to my organization’s wishlist
  So that other helpful users will know what we need
} do
  # Acceptance Criteria
  # [ ] Organizer can add items to their wishlist using a form.
  # [ ] The item is now visible from the organization’s wishlist page.
  # [ ] A volunteer user or visitor can see the item, date added, quantity needed,
  #     and an optional url and description for more information about the item.

  scenario "Organizer can navigate to form for adding new items" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization

    sign_in_as(organizer.user)

    visit new_organization_item_path(organization_id: organization.id)

    find_field("Name")
    find_field("Quantity")
    find_field("Description")
  end
end