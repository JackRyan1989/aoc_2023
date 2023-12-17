# treat like a 2 dimensional array
# loop through each row, and grab numbers positioned between a starting . and ending .
# note the row number and index values - x and y
# for any number, you want to get the y (row) number and the x value(s)
# From there, you can get the x/y values to check for a symbol other than .
# If a symbol exists at any of these values, put that number into an array

DIGIT_PATTERN = /\d/
PERIOD = /\./

def load_data
  data_arr = []
  File.foreach('input.txt') do |line|
    line = line.chomp.split('')
    data_arr.append(line)
  end
  data_arr
end

# should return a hash where the number is a key (symbol) and the value is an array of the x,y coordinates for
# each position of each integer in that number:
# { :123 => [[x,y], [x,y], [x,y]]}
def get_numbers_and_symbols
  input = load_data
  number_location_hash = {}
  symbol_location_hash = {}
  x_y_array = []
  current_number = ""
  # outer loop will get the y values
  # inner loop will get the x values
  input.each_with_index do |line, index|
    line.each_with_index do |val, ind|
      # check for numbers first
      if digit_match?(val) && !period_match?(line[ind + 1]) && !next_nil?(line[ind + 1]) && !symbol_match?(line[ind + 1])
        # construct multidigit number
        current_number << val
        x_y_array << [ind, index]
      elsif (digit_match?(val) && period_match?(line[ind + 1])) ||
          (digit_match?(val) && symbol_match?(line[ind + 1]))
        current_number << val
        x_y_array << [ind, index]
        number_location_hash["#{current_number}_#{ind}"] = x_y_array
        current_number = ""
        x_y_array = []
      elsif symbol_match?(val)
        symbol_location_hash["#{val}#{(ind+index)*rand}"] = [ind, index]
      end
    end
  end
  [ number_location_hash, symbol_location_hash ]
end

def symbol_match?(value)
  !digit_match?(value) && !period_match?(value)
end

def period_match?(value)
  PERIOD.match?(value)
end

def digit_match?(value)
  DIGIT_PATTERN.match?(value)
end

def next_nil?(value)
  value.nil?
end

def check_x?(x1, x2)
  x1 = 0 if x1.nil?
  x2 = 0 if x2.nil?
  diff = x1 - x2
  if diff == 0 || diff == 1 || diff == -1
    return true
  end
  false
end

def check_y?(y1, y2)
  y1 = 0 if y1.nil?
  y2 = 0 if y2.nil?
  diff = y1 - y2
  if diff == 0 || diff == 1 || diff == -1
    return true
  end
  false
end

def extract_numbers_near_symbols
  nums_and_syms = get_numbers_and_symbols
  number_hash = nums_and_syms[0]
  symbol_hash = nums_and_syms[1]
  output = []
  number_hash.each do |k,v|
    break_early = false
    v.each do |coord|
      break if break_early
      symbol_hash.each do |key,var|
        #append k to output if coord is within range of symbol
        if check_x?(var[0], coord[0]) && check_y?(var[1], coord[1])
          output.push(k.gsub(/_\d*/, "").to_i)
          break_early = true
        end
      end
    end
  end
  p output.sum
  output
end

extract_numbers_near_symbols
# Expected numbers
# expected = [953, 919, 958, 758, 905, 50, 971, 762, 915, 533, 502, 24, 262, 531, 698, 234, 149, 834, 994, 266, 941, 434, 812, 211, 133, 613, 85, 871, 497, 346, 88,192, 128, 163, 656, 461, 971, 931, 606, 506, 30, 211, 26]
# p expected.sum
# p expected.difference(out)
