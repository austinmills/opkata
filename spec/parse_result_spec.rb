require 'spec_helper'

class ParseResultSpec
  describe "Result" do

    it 'should correctly identify valid checksums' do
      result = ParseResult.new("457508000")
      expect(result.all_chars_valid).to eq(true)
      expect(result.checksum_valid).to eq(true)
    end

    it 'should correctly identify invalid checksums' do
      result = ParseResult.new("664371495")
      expect(result.all_chars_valid).to eq(true)
      expect(result.checksum_valid).to eq(false)
    end

    it 'should correctly identify results with invalid characters' do
      result = ParseResult.new("86110??36")
      expect(result.all_chars_valid).to eq(false)
      expect(result.checksum_valid).to eq(false)
    end

  end
end