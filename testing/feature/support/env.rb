require 'rspec'
require 'net/http'

Before do
  Persona.all.each{|persona| persona.clear_articles}

  uri = URI.parse 'http://localhost:4567'

  http = Net::HTTP.new(uri.host, uri.port)

  request = Net::HTTP::Get.new("/clear/store")
  last_response = http.request request
  last_response.code.should == 200.to_s
end

After do
  Persona.all.each{|persona| persona.close_browser}
end