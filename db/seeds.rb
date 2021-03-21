# frozen_string_literal: true

require 'faker'

whisky_brands = [
  { name: 'Nikka', country: 'JP', description: 'Samurai whisky factory from Japan' },
  { name: 'Copper Dog', country: 'GB', description: 'Truthy scottish whisky with stuff' },
  { name: 'Jameson', country: 'IE', description: 'Each other Irish man should try it' }
]
whisky_brands.each { |wb| Whisky::Brand.find_or_create_by(wb) }
users = [
  { email: 'naumenkoniki@gmail.com', password: 'password', role: :admin },
  { email: 'user@mail.ru', password: 'password', role: :user },
  { email: 'full@mail.ru', password: 'password', role: :user }
]
users.each do |u|
  user = User.find_or_initialize_by(email: u[:email])
  user.password = u[:password]
  user.role = u[:role]
  user.save!
end

whiskies = [
  {
    title: Faker::Beer.name,
    description: Faker::Lorem.paragraph,
    brand: Whisky::Brand.find_by(name: 'Nikka')
  },
  {
    title: Faker::Beer.name,
    description: Faker::Lorem.paragraph,
    brand: Whisky::Brand.find_by(name: 'Nikka')
  },
  {
    title: Faker::Beer.name,
    description: Faker::Lorem.paragraph,
    brand: Whisky::Brand.find_by(name: 'Nikka')
  },
  {
    title: Faker::Beer.name,
    description: Faker::Lorem.paragraph,
    brand: Whisky::Brand.find_by(name: 'Jameson')
  },
  {
    title: Faker::Beer.name,
    description: Faker::Lorem.paragraph,
    brand: Whisky::Brand.find_by(name: 'Jameson')
  },
  {
    title: Faker::Beer.name,
    description: Faker::Lorem.paragraph,
    brand: Whisky::Brand.find_by(name: 'Jameson')
  },
  {
    title: Faker::Beer.name,
    description: Faker::Lorem.paragraph,
    brand: Whisky::Brand.find_by(name: 'Copper Dog')
  },
  {
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    brand: Whisky::Brand.find_by(name: 'Copper Dog')
  },
  {
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph,
    brand: Whisky::Brand.find_by(name: 'Copper Dog')
  }
]
whiskies.each { |whisky| Whisky.find_or_create_by(whisky) }

100.times do
  whisky = Whisky.all.sample
  user = User.all.sample
  review_params = {
    summary: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    color: Whisky::Review.colors.keys.sample,
    taste: Whisky::Review.tastes.keys.sample,
    smokiness: rand(0..5),
    user: user
  }
  review = whisky.reviews.new(review_params)
  review.publish!
end
