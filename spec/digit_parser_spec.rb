require 'spec_helper'

describe 'DigitParser' do
  it 'should parse text into groups of 3 lines' do
    parser  = DigitParser.new

    text =
      "    _  _     _  _  _  _  _ \n"\
      "  | _| _||_||_ |_   ||_||_|\n"\
      "  ||_  _|  | _||_|  ||_| _|\n"\
      "       _     _  _  _  _  _ \n"\
      "  |  | _||_||_ |_   ||_||_|\n"\
      "  |  | _|  | _||_|  ||_| _|\n"

    lines = parser.parse_text text

    expect(lines.size).to eq(2)
    expect(lines[0]).to eq(
      ["    _  _     _  _  _  _  _ ",
      "  | _| _||_||_ |_   ||_||_|",
      "  ||_  _|  | _||_|  ||_| _|"])
    expect(lines[1]).to eq(
      ["       _     _  _  _  _  _ ",
       "  |  | _||_||_ |_   ||_||_|",
       "  |  | _|  | _||_|  ||_| _|"])
  end

  it 'should parse a group of 3 lines into 9 digits' do
    parser  = DigitParser.new

    lines = ["    _  _     _  _  _  _  _ ",
             "  | _| _||_||_ |_   ||_||_|",
             "  ||_  _|  | _||_|  ||_| _|"]

    digits = parser.parse_lines lines

    expect(digits.size).to eq(9)
    expect(digits[0]).to eq(
      [[' ',' ',' '],
       [' ',' ','|'],
       [' ',' ','|']])
    expect(digits[1]).to eq(
      [[' ','_',' '],
       [' ','_','|'],
       ['|','_',' ']])
  end

  it 'should parse a digit into a number' do
    parser  = DigitParser.new
    one_digit =
      [[' ',' ',' '],
       [' ',' ','|'],
       [' ',' ','|']]
    two_digit =
      [[' ','_',' '],
       [' ','_','|'],
       ['|','_',' ']]

    expect(parser.parse_digit(one_digit)).to eq(1)
    expect(parser.parse_digit(two_digit)).to eq(2)

  end

  it 'should output invalid characters as ?s' do
    parser  = DigitParser.new
    lines = ["    _  _     _  _  _  _  _ ",
             "  ||_| _||_||_ |_   ||_||_|",
             "  ||_ |_|  | _||_|| ||_| _|"]

    result = parser.build_result(lines)

    expect(result.digits).to eq('1??456?89')
  end

  it 'should find one valid permutation of a 1' do
    parser = DigitParser.new
    one_digit =
        [[' ',' ',' '],
         [' ',' ','|'],
         [' ',' ','|']]

    permutations = parser.permute_digit(one_digit)

    expect(permutations).to eq([7])
  end

  it 'should find two valid permutations of an 8' do
    parser = DigitParser.new
    eight_digit =
        [[' ','_',' '],
        ['|','_','|'],
        ['|','_','|']]

    permutations = parser.permute_digit(eight_digit)

    expect(permutations).to eq([0,6,9])

  end

  it 'should find the correct valid permutations for an illegible character' do
    parser = DigitParser.new
    invalid_digit =
        [[' ',' ',' '],
        ['|',' ','|'],
        ['|','_','|']]

    permutations = parser.permute_digit(invalid_digit)

    expect(permutations).to eq([0])
  end

  it 'should find an alternate valid value for an illegible ParseResult' do
    parser  = DigitParser.new
    result = ParseResult.new('0?0000051')

    lines =
      [" _     _  _  _  _  _  _    ",
       "| || || || || || || ||_   |",
       "|_||_||_||_||_||_||_| _|  |"]

    digit_array = parser.parse_lines(lines)


    expect(result.checksum_valid).to eq(false)

    result_with_alts = parser.find_alternate_values(result, digit_array)
    expect(result_with_alts.alternatives).to eq(['000000051'])
  end

  it 'should find an alternate valid value for a bad ParseResult' do
    parser  = DigitParser.new
    result = ParseResult.new('555555555')

    lines =
      [" _  _  _  _  _  _  _  _  _ ",
       "|_ |_ |_ |_ |_ |_ |_ |_ |_ ",
       " _| _| _| _| _| _| _| _| _|"]

    digit_array = parser.parse_lines(lines)

    expect(result.checksum_valid).to eq(false)

    result_with_alts = parser.find_alternate_values(result, digit_array)
    expect(result_with_alts.alternatives).to eq(['559555555','555655555'])

  end

end

