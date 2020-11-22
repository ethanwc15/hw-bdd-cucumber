# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    
    #Add each movie to the DB, specifically the Movie table
    Movie.create(movie)
  end
  # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  # Using RegEx to insert corresponding movies to their correct position within the string
  e1String = e1.to_s
  e2String = e2.to_s
  expect page.body =~ /#{e1String}.+#{e2String}/m
  # fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # need to .delete or else there will be space between ratings_ insertRatingHere
  rating_list.delete(' ').split(',').each do |movieRating|
      #if checked... go through checked steps, else go through unchecked step...
      if !uncheck
          steps %Q{Given I check "ratings_#{movieRating}"}
      else
          steps %Q{And I uncheck "ratings_#{movieRating}"}
      end
  end        
  #fail "Unimplemented"
end

Then /I should see all the movies/ do |n_seeds|
  # Make sure that all the movies in the app are visible in the table
  #Grabbing the movies from the table body, which is where all the movies lay
  numberOfMovies = page.all('table#movies tbody tr').count
  fail "Unimplemented"
end
