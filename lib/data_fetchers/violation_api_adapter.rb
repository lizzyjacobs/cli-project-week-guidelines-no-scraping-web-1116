class ViolationApiAdapter
  BASE_URL = "https://data.cityofnewyork.us/resource/xx67-kt59.json"
  attr_reader :restaurant, :zip_code

  def initialize(restaurant, zip_code)
    @restaurant = restaurant
    @zip_code = zip_code
  end

  def fetch_violations
    exist = 0
    violation_data = RestClient.get(BASE_URL)
    violation_array = JSON.parse(violation_data)
    violation_array.each do |violation|
      if violation["dba"] == restaurant && violation["zipcode"] == zip_code
        exist += 1
        new_output = ViolationOutput.new((violation["street"]), (violation["grade"]), (violation["violation_description"]))
      end
    end
    if exist == 0
      puts "Woops! Can't find what you're looking for. Please try a new restaurant."
      ViolationsCLI.new.call
    end
  end

end
