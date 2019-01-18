# Exercice THP liste des députés
require 'pry'
require 'nokogiri'
require 'open-uri'

# metode return_url permettant de recuperer tout les liens des députes de la liste
# et de stocke les données dans un array url
def return_url
  url = []
  doc = Nokogiri::HTML(open('https://www.nosdeputes.fr/deputes'))
  doc.xpath('//td/a').each do |node|
    url << node['href']
  end
  return url
end

# methode deputy_info permettant de récupérer lpour chaque lien passe en parmatre
# l'email et premnom nom, puis de partager prenom nom en 2 variables prénom et nol
# et de stocker toutes ces infos dans un hash liste_deputes
def deputy_info(urls)
  liste_deputes = []
  urls.each do |url|
    hash = {}
    doc = Nokogiri::HTML(open("https://www.nosdeputes.fr#{url}"))
    name_depute =  (doc.xpath('//h1').text.split())
    hash[:first_name] = name_depute[0]
    hash[:last_name] =  name_depute[1]
    hash[:email] =  doc.xpath('//*[@id="b1"]/ul[2]/li[1]/ul/li[1]/a').text
    liste_deputes << hash
  end
  return liste_deputes
end


#binding.pry

def perform
  puts list_final = deputy_info(return_url)
  fname = "liste_deputes.txt"
  somefile = File.open(fname,"w")
  somefile.puts(list_final)
  somefile.close
end

perform
