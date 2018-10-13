class ApixuApi
  def self.weather_in(city)
    url = "https://api.apixu.com/v1/current.json?key=#{key}&q=#{city}"
    response = HTTParty.get url
    response.parsed_response['current']
  end

  def self.key
    "1e04eda42d5c48a291721552181310"
  end
end