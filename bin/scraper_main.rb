require 'nokogiri'
require 'httparty'
require 'byebug'
require_relative '../lib/scraper_side.rb'

url = 'https://editorial.rottentomatoes.com/guide/best-netflix-shows-and-movies-to-binge-watch-now/'
unparsed_page = HTTParty.get(url)
parsed_page = Nokogiri::HTML(unparsed_page)
film_list = parsed_page.css('div.countdown-item')
user_choice = ""

scraper = Scraper.new(film_list, user_choice)

scraper.get_series_info

scraper.invert_series_info

puts "\n"
puts 'Hello!! Please tell us your name!'
user_name = gets.chomp.capitalize
puts "\n"
puts "Welcome #{user_name}! Here we have a list of the 161 best series on Netflix!!"
puts "\n"
puts 'Please choose the ranking position which you want to know more information about.'
scraper.user_choice = gets.chomp.to_i
puts "\n"

scraper.invalid_rank_position

puts "You chose rank position: #{scraper.films_countdown_index[scraper.user_choice - 1]}."
puts "\n"
puts "Film Title: #{scraper.films_title[scraper.user_choice - 1]}."
puts "Starting Date: #{scraper.films_start_date[scraper.user_choice - 1]}."
puts "Relevancy Meter Score: #{scraper.films_meter_score[scraper.user_choice - 1]}."
puts "#{scraper.films_starring[scraper.user_choice - 1]}."

url_user = scraper.films_synopsis_links[scraper.user_choice - 1][0].gsub('//www.', 'https://')
unparsed_user_page = HTTParty.get(url_user)
parsed_user_page = Nokogiri::HTML(unparsed_user_page)
film_synopsis = parsed_user_page.css('div.tv-series__series-info--synopsis').text
puts "Film Synopsis: \"#{film_synopsis}\""
