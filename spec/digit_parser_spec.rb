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

end

