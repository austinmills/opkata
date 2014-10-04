require 'spec_helper'

describe 'DigitParser' do
  it 'should parse text into groups of 3 lines' do
    parser  = DigitParser.new

    text =
      "  _  _     _  _  _  _  _ "\
      "| _| _||_||_ |_   ||_||_|"\
      "||_  _|  | _||_|  ||_| _|"\
      "  _  _     _  _  _  _  _ "\
      "| _| _||_||_ |_   ||_||_|"\
      "||_  _|  | _||_|  ||_| _|"

    lines = parser.parse_text text
    expect(lines.size).to eq(2)
  end
end

