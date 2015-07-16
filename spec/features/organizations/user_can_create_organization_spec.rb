require 'rails_helper'

feature 'user can create an organization and become an organizer', %{
  As an organizer,
  I want to add my organization to the directory
  So that we can benefit from helpful volunteers
} do

  # [X] Organizer can add their organization’s profile page using a form
  # [X] Organizer is then the owner of the organization
  # [X] Organizations must have a name, address, email,
  #     delivery instructions, and description.
  #     URL, phone number, hours, description,
  #     and profile/organization photo are optional.
  # [X] If an organization is not created, the organizer is not added.
  scenario 'logged in user can navigate to a new organization form' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    visit "/"
    click_link("an organizer, and I want to add my organization.")

    expect(page).to have_content("Add Your Organization")
  end

  scenario "logged in user can create a new org and become its organizer" do
    user = FactoryGirl.create(:user)

    sign_in_as(user)
    visit new_organization_path

    fill_in("Name", with: "Rosie\'s Place")
    fill_in("Address", with: "889 Harrison Ave")
    fill_in("City", with: "Boston")
    select("Massachusetts", from: "State")
    fill_in("Zip Code", with: "02118")
    fill_in("Description", with: "Rosie's Place was founded in 1974 as the first
                           women’s shelter in the United States. Our mission is
                           to provide a safe and nurturing environment that
                           helps poor and homeless women maintain their dignity,
                          seek opportunity and find security in their lives. ")
    fill_in("Phone", with: "617-442-9322")
    fill_in("Email", with: "rosie@mailinator.com")
    fill_in("Url", with: "http://www.rosiesplace.org/")
    attach_file("Display Photo/Logo",
                "#{Rails.root}/spec/support/images/logo_rosiesplace.png")
    fill_in("Delivery instructions", with: "You can drop off donations to
                                     Rosie's Place Monday through Friday, from
                                     8:30 am - 4:30 pm. Please note: Rosie's
                                     Place does not accept baby and children's
                                     items, cell phones, computer equipment or
                                     furniture. Please refer to the Household
                                     Goods Recycling of Massachusetts website
                                     for information on where to donate other
                                     types of items.")
    click_button("Create Organization")

    expect(page).to have_content("Your organization has been created.")
    organizer = Organizer.where(user_id: user.id)
    expect(organizer.first.organization.name).to eq("Rosie's Place")
  end

  scenario "logged in user tries to create org without a name" do
    user = FactoryGirl.create(:user)

    sign_in_as(user)
    visit new_organization_path

    fill_in("Address", with: "889 Harrison Ave")
    fill_in("City", with: "Boston")
    select("Massachusetts", from: "State")
    fill_in("Zip Code", with: "02118")

    click_button("Create Organization")

    expect(page).to have_content("Name can't be blank")
    organizer = Organizer.where(user_id: user.id)
    expect(organizer.empty?).to be(true)
  end

  scenario "user cannot create an organization without logging in" do
    visit new_organization_path

    expect(page).to have_content("You need to sign in or sign up to use this
                                  feature.")
  end
end