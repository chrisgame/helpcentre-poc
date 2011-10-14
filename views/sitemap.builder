xml.instruct! :xml, :version => '1.0'
xml.urlset do
    xml.url do
        xml.loc "http://cold-journey-9363.heroku.com/"
        xml.lastmod "2005-01-01"
        xml.changefreq "daily"
        xml.priority "0.8"
    end

    urls.each do |value|
        xml.url do
            xml.loc "http://cold-journey-9363.heroku.com/#{value}"
            xml.lastmod "2005-01-01"
            xml.changefreq "hourly"
            xml.priority "0.9"
        end
    end

end