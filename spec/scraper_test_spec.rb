require_relative '../lib/scraper_side.rb'

describe Scraper do
  let(:test_scraper) { Scraper.new('film_list') }

  describe '#invalid_rank_position' do
    it 'Checks if user\'s choice is a valid (between 1 and 161) rank position' do
      expect(test_scraper.invalid_rank_position(0)).to eql nil
    end
  end
end
