require 'nokogiri'
require 'httparty'
require 'pry'

def scraper
  films_title = []
  films_start_date = []
  films_meter_score = []
  films_countdown_index = []
  films_starring = []
  url = 'https://editorial.rottentomatoes.com/guide/best-netflix-shows-and-movies-to-binge-watch-now/'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  film_list = parsed_page.css('div.countdown-item')
  film_list.each do |item|
    films_title << item.css('div.article_movie_title h2 a').text
    films_start_date << item.css('span.start-year').text
    films_meter_score << item.css('span.tMeterScore').text
    films_countdown_index << item.css('div.countdown-index').text
    films_starring << item.css('div.cast').text.strip.to_s
  end
  films_synopsis_links = film_list.css('div.synopsis a').map { |link| link['href'] }
  films_title = films_title.reverse
  films_start_date = films_start_date.reverse
  films_meter_score = films_meter_score.reverse
  films_countdown_index = films_countdown_index.reverse
  films_starring = films_starring.reverse
  films_synopsis_links = films_synopsis_links.reverse
  puts "\n"
  puts 'Hello!! Please tell us your name!'
  user_name = gets.chomp.capitalize
  puts "\n"
  puts "Welcome #{user_name}! Here we have a list of the 161 best series on Netflix!!"
  puts "\n"
  puts 'Please choose the ranking position which you want to know more information about.'
  user_choice = gets.chomp.to_i
  puts "\n"
  while user_choice < 1 || user_choice > 161
    puts 'Position invalid! Please chose position between 1 and 161.'
    user_choice = gets.chomp.to_i
    puts "\n"
  end
  puts "You chose rank position: #{films_countdown_index[user_choice - 1]}."
  puts "\n"
  puts "Film Title: #{films_title[user_choice - 1]}."
  puts "Starting Date: #{films_start_date[user_choice - 1]}."
  puts "Relevancy Meter Score: #{films_meter_score[user_choice - 1]}."
  puts "#{films_starring[user_choice - 1]}."
  url_user = films_synopsis_links[user_choice - 1].gsub('//www.', 'https://')
  unparsed_user_page = HTTParty.get(url_user)
  parsed_user_page = Nokogiri::HTML(unparsed_user_page)
  film_synopsis = parsed_user_page.css('div.tv-series__series-info--synopsis').text
  puts "Film Synopsis: \"#{film_synopsis}\""
end
scraper
