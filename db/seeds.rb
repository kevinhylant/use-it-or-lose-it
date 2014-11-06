# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
order1 = Order.create

recipe1 = Recipe.create(
  big_oven_recipe_id: 1,
  title: 'Title',
  description: 'This is the description.',
  star_rating: 4.752324,
  web_url: 'http://www.flatironschool.com',
  image_url:'http://flatironschool.com/img/fis-tumblr-logo.png',
  review_count: 42,
  instructions: 'These are the instructions. They are very looooonnnnnggggg',
  yield_number: 2
  )

recipe2 = Recipe.create(
  big_oven_recipe_id: 2,
  title: 'Title2',
  description: 'This is the description for 2.',
  star_rating: 4.85,
  web_url: 'http://www.flatironschool.com',
  image_url:'http://flatironschool.com/img/fis-tumblr-logo.png',
  review_count: 84,
  instructions: 'These are the instructions for 2. They are very kinda long',
  yield_number: 2
  )

recipe3 = Recipe.create(
  big_oven_recipe_id: 3,
  title: 'Title3',
  description: 'This is the description for 3.',
  star_rating: 4.95,
  web_url: 'http://www.flatironschool.com',
  image_url:'http://flatironschool.com/img/fis-tumblr-logo.png',
  review_count: 84,
  instructions: 'These are the instructions for 3. They are very kinda long',
  yield_number: 3
  )

recipe1.order= order1
recipe2.order= order1
recipe3.order = order1

recipe1.save
recipe2.save
recipe3.save

pasta1 = Ingredient.create(
  name: "pasta",
  quantity: 2,
  measurement: "box")
  pasta2 = Ingredient.create(
    name: "pasta",
    quantity: 4,
    measurement: "boxes")
  pasta3 = Ingredient.create(
    name: "pasta",
    quantity: 2,
    measurement: "box")
marinara1 = Ingredient.create(
  name: "marinara sauce",
  quantity: 6,
  measurement: "tb")
  marinara2 = Ingredient.create(
    name: "marinara sauce",
    quantity: 6,
    measurement: "tbs")
  marinara3 = Ingredient.create(
    name: "marinara sauce",
    quantity: 6,
    measurement: "tablespoons")
tuna = Ingredient.create(
  name: "tuna",
  quantity: 6,
  measurement: "oz")
meatballs = Ingredient.create(
  name: "meatballs",
  quantity: 1,
  measurement: "lb")
beef = Ingredient.create(
  name: "ground beef",
  quantity: 1,
  measurement: "lb")

recipe1.ingredients << [pasta1, marinara1, tuna]
recipe2.ingredients << [pasta2, marinara2, meatballs]
recipe3.ingredients << [pasta3, marinara3, beef]

