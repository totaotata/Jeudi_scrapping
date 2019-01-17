require 'open-uri'
  require 'nokogiri'

  doc = Nokogiri::HTML(open("http://gemmaray.tv/content/wp-login.php?redirect_to=http%3A%2F%2Fgemmaray.tv%2Fcontent%2Fwp-admin%2Fadmin.php&reauth=1"))
  doc.xpath('//*[@id="loginform"]/p[1]/label').each do |node|
    puts node.text
  end
