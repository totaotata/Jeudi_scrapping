require 'open-uri'
require 'nokogiri'

def crypto
  doc = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

  array_value = []
  array_name = []
  tab = []

    doc.xpath('//a[@class="link-secondary"]').each do |name|
        array_name << name.content
    end
    doc.xpath('//a[@class="price"]/@data-usd').each do |value|
        array_value << value.content
    end

  tab = array_name.zip(array_value).to_h
  puts tab
end
crypto


