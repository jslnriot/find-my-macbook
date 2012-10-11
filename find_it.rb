require 'ruby-progressbar'
require './refurb_page_parser'

class FindIt
  def start
    puts "Starting to find a refurbished MacBook Air for Neil..."
    @progress_bar = ProgressBar.create(:title => "Waiting", :starting_at => 0, :total => 120)
    @parser = RefurbPageParser.new
    run
  end

  def run
    prices = @parser.look_for_the_macbook_air_that_I_want

    while prices.empty?
      puts "#{Time.now.strftime("%b %-d, %k:%M")} - Nope"
      @progress_bar.reset
      120.times do |i|
        @progress_bar.increment
        sleep 15  # 120 x 15 seconds = 30 minutes
      end
      prices = @parser.look_for_the_macbook_air_that_I_want
    end

    puts 'Found something!!!', ''
    puts prices
    puts '', ''
  end
end

FindIt.new.start