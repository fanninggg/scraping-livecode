require "open-uri"
require "nokogiri"

def fetch_movies
  # TODO: Fetch the top 5 movies from imdb
  # 1. Find the url
  url = 'https://www.imdb.com/chart/top'
  # 2. Open the url as a nokogiri document
  file = open(url).read
  doc = Nokogiri::HTML(file)
  # 3. Inspect the url for the info we want
  # 4. Search the document and extract the relavant info
  movies = doc.search('.titleColumn a').first(5)
  links_array = []
  movies.each do |movie|
    links_array << movie.attributes['href'].value
  end
  return links_array
end

def scrape_movies(url)
  # TODO: Scrape the title, year, storyline, director & cast and build a hash
  # 1. Open the appropriate url
  url = "https://www.imdb.com#{url}"
  file = open(url).read
  # 2. Convert to a nokogiri document
  doc = Nokogiri::HTML(file)
  # 3. Inspect the page for the relevant info
  # 4. Find a title
  title = doc.search('.title_wrapper h1').text.split('(')[0].strip
  # 5. Find a year
  year = doc.search('#titleYear a').text.to_i
  # 6. Find a storyline
  synopsis = doc.search('.summary_text').text.strip
  # 7. Find a director
  director = doc.search('.plot_summary .credit_summary_item:first-of-type a').text
  # 8. Find a cast
  cast = []
  cast_element = doc.search('.plot_summary .credit_summary_item:last-of-type a').first(3).each do |member|
    cast << member.text
  end
  # 9. Build a hash for each movie
  return {
    title: title,
    year: year,
    synopsis: synopsis,
    director: director,
    cast: cast
  }
end
