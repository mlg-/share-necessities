require "csv"

CSV.foreach("db/seeds/Food_Pantries.csv", { headers: true, header_converters: :symbol, converters: :all}) do |row|
  Organization.create!(row.to_hash)
end

Organization.all.each do |org|
  5.times do
    Item.create!(name: "Warm gloves",
                 quantity: 50,
                 url: "http://amzn.com/B00O7RSFMC",
                 description: "Unisex winter gloves",
                 organization_id: org.id)
  end
end

rosie = Organization.where(name: "Rosie's Place").first
organizer = User.create!(email: "organizer@mailinator.com",
                         password: "password",
                         created_at: Time.now,
                         updated_at: Time.now,
                         first_name: "Barry",
                         last_name: "Nyes")
Organizer.create!(organization_id: rosie.id, user_id: organizer.id)
