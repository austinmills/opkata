class ParseResult

  attr_reader :digits, :all_chars_valid, :checksum_valid

  def initialize(digits)
    @digits = digits
    @all_chars_valid = digits.size == 9 && digits.count('?') == 0
    @checksum_valid = @all_chars_valid && checksum?(digits)

  end

  # account number:   3  4  5  8  8  2  8  6  5
  # position names:  d9 d8 d7 d6 d5 d4 d3 d2 d1
  # checksum calculation:
  # ((1*d1) + (2*d2) + (3*d3) + ... + (9*d9)) mod 11 == 0
  def checksum?(digits)
    sum = digits.chars.each_with_index.inject(0) { |sum, (value, index)| sum + value.to_i * (9-index) }
    sum % 11 == 0
  end

  def to_s
    if @checksum_valid
      @digits
    else
      @digits + (@all_chars_valid? " ERR" : " ILL")
    end
  end

end