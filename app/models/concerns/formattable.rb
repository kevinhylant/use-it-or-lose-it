require 'active_support/core_ext/string/inflections'

module Formattable

	class Formatter

		def to_search_url(array_list)
			query = array_list.join('%20and%20')
			"http://api.bigoven.com/recipes?any_kw=#{query}&pg=1&rpp=20&api_key=dvx1W0MNFK7NO2qLpiG0jGOdk6m9u0m3"
		end

		def lib
			["hot", "-- marinate --", "-- --", "fresh", "sauce", "skinless", "boneless", "stewed", "fesh", "pieces", "dry", "sliced", "finely", "shredded", "gourmet", "garden", "minced", "chopped", "grated"]
		end

		def create_ingredient_list(id)
			recipe_response = Unirest.get("http://api.bigoven.com/recipe/#{id}?api_key=dvx1W0MNFK7NO2qLpiG0jGOdk6m9u0m3", headers:{ "Accept" => "application/json"})
			recipe_response.body["Ingredients"].collect do |i| 
				temp = i["Name"].downcase
				temp.split.each { |w| temp.gsub!(w + " " , "") if lib.include?(w) }
				temp.strip
			end
		end

		def to_ids_hash(search_url)
			response = Unirest.get(search_url, headers:{ "Accept" => "application/json"})
			ing_lists = {}
			response.body["Results"].each_with_index do |recipe, index|
				id = response.body["Results"][index]["RecipeID"]
				ing_lists[id] = create_ingredient_list(id)
			end
			return ing_lists
		end

		def most_similar(array_list)
			temp_array_1 = array_list[0]
			temp_array_2 = array_list[1]
			temp_comp = temp_array_1 + temp_array_2

			array_list[0..-2].each_with_index do |array1, index|
				array_list[index+1..-1].each do |array2|
					t = array1 + (array2 - array1)
					if t.length < temp_comp.length
						temp_array_1 = array1
						temp_array_2 = array2
						temp_comp = t
					end
				end
			end
			return [temp_array_1, temp_array_2, temp_comp]
		end

		def most_similar_to(all_temps, array_list)
			the_array = all_temps[2]
			array_list.delete(all_temps[0])
			array_list.delete(all_temps[1])

			temp_array = array_list[0]
			temp_comp = temp_array + the_array

			array_list[0..-1].each do |array2|
				t = the_array + (array2 - the_array)
				if t.length < temp_comp.length
					temp_array = array2
					temp_comp = t
				end
			end
			return [temp_array, temp_comp]
		end

		def remove_redundant_singulars(array)
			array.delete_if { |x| x != x.pluralize && array.include?(x.pluralize) }
		end

		def recipe_ids(ids_hash, two_similar, three_similar)
			[ids_hash.key(two_similar[0]), ids_hash.key(two_similar[1]), ids_hash.key(three_similar[0])]
		end

		def format_hash(id)
			recipe_response = Unirest.get("http://api.bigoven.com/recipe/#{id}?api_key=dvx1W0MNFK7NO2qLpiG0jGOdk6m9u0m3", headers:{ "Accept" => "application/json"})
			recipe = { big_oven_recipe_id: recipe_response.body["RecipeID"],
								 title: recipe_response.body["Title"],
								 description: recipe_response.body["Description"],
								 star_rating: recipe_response.body["StarRating"],
								 web_url: recipe_response.body["WebURL"],
								 image_url: recipe_response.body["ImageURL"],
								 review_count: recipe_response.body["ReviewCount"],
								 instructions: recipe_response.body["Instructions"],
								 yield_number: recipe_response.body["YieldNumber"],
								 # yield_unit: recipe_response.body["YieldUnit"],
								 # total_minutes: recipe_response.body["TotalMinutes"] 
							 }
			ingredients = recipe_response.body["Ingredients"].map do |ingredient_hash|
				{
					name: ingredient_hash["Name"],
					display_quantity: ingredient_hash["Unit"],
					unit: ingredient_hash["Quantity"]
				}
			end
			{recipe: recipe, ingredients: ingredients}
		end

	end

	def format(food_array)
		f = Formatter.new
		ids_hash = f.to_ids_hash(f.to_search_url(food_array))
		two_similar = f.most_similar(ids_hash.values)
		three_similar = f.most_similar_to(two_similar, ids_hash.values)
		ids_array = f.recipe_ids(ids_hash, two_similar, three_similar)
		ids_array.collect{ |id| f.format_hash(id) }
	end

end