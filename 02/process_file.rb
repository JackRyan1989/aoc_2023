FILE = '/Users/jackryan/advent_of_code_2023/02/input.rb'.freeze
PATTERN = /(\d+)\s+(\w+)/

def process_file
  out_obj = {}
  File.foreach(FILE).with_index do |line, index|
    temp_arr = []
    line.chomp
    ind = line.index(":")
    newline = line[ind+1..]
    line_arr = newline.split(";")
    line_arr.each do |l|
      color_digit_hash = {}
      nl = l.lstrip.chomp
      color_arr = nl.split(',')
      color_arr.each do | col |
        col = col.lstrip
        matches = col.match(PATTERN)
        if matches
          color_word = matches[2]
          digit = matches[1].to_i
          color_digit_hash[color_word] = digit
        end
      end
      temp_arr.push(color_digit_hash)
    end
    out_obj[(index + 1).to_s] = temp_arr
  end
  out_obj
end
