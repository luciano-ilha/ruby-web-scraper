require 'byebug'
require 'httparty'
require 'nokogiri'
require 'rspec'
require_relative '../lib/scraper.rb'

url = 'https://editorial.rottentomatoes.com/guide/best-netflix-shows-and-movies-to-binge-watch-now/'
unparsed_page = HTTParty.get(url)
parsed_page = Nokogiri::HTML(unparsed_page)
series_list = parsed_page.css('div.countdown-item')
byebug
scraper = Scraper.new(series_list)

scraper.series_info

scraper.invert_series_info

puts "\n"
puts 'Hello!! Please tell us your name!'
user_name = gets.chomp.capitalize
puts "\n"
puts "Welcome #{user_name}! Here we have a list of the 161 best series on Netflix!!"
puts "\n"
puts 'Please choose the ranking position which you want to know more information about (1 - 161). If you wish to see all the series titles type "0".'
user_choice = gets.chomp.to_i
puts "\n"

while user_choice < 0 || user_choice > 161
  puts 'Ranking position invalid! Please chose a position between 1 and 161.'
  user_choice = gets.chomp.to_i
end

while user_choice == 0
  scraper.series_title.each_with_index do |val, index|
    puts "#{index + 1}. #{val}."
    puts "\n"
  end
  puts "Please chose a position between 1 and 161."
  user_choice = gets.chomp.to_i
  puts "\n"
end

puts "You chose rank position: #{scraper.series_countdown_index[user_choice - 1]}."
puts "\n"
puts "Series Title: #{scraper.series_title[user_choice - 1]}."
puts "Starting Date: #{scraper.series_start_date[user_choice - 1]}."
puts "Relevancy Meter Score: #{scraper.series_meter_score[user_choice - 1]}."
puts "#{scraper.series_starring[user_choice - 1]}."
url_user = scraper.series_synopsis_links[user_choice - 1][0].gsub('//www.', 'https://')
unparsed_user_page = HTTParty.get(url_user)
parsed_user_page = Nokogiri::HTML(unparsed_user_page)
series_synopsis = parsed_user_page.css('div.tv-series__series-info--synopsis').text
puts "Series Synopsis: \"#{series_synopsis}\""
