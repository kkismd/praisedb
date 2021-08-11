# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = Home.create!(id: 0, name: 'admin', status: :admin)
User.create!(id: 0, home: admin, name: 'admin', password: 'abc12345', status: :admin)

tlc = Home.create!(id: 1, name: 'tlc')
User.create!(id: 1, home: tlc, name: 'zion', password: 'shimomaruko')

Folder.create!(id: 1, title: '常用', sticky: true)