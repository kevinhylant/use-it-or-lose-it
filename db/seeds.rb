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

pasta = Ingredient.create(
    name: "pasta",
    display_quantity: 1,
    unit: "box")
marinara = Ingredient.create(
  name: "marinara sauce",
  display_quantity: 2,
  unit: "can")
tuna = Ingredient.create(
  name: "tuna",
  display_quantity: 6,
  unit: "oz")
meatballs = Ingredient.create(
  name: "meatballs",
  display_quantity: 1,
  unit: "lb")
beef = Ingredient.create(
  name: "ground beef",
  display_quantity: 1,
  unit: "lb")

recipe1.ingredients << [pasta, marinara, tuna]
recipe2.ingredients << [pasta, marinara, meatballs]
recipe3.ingredients << [pasta, marinara, beef]
