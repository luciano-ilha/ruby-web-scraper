require 'spec_helper'
require 'mechanize'
require_relative '../lib/scraper'

describe 'Scraper' do
  describe 'series_info' do
    url = Mechanize.new
    parsed_page = url.get('https://editorial.rottentomatoes.com/guide/best-netflix-shows-and-movies-to-binge-watch-now/')
    series_list = parsed_page.css('div.countdown-item')
    let(:scraper_test) { Scraper.new(series_list) }
    let(:first_title) { 'Anne with an E' }
    let(:first_serie_date) { '(2017)' }
    let(:first_meter_score) { '60%' }
    let(:first_rank_position) { '#161' }
    let(:first_serie_cast) { 'Starring: AmyBeth McNulty, Dalila Bela, Geraldine James, Corrine Koslo' }
    let(:first_link) { '//www.rottentomatoes.com/tv/anne/' }

    it 'Gets the series title information from website and stores it inside an array' do
      scraper_test.series_info
      expect(scraper_test.series_title[0]).to eq(first_title)
    end

    it 'Gets the series starting date information from website and stores it inside an array' do
      scraper_test.series_info
      expect(scraper_test.series_start_date[0]).to eq(first_serie_date)
    end

    it 'Gets the series relevance meter score information from website and stores it inside an array' do
      scraper_test.series_info
      expect(scraper_test.series_meter_score[0]).to eq(first_meter_score)
    end

    it 'Gets the series rank position information from website and stores it inside an array' do
      scraper_test.series_info
      expect(scraper_test.series_countdown_index[0]).to eq(first_rank_position)
    end

    it 'Gets the series cast information from website and stores it inside an array' do
      scraper_test.series_info
      expect(scraper_test.series_cast[0]).to eq(first_serie_cast)
    end

    it 'Gets the series links from website and stores it inside an array' do
      scraper_test.series_info
      expect(scraper_test.series_synopsis_links[0][0]).to eq(first_link)
    end
  end

  describe 'invert_series_info' do
    url = Mechanize.new
    parsed_page = url.get('https://editorial.rottentomatoes.com/guide/best-netflix-shows-and-movies-to-binge-watch-now/')
    series_list = parsed_page.css('div.countdown-item')
    let(:scraper_test) { Scraper.new(series_list) }
    let(:first_inverted_title) { 'Master of None' }
    let(:first_inverted_serie_date) { '(2015)' }
    let(:first_inverted_meter_score) { '100%' }
    let(:first_inverted_rank_position) { '#1' }
    let(:first_inverted_serie_cast) { 'Starring: Aziz Ansari, Cady Huffman, Ravi Patel, Claire Danes' }
    let(:first_inverted_link) { '//www.rottentomatoes.com/tv/master_of_none/' }

    it 'Inverts the series title information previously acquired from website and stores it inside an array' do
      scraper_test.series_info
      scraper_test.invert_series_info
      expect(scraper_test.series_title[0]).to eq(first_inverted_title)
    end

    it 'Inverts the series start date information previously acquired from website and stores it inside an array' do
      scraper_test.series_info
      scraper_test.invert_series_info
      expect(scraper_test.series_start_date[0]).to eq(first_inverted_serie_date)
    end

    it 'Inverts the series relevance meter score information previously acquired from website and stores it inside an array' do
      scraper_test.series_info
      scraper_test.invert_series_info
      expect(scraper_test.series_meter_score[0]).to eq(first_inverted_meter_score)
    end

    it 'Inverts the the series rank position information previously acquired from website and stores it inside an array' do
      scraper_test.series_info
      scraper_test.invert_series_info
      expect(scraper_test.series_countdown_index[0]).to eq(first_inverted_rank_position)
    end

    it 'Inverts the series cast information previously acquired from website and stores it inside an array' do
      scraper_test.series_info
      scraper_test.invert_series_info
      expect(scraper_test.series_cast[0]).to eq(first_inverted_serie_cast)
    end

    it 'Inverts the series links previously acquired from website and stores it inside an array' do
      scraper_test.series_info
      scraper_test.invert_series_info
      expect(scraper_test.series_synopsis_links[0][0]).to eq(first_inverted_link)
    end
  end
end
