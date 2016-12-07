# require 'pry'
# class ViolationsCLI
#
#   def call
#     first_response
#   end
#
#   def greet_user
#     puts "Where would you like to dine tonight? We can help you see if it's up to health code standards!"
#     puts "Type 'start' if you're ready to go, 'help' if you don't know what to do, 'hungry' if you're famished, and 'exit' if you're all done."
#     gets.strip
#   end
#
#   def first_response
#     response = greet_user
#     if response == "start"
#       get_going
#     elsif response == "help"
#       puts "Type your answers in the command line."
#       get_going
#     elsif response == "hungry"
#       puts "Me too. So let's get started..."
#       get_going
#     elsif response == "exit"
#       puts "See you later!"
#     else
#       first_response
#     end
#     # first_response
#   end
#
#   def get_going
#     zip = get_zip_code
#     restaurant_choice = get_restaurant
#     fetch_violations(restaurant_choice, zip)
#     render_violations
#     first_response
#   end
#
#   def get_zip_code
#     puts "What zip code are you dining in?"
#     gets.strip
#   end
#
#   def get_restaurant
#     puts "Which restaurant?"
#     gets.strip.upcase
#   end
#
#   def fetch_violations(restaurant_choice, zip)
#     adapter = ViolationApiAdapter.new(restaurant_choice, zip)
#     adapter.fetch_violations
#   end
#
#   def render_violations
#     violations = ViolationOutput.all
#     puts "The #{violations[0].street.downcase.capitalize} location has a restaurant grade of #{violations[0].grade}."
#     puts "Here's what the health inspectors had to say: "
#     violations.each_with_index do |violation, index|
#       puts "#{index + 1}. #{violation.description}"
#     end
#   end
#
# end
#
# --

require 'pry'
class ViolationsCLI
   def call
    greet_user
    instruct_user
    input = gets.strip
    until input == 'exit'
      until input == "start"
      puts "Type 'start' to start searching for a restaurant or 'exit' to leave."
      input = gets.strip
      end
    puts "Now we can get started! Type 'help' if you get stuck."
    zip = get_zip_code
    restaurant_choice = get_restaurant
    send_user_info(restaurant_choice, zip)
    ask_hungry
    instruct_user
    input = gets.strip
    end
  puts "bye for now!"
  end
  def greet_user
    puts "Where would you like to dine tonight? We can help you see if it's up to health code standards!"
  end
  def instruct_user
    puts "Type 'start' if you're ready to go and 'exit' if you're all done."
  end
  def get_zip_code
    puts "What zip code are you dining in?"
    input = gets.strip
    while input == "help"
      puts "enter a five-digit zip code. Try '11224' if you're stuck!"
      input = gets.strip
    end
    input
  end
  def get_restaurant
    puts "Which restaurant?"
    input = gets.strip
    while input == "help"
      puts "enter a restaurant name. Try 'Riviera Caterer' if you're stuck!"
      input = gets.strip
    end
    input.upcase
  end
  def send_user_info(restaurant_choice, zip)
    fetch_violations(restaurant_choice, zip)
    render_violations
  end
  def fetch_violations(restaurant_choice, zip)
    adapter = ViolationApiAdapter.new(restaurant_choice, zip)
    adapter.fetch_violations
  end
  def render_violations
    violations = ViolationOutput.all
    puts "The #{violations[0].street.downcase.capitalize} location has a restaurant grade of #{violations[0].grade}."
    puts "Here's what the health inspectors had to say: "
    violations.each_with_index do |violation, index|
      puts "#{index + 1}. #{violation.description}"
    end
  end
  def ask_hungry
    puts "Still hungry? yes/no"
      response = gets.strip
      if response.downcase == "yes"
        puts "No health code violation can spoil YOUR delicious dinner!"
        puts "Plus, the mice gave this place five stars on Yelp."
      elsif response.downcase == "no"
        puts "Hope you're still hunry for more health code violation data, at least!"
      else
        puts "Not sure what you said there, but I'll leave it up to you to decide what to do next:"
      end
    end
end
