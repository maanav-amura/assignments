# Error module for Numeric Data
module Error
  # Age Error class
  class AgeError < StandardError
    def message
      puts ' AgeError :: Age must be between 10-99!'
    end
  end
  # Distance Error class
  class DistanceError < StandardError
    def message
      puts ' DistanceError :: Distance must be between 10-99!'
    end
  end
  # Rating Error class
  class RatingError < StandardError
    def message
      puts ' RatingError :: Rating must be between 1 - 5!'
    end
  end
  # File Not Found Error class
  class FileNotFoundError < StandardError
    def message
      puts ' FileNotFoundError :: File is not found!'
    end
  end
end
