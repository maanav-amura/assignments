# Error module for Numeric Data
module Error
  # Age Error class
  class AgeError < StandardError
    def message
      puts ' AgeError :: Age must be between 10-99!'
    end
  end
end
