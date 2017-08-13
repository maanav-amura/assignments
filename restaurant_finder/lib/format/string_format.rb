# Extending class String to format
class String
  def mid
    center(60)
  end

  def header
    upcase.center(60)
  end

  def wordcase
    split(' ').map(&:capitalize).join(' ')
  end
end
