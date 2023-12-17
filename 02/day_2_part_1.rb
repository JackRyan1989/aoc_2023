require './process_file.rb'

MAX_RED = 12
MAX_BLUE = 14
MAX_GREEN = 13

# load data
def load_data
  data = process_file
  data
end

# loop through object:
def get_vals(data = load_data)
  out_arr = []
  load_data.each do |k,v|
    destructure_sub_arr(k, v, out_arr)
  end
  dummy_arr = []
  100.times do |item| dummy_arr.push(item + 1) end
  dummy_arr.difference(out_arr.uniq).sum
end

def exceed_green?(item)
  return true if !item["green"].nil? && item["green"] > MAX_GREEN
end

def exceed_blue?(item)
  return true if !item["blue"].nil? && item["blue"] > MAX_BLUE
end

def exceed_red?(item)
  return true if !item["red"].nil? && item["red"] > MAX_RED
end

def destructure_sub_arr(kee, arr, output)
  arr.each do |item|
    early_return = false
    if exceed_green?(item) || exceed_blue?(item) || exceed_red?(item)
      early_return = true
      output.push(kee.to_i)
    end
    break if early_return
  end
end

p get_vals(load_data)

