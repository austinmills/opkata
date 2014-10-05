class Digit

#    _  _     _  _  _  _  _  _
#  | _| _||_||_ |_   ||_||_|| |
#  ||_  _|  | _||_|  ||_| _||_|

  ONE = [[' ',' ',' '],
         [' ',' ','|'],
         [' ',' ','|']]

  TWO = [[' ','_',' '],
         [' ','_','|'],
         ['|','_',' ']]

  THREE = [[' ','_',' '],
           [' ','_','|'],
           [' ','_','|']]

  FOUR = [[' ',' ',' '],
          ['|','_','|'],
          [' ',' ','|']]

  FIVE = [[' ','_',' '],
           ['|','_',' '],
           [' ','_','|']]

  SIX = [[' ','_',' '],
         ['|','_',' '],
         ['|','_','|']]

  SEVEN = [[' ','_',' '],
           [' ',' ','|'],
           [' ',' ','|']]

  EIGHT = [[' ','_',' '],
           ['|','_','|'],
           ['|','_','|']]

  NINE = [[' ','_',' '],
          ['|','_','|'],
          [' ','_','|']]

  ZERO = [[' ','_',' '],
          ['|',' ','|'],
          ['|','_','|']]

  DIGITS_TO_NUMBERS = {
      ZERO => 0,
      ONE => 1,
      TWO => 2,
      THREE => 3,
      FOUR => 4,
      FIVE => 5,
      SIX => 6,
      SEVEN => 7,
      EIGHT => 8,
      NINE => 9
  }

  def self.match(digit)
    DIGITS_TO_NUMBERS[digit]
  end
end