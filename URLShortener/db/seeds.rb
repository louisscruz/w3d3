# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

louis = User.create!(email: "test@me.com")
sam = User.create!(email: "iwanttestemail@.com")

link1 = ShortenedUrl.create_for_user_and_long_url!(louis, "https://www.google.com")
link2 = ShortenedUrl.create_for_user_and_long_url!(sam, "https://facebook.com")

visit1 = Visit.record_visit!(louis, link2)
visit2 = Visit.record_visit!(sam, link2)
visit3 = Visit.record_visit!(sam, link2)
