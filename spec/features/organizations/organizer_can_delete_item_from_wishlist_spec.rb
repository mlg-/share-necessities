require "rails_helper"

feature "Organizer can delete wishlist items", %{
  As an organizer
  I want to delete items from my wishlist
  Because we don’t need them anymore
} do
  # Acceptance criteria
  # [ ] Item can be deleted by organizer
  # [ ] Organizer cannot delete another organization’s wishlist items
  # [ ] The item no longer appears on the organization’s wishlist page

  scenario "Organizer can delete a wishlist item" do
    organizer = FactoryGirl.create(:organizer)
    organization = organizer.organization
    item_1 = FactoryGirl.create(:item, organization: organization)
    item_2 = FactoryGirl.create(:raincoat, organization: organization)

    sign_in_as(organizer.user)

    visit organization_path(id: organization.id)

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_2.name)
    click_link("item-#{item_2.id}-delete")

    expect(page).to have_content ("#{item_2.name.capitalize} has been deleted.")
  end

  scenario "Organizer for another org cannot delete wishlist item" do
    organizer = FactoryGirl.create(:organizer)
    organization = FactoryGirl.create(:organization)
    item_1 = FactoryGirl.create(:item, organization: organization)

    sign_in_as(organizer.user)

    visit organization_path(id: organization.id)

    expect(page).to have_content(item_1.name)
    expect(page).to_not have_content("Delete")
  end
end
