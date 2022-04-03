# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 authority = User.create!(
     name: 'UofM Authority',
    email: 'report@memphis.edu',
    phone_no: '9012345678',
    password: 'authority',
    uid: 'U00000000',
    password_confirmation: 'authority',
    authority: true
)