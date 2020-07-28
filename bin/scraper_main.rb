require 'byebug'
require 'mechanize'
require_relative '../lib/scraper.rb'

def invalid_choice(user_choice)
  while user_choice.negative? || user_choice > 161
    puts 'Ranking position invalid! Please chose a position between 1 and 161.'
    user_choice = gets.chomp.to_i
  end
  user_choice
end

def list_choice(user_choice, scraper)
  user_choice = invalid_choice(user_choice)
  while user_choice.zero?
    scraper.series_title.each_with_index do |val, index|
      puts "#{index + 1}. #{val}."
      puts "\n"
    end
    puts 'Please chose a position between 1 and 161.'
    user_choice = gets.chomp.to_i
    puts "\n"
    user_choice = invalid_choice(user_choice)
  end
  user_choice
end

url = Mechanize.new
parsed_page = url.get('https://editorial.rottentomatoes.com/guide/best-netflix-shows-and-movies-to-binge-watch-now/')
series_list = parsed_page.css('div.countdown-item')
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

user_choice = list_choice(user_choice, scraper)

puts "You chose rank position: #{scraper.series_countdown_index[user_choice - 1]}."
puts "\n"
puts "Series Title: #{scraper.series_title[user_choice - 1]}."
puts "Starting Date: #{scraper.series_start_date[user_choice - 1]}."
puts "Relevancy Meter Score: #{scraper.series_meter_score[user_choice - 1]}."
puts "#{scraper.series_cast[user_choice - 1]}."
url_link = scraper.series_synopsis_links[user_choice - 1][0].gsub('//www.', 'https://')
url_user = Mechanize.new
parsed_user_page = url_user.get(url_link)
series_synopsis = parsed_user_page.css('div.tv-series__series-info--synopsis').text
puts "Series Synopsis: \"#{series_synopsis}\""
