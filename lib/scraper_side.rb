class Scraper
  attr_reader :films_title, :films_start_date, :films_meter_score, :films_countdown_index, :films_starring, :films_synopsis_links
  attr_accessor :user_next_choice, :invalid_rank

  def initialize(film_list)
    @film_list = film_list
    @user_next_choice = ''
    @films_title = []
    @films_start_date = []
    @films_meter_score = []
    @films_countdown_index = []
    @films_starring = []
    @films_synopsis_links = []
    @invalid_rank = true
  end

  def series_info
    @film_list.each do |item|
      @films_title << item.css('div.article_movie_title h2 a').text
      @films_start_date << item.css('span.start-year').text
      @films_meter_score << item.css('span.tMeterScore').text
      @films_countdown_index << item.css('div.countdown-index').text
      @films_starring << item.css('div.cast').text.strip.to_s
      @films_synopsis_links << item.css('div.article_movie_title h2 a').map { |link| link['href'] }
    end
  end

  def invert_series_info
    @films_title = films_title.reverse
    @films_start_date = films_start_date.reverse
    @films_meter_score = films_meter_score.reverse
    @films_countdown_index = films_countdown_index.reverse
    @films_starring = films_starring.reverse
    @films_synopsis_links = films_synopsis_links.reverse
  end

  def invalid_rank_position(user_choice)
    @user_next_choice = user_choice
    while @user_next_choice < 1 || @user_next_choice > 161
      puts 'Ranking position invalid! Please chose a position between 1 and 161.'
      @user_next_choice = gets.chomp.to_i
      @invalid_rank = false
    end
    @user_next_choice
  end
end
