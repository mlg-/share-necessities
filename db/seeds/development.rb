require 'csv'

CSV.foreach("db/seeds/Food_Pantries.csv", { headers: true, header_converters: :symbol, converters: :all}) do |row|
  Organization.create!(row.to_hash)
end