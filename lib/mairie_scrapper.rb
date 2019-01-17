require 'open-uri'
require 'nokogiri'

def get_townhall_urls
  $array_urls = []
  main_url = "http://annuaire-des-mairies.com"
  url = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  url.xpath('//a[@class="lientxt"]/@href').each do |url|
  $array_urls << main_url + url.content[1..-1]
  end
end

def   get_townhall_names
  doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  doc.xpath('//a[@class="lientxt"]').each do |name|
    $array_names << name.content.split.map(&:capitalize).join(' ')
  end
end

def get_townhall_email(townhall_url)
    doc = Nokogiri::HTML(open(townhall_url))
    doc.xpath('//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |email|
      $array_emails << email.content
    end
end
def perform
  $array_emails = []
  $array_names = []
  get_townhall_urls
  get_townhall_names


$array_urls.each do |e|
  get_townhall_email(e)
end
hash = $array_names.zip($array_emails).to_h
puts hash
puts "Il y a #{$array_names.length} mairies dans le Val d'Oise"
end
perform
