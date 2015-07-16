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