require 'digit'

class DigitParser

  def parse_text(text)
    lines = text.split("\n")
    lines.each_slice(3).to_a
  end

  def parse_lines(lines)
    sliced_lines = lines.map { |x| x.chars.each_slice(3).to_a }

    digits = []
    (0..8).each do |i|
      digits << [ sliced_lines[0][i], sliced_lines[1][i], sliced_lines[2][i] ]
    end
    digits
  end

  def parse_digit(digit)
    Digit.match(digit)
  end

end