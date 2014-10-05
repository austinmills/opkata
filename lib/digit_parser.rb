require 'digit'
require 'parse_result'

class DigitParser

  # Take the entire text and split it into an array of three-line groups
  def parse_text(text)
    lines = text.split("\n")
    lines.each_slice(3).to_a
  end

  # Take an array of three lines and change it to an array of 9 2D character arrays
  def parse_lines(lines)
    sliced_lines = lines.map { |x| x.chars.each_slice(3).to_a }

    digits = []
    (0..8).each do |i|
      digits << [ sliced_lines[0][i], sliced_lines[1][i], sliced_lines[2][i] ]
    end

    digits
  end

  # Convert a 2D character array to a number
  def parse_digit(digit)
    Digit.match(digit)
  end

  # Parse an array of three lines representing a set of numbers into a ParseResult
  def build_result(lines)
    ParseResult.new(parse_lines(lines).inject("") { |digit_string, digit| digit_string + (parse_digit(digit) || '?').to_s })
  end

  # Parse a block of text and return an array of ParseResults
  def parse(text)
    line_groups = parse_text(text)

    results = []
    line_groups.each { |x|
      results << build_result(x)
    }

    results
  end

end