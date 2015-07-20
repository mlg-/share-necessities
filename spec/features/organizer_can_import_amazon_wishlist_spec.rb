# require "rails_helper"

# feature "Organizer can import wishlist from Amazon", %{
#   As an organizer, I want to import my wishlist
#   from Amazon,
#   So that I don't have to re-enter all my items.
# } do

#   # Acceptance Criteria
#   # [ ] Organizer can paste in link to Amazon wishlist
#   # [ ] Organizer receives list of items to approve or exclude from the import.
#   # [ ] Added items and their quantities, a source URL, and name are now
#   #     included on the wishlist

#   scenario "Organizer can see a form to paste their wishlist URL" do
#     organizer = FactoryGirl.create(:organizer)
#     sign_in_as(organizer)

#     visit new_organization_item_path(organizer.organization)

#     expect(page).to have_content("Import Amazon Wishlist")
    
#   end
# end