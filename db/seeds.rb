require 'securerandom'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
    Fish.create(title: "New Species of Fish: #{SecureRandom.hex}", body: 'Slim', fins: 4, school: 'of rock')
end