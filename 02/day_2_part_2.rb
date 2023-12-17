# try to find the maximum number of each color in a game.
# then multiply those numbers - the maxes in each game
# then add all the multiplications together
require '/Users/jackryan/advent_of_code_2023/02/process_file.rb'

def load_data
  data = process_file
  # data =
  # {"1"=>[{"green"=>10, "blue"=>9, "red"=>1}, {"red"=>1, "green"=>7}, {"green"=>11, "blue"=>6}, {"blue"=>8, "green"=>12}],
  # "2"=>[{"red"=>11, "green"=>7, "blue"=>3}, {"blue"=>1, "green"=>8, "red"=>5}, {"red"=>2, "green"=>12, "blue"=>1}, {"green"=>10, "blue"=>5, "red"=>7}],
  # "3"=>[{"red"=>2, "green"=>7, "blue"=>1}, {"blue"=>1, "red"=>8}, {"green"=>7, "red"=>19, "blue"=>5}, {"blue"=>1, "green"=>10, "red"=>18}, {"red"=>10, "blue"=>6, "green"=>4}]}
end

def flatten_data(d = load_data)
  flat_arr = []
  d.each do |i|
    i.delete_at(0)
    i.flatten!
    flat_arr.push(i)
  end
  flat_arr
end

def find_maxes(r, output_array = [] )
  max_red = 0
  max_blue = 0
  max_green = 0
  products = 0
  r.each do |ar|
    ar.each do |k,v|
      if k == "blue" && v > max_blue
        max_blue = v
      end
      if k == "red" && v > max_red
        max_red = v
      end
      if k == "green" && v > max_green
        max_green = v
      end
    end
  end
  products = mult_maxes(max_blue, max_green, max_red)
  output_array.push(products)
end

def mult_maxes(a,b,c)
  return a * b * c
end

def add_mults(input_arr)
  return input_arr.sum
end

def loop_data
  d = flatten_data(load_data)
  temp = []
  d.each do |row|
    find_maxes(row, temp)
  end
  output = add_mults(temp)
  output
end

p loop_data
