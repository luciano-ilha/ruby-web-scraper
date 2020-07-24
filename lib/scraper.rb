class Scraper
  attr_reader :series_title, :series_start_date, :series_meter_score, :series_countdown_index, :series_starring, :series_synopsis_links

  def initialize(series_list)
    @series_list = series_list
    @series_title = []
    @series_start_date = []
    @series_meter_score = []
    @series_countdown_index = []
    @series_starring = []
    @series_synopsis_links = []
  end

  def series_info
    @series_list.each do |item|
      @series_title << item.css('div.article_movie_title h2 a').text
      @series_start_date << item.css('span.start-year').text
      @series_meter_score << item.css('span.tMeterScore').text
      @series_countdown_index << item.css('div.countdown-index').text
      @series_starring << item.css('div.cast').text.strip.to_s
      @series_synopsis_links << item.css('div.article_movie_title h2 a').map { |link| link['href'] }
    end
  end

  def invert_series_info
    @series_title = series_title.reverse
    @series_start_date = series_start_date.reverse
    @series_meter_score = series_meter_score.reverse
    @series_countdown_index = series_countdown_index.reverse
    @series_starring = series_starring.reverse
    @series_synopsis_links = series_synopsis_links.reverse
  end
end
