require 'rails_helper'

describe "BeermappingApi" do
  it "When HTTP GET returns one entry, it is parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>18856</id><name>Panimoravintola Koulu</name><status>Brewpub</status><reviewlink>https://beermapping.com/location/18856</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18856&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18856&amp;d=1&amp;type=norm</blogmap><street>Eerikinkatu 18</street><city>Turku</city><state></state><zip>20100</zip><country>Finland</country><phone>(02) 274 5757</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*turku/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("turku")

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("Panimoravintola Koulu")
    expect(place.street).to eq("Eerikinkatu 18")
  end

  it "When HTTP GET returns no entries, nil is returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id></id><name></name><status></status><reviewlink></reviewlink><proxylink></proxylink><blogmap></blogmap><street></street><city></city><state></state><zip></zip><country></country><phone></phone><overall></overall><imagecount></imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*turku/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("turku")

    expect(places.size).to eq(0)
    expect(places).to eq([])
  end

  it "When HTTP GET returns many entries, they are parsed and returned" do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>18856</id><name>Panimoravintola Koulu</name><status>Brewpub</status><reviewlink>https://beermapping.com/location/18856</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=18856&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=18856&amp;d=1&amp;type=norm</blogmap><street>Eerikinkatu 18</street><city>Turku</city><state></state><zip>20100</zip><country>Finland</country><phone>(02) 274 5757</phone><overall>0</overall><imagecount>0</imagecount></location><location><id>21804</id><name>Brewdog Helsinki</name><status>Beer Bar</status><reviewlink>https://beermapping.com/location/21804</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=21804&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=21804&amp;d=1&amp;type=norm</blogmap><street>Tarkk'ampujankatu 20</street><city>Helsinki</city><state></state><zip>00150</zip><country>Finland</country><phone></phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*turku/).to_return(body: canned_answer, headers: { 'Content-Type' => "text/xml" })

    places = BeermappingApi.places_in("turku")

    expect(places.size).to eq(2)
    place = places.first
    expect(place.name).to eq("Panimoravintola Koulu")
    expect(place.street).to eq("Eerikinkatu 18")

    place = places.second
    expect(place.name).to eq("Brewdog Helsinki")
    expect(place.street).to eq("Tarkk'ampujankatu 20")
  end
end
