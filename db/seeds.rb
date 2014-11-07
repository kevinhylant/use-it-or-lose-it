# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or buildd alongside the db with db:setup).
#
order1 = Order.new

recipe1 = order1.recipes.build(
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

recipe2 = order1.recipes.build(
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

recipe3 = order1.recipes.build(
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

pasta1 = recipe1.ingredients.build(
  name: "pasta",
  quantity: 2,
  measurement: "box")
marinara1 = recipe1.ingredients.build(
  name: "marinara sauce",
  quantity: 6,
  measurement: "tablespoon")
tuna = recipe1.ingredients.build(
  name: "tuna",
  quantity: 6,
  measurement: "ounce")

pasta2 = recipe2.ingredients.build(
    name: "pasta",
    quantity: 4,
    measurement: "boxes")
marinara2 = recipe2.ingredients.build(
    name: "marinara sauce",
    quantity: 6,
    measurement: "tablespoons")
meatballs = recipe2.ingredients.build(
  name: "meatballs",
  quantity: 1,
  measurement: "lb")

pasta3 = recipe3.ingredients.build(
  name: "pasta",
  quantity: 2,
  measurement: "box")  
marinara3 = recipe3.ingredients.build(
  name: "marinara sauce",
  quantity: 6,
  measurement: "tablespoons")
beef = recipe3.ingredients.build(
  name: "salt",
  quantity: 0,
  measurement: "pinch")

order1.save


