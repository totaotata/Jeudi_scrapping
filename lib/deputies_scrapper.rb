

require 'nokogiri'
require 'open-uri'


def return_url
  url = []
  doc = Nokogiri::HTML(open('https://www.nosdeputes.fr/deputes'))
  doc.xpath('//td/a').each do |node|
    url << node['href']
  end
  return url
end
def deputy_info(urls)
  list_deputes = []
  urls.each  do |url|
      hash = {}
  doc = Nokogiri::HTML(open("https://www.nosdeputes.fr#{url}"))
  name_depute = (doc.xpath('//h1').text.split())
  hash[:first_name] = name_depute[0]
  hash[:list_name] = name_depute[1]
  hash[:email] =  doc.xpath('//*[@id="b1"]/ul[2]/li[1]/ul/li[1]/a').text
  list_deputes << hash
  end
  return list_deputes
end

def perform
puts list_final = deputy_info(return_url)
fname = "liste deputes.txt"
somefile = File.open(fname, "w")
somefile.puts(list_final)
somefile.close
end
perform