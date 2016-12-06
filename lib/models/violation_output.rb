class ViolationOutput


  attr_accessor :street, :grade, :description
  ALL = []

  def initialize(street, grade, description)
    @street = street
    @grade = grade
    @description = description
    ALL << self
  end

  def self.all
    ALL
  end

end
