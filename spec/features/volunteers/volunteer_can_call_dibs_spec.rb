require "rails_helper"

feature "Volunteer can promise an item when logged in", %{
  As a volunteer
  I want to call dibs on an item that an organization needs
  So that they know I will get it for them
} do

  # Acceptance Criteria
  # [X] Volunteer can select multiple items and see all with delivery
  #      instructions under "My Items" tab.
  # [X] Items can be from any organization.
  # [X] Volunteer must specify quantity.
  # [X] Volunteer quantity cannot exceed amount requested.
  # [X] When volunteer commits to items, the quantities needed
  #      are updated on the organization’s wishlist.
  # [X] The volunteer is shown the organization’s delivery information
  #       on their items page.

  scenario "Volunteer is asked to log in or sign up before calling dibs" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)

    visit organization_path(organization.id)

    click_button("I'll get this!")

    expect(page).to have_content("You need to sign in or sign up to use this
                                 feature.")
  end

  scenario "Volunteer can promise an item when logged in" do
    organization = FactoryGirl.create(:organization)
    FactoryGirl.create(:item, organization: organization)
    volunteer = FactoryGirl.create(:user)

    sign_in_as(volunteer)

    visit organization_path(organization.id)

    fill_in("Quantity", with: 1)
    click_button("I'll get this!")

    expect(page).to have_content("Thanks so much! You can see all your promised
                                  items and delivery instructions in
                                  \"My Items\" above.")
    expect(User.find(volunteer.id).dibs.count).to eq(1)
    expect(page).to have_content("My Items (1)")
  end

  scenario "Volunteer must specify a quantity" do
    organization = FactoryGirl.create(:organization)
    volunteer = FactoryGirl.create(:user)
    FactoryGirl.create(:item, organization: organization)

    sign_in_as(volunteer)

    visit organization_path(organization.id)

    click_button("I'll get this!")

    expect(page).to have_content("Please specify a quantity.")
  end

  scenario "Volunteer must be able to see their compiled items" do
    organization = FactoryGirl.create(:organization)
    volunteer = FactoryGirl.create(:user)
    item_1 = FactoryGirl.create(:item, organization: organization)
    item_2 = FactoryGirl.create(:item, organization: organization)
    dib_1 = FactoryGirl.create(:dib, user: volunteer, item: item_1)
    dib_2 = FactoryGirl.create(:dib, user: volunteer, item: item_2)

    sign_in_as(volunteer)

    expect(page).to have_content("My Items (2)")
    click_link("My Items (2)")

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(dib_1.quantity)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(dib_2.quantity)
    expect(page).to have_content(organization.name)
  end

  scenario "Volunteer can promise items for different organizations" do
    organization = FactoryGirl.create(:organization)
    organization_2 = FactoryGirl.create(:organization)
    volunteer = FactoryGirl.create(:user)
    item_1 = FactoryGirl.create(:item, organization: organization)
    item_2 = FactoryGirl.create(:item, organization: organization_2)
    dib_1 = FactoryGirl.create(:dib, user: volunteer, item: item_1)
    dib_2 = FactoryGirl.create(:dib, user: volunteer, item: item_2)

    sign_in_as(volunteer)

    expect(page).to have_content("My Items (2)")
    click_link("My Items (2)")

    expect(page).to have_content(item_1.name)
    expect(page).to have_content(dib_1.quantity)
    expect(page).to have_content(item_2.name)
    expect(page).to have_content(dib_2.quantity)
    expect(page).to have_content(organization.name)
    expect(page).to have_content(organization_2.name)
  end

  scenario "Quantity needed updates on wishlist" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)
    volunteer = FactoryGirl.create(:user)

    sign_in_as(volunteer)

    visit organization_path(organization.id)

    fill_in("Quantity", with: 1)
    click_button("I'll get this!")

    expect(User.find(volunteer.id).dibs.count).to eq(1)

    expect(page).to have_content(item.name)
    expect(Item.find(item.id).quantity).to eq(item.quantity - 1)
  end

  scenario "Volunteer cannot promise more than are needed" do
    organization = FactoryGirl.create(:organization)
    item = FactoryGirl.create(:item, organization: organization)
    volunteer = FactoryGirl.create(:user)

    exceeds_quantity = item.quantity + 1

    sign_in_as(volunteer)

    visit organization_path(organization.id)

    fill_in("Quantity", with: exceeds_quantity)
    click_button("I'll get this!")

    expect(page).to have_content("Please specify an amount less
                                  than or equal to the total needed.")
  end
end