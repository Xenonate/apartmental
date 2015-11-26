module SearchesHelper

  def self.request_travel_time(call)
      url = URI.parse(URI.encode("http://api2.walkscore.com/api/v1/traveltime/json?wsapikey=b72221d8763203418d081f140357696e&#{call}"))
      json = HTTParty.get(url)
      response = JSON.parse(json.body)
      if response
      (response["response"]["results"][0]["travel_times"][0]["seconds"])/60 #in mins
      else
        0
      end
    end

    def self.get_crime_score(crime_rate)
      case crime_rate
      when "A"
        95
      when "B"
        85
      when "C"
        75
      end
    end

    def self.get_walkscore(address)
      address.walkscore.to_i
    end

    def self.get_range(max, min)
      max.to_i-min.to_i
    end


end
