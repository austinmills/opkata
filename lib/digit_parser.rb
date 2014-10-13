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

  def permute_digit(digit)
    permutations = []

    for x in 0..2
      for y in 0..2
        original_char = digit[x][y]

        if(original_char == ' ')
          digit[x][y] = '_'

          match = Digit.match(digit)
          permutations << match if match

          digit[x][y] = '|'

          match = Digit.match(digit)
          permutations << match if match

          digit[x][y] = original_char
        else
          digit[x][y] = ' '

          match = Digit.match(digit)
          permutations << match if match

          digit[x][y] = original_char
        end

      end

    end

    permutations
  end

  # Take in a parse result that mapped to a bad number and try to find one or more alternatives
  def find_alternate_values(parse_result, digit_array)
    alternatives = []

    digit_array.each_with_index do |digit, index|
      valid_permutations = permute_digit(digit)
      valid_permutations.each do |alt_digit|
        digit_string = parse_result.digits.clone
        digit_string[index] = alt_digit.to_s
        alternatives << digit_string if ParseResult.new(digit_string).checksum_valid
      end
    end

    parse_result.alternatives = alternatives

    return parse_result
  end

  # Parse an array of three lines representing a set of numbers into a ParseResult
  def build_result(lines)
    digit_array = parse_lines(lines)
    parsed_number = ParseResult.new(digit_array.inject("") { |digit_string, digit| digit_string + (parse_digit(digit) || '?').to_s })
    if(!parsed_number.checksum_valid)
      find_alternate_values(parsed_number, digit_array)
    else
      parsed_number
    end
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