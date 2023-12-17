def load_data
  data_arr = []
  File.foreach('data.rb') do |line|
    line = line.chomp
    data_arr.append(line)
  end
  data_arr
end

# determine the number of integers in each line
# To do: create a hash mapping of number words and integers

def number_hash
  return {
    "one" => 1,
    "two" => 2,
    "three" => 3,
    "four" => 4,
    "five" => 5,
    "six" => 6,
    "seven" => 7,
    "eight" => 8,
    "nine" => 9,
  }
end

# method for original part 1 solution
def num_ints(arr)
  total_arr = []
  pattern = /\D/
  arr.each do |item|
    val = item.gsub(pattern, '')
    if val.to_s.length == 1
      val = "#{val}#{val}"
    else
      val = "#{val.to_s.chars.first}#{val.to_s.chars.last}"
    end
    total_arr.append(val.to_i)
  end
  puts total_arr.sum
end

# part two solution
# called within a loop:
def remove_ints(line, word_hash)
  word_hash.each do |k,v|
    line.gsub!(v.to_s, k)
  end
  line
end

def segment_number_words(line, hash = number_hash)
  word = ""
  words = []
  line = remove_ints(line, hash)
  # we want to grab the first int, and then the last int
  line.chars.each do |char|
    first_word_found = false
    word << char
    hash.each do |k|
      if word.include?(k[0])
        words.append(k[0])
        word = ""
        first_word_found = true
      end
    end
    break if first_word_found
  end
  line.chars.reverse_each do |char|
    last_word_found = false
    word << char
    hash.each do |k|
      if word.include?(k[0].reverse)
        words.append(k[0])
        word = ""
        last_word_found = true
        break
      end
    end
    break if last_word_found
  end
  words
end

def get_wordints_array(data)
  word_arr = []
  data.each do |word|
    word_arr.append(segment_number_words(word, number_hash))
  end
  word_arr
end

def convert_to_ints(arr)
  arr.map do |sub_arr|
    [number_hash[sub_arr.first], number_hash[sub_arr.last]].join().to_i
  end
end

TEST_DATA = [
  "zfxbzhczcx9eightwockk",
  "seven3oneightp",
]

output = convert_to_ints(get_wordints_array(load_data))
puts output.sum
