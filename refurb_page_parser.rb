require 'nokogiri'
require 'open-uri'

class RefurbPageParser
  def initialize
    @url = 'http://store.apple.com/ca/browse/home/specialdeals/mac/macbook_air/13'
    @release_date = 'June 2012'
    @ram = '8GB'
    @disk = '128GB'
  end

  def look_for_the_macbook_air_that_I_want
    prices = []
    doc = Nokogiri::HTML( open(@url) )
    doc.css('#primary .product').each do |product|
      specs = product.css('.specs').children.select {|x| x.text?}
      date = specs.find {|z| z.content =~ /Originally released/}
      ram  = specs.find {|z| z.content =~ /memory/}
      disk = specs.find {|z| z.content =~ /flash storage/}

      if date.content.include?( @release_date ) and ram.content.include?( @ram ) and disk.content.include?( @disk )
        prices << product.css('.current_price span[itemprop=price]').first.text.strip
      end
    end
    prices
  end
end