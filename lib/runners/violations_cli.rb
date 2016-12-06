require 'pry'
class ViolationsCLI

  def call
    first_response
  end

  def greet_user
    puts "Where would you like to dine tonight? We can help you see if it's up to health code standards!"
    puts "Type 'start' if you're ready to go, 'help' if you don't know what to do, 'hungry' if you're famished, and 'exit' if you're all done."
    gets.strip
  end

  def first_response
    response = greet_user
    if response == "start"
      get_going
    elsif response == "help"
      puts "Type your answers in the command line."
      get_going
    elsif response == "hungry"
      puts "Me too. So let's get started..."
      get_going
    elsif response == "exit"
      "See you later!"
    else
      first_response
    end
  end

  def get_going
    zip = get_zip_code
    restaurant_choice = get_restaurant
    fetch_violations(restaurant_choice, zip)
    render_violations
  end

  def get_zip_code
    puts "What zip code are you dining in?"
    gets.strip
  end

  def get_restaurant
    puts "Which restaurant?"
    gets.strip.upcase
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

end
