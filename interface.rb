require "yaml"
require_relative "scraper"

puts "Fetching top 5 urls"
movies = fetch_movies

movie_hashes = []
movies.each do |movie|
  puts "Scraping #{movie}"
  movie_hashes << scrape_movies(movie)
end

puts "Writing to movies.yml"
File.open('movies.yml', 'wb') do |f|
  f.write(movie_hashes.to_yaml)
end

puts "Done"
