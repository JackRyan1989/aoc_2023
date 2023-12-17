TEST_INPUT = "./test_input.txt"
INPUT = "./input.txt"

def clean_strings(str)
  str.lstrip.chomp.rstrip
end

def count_matches(card)
  winning_nums = clean_strings(card[0]).scan(/\d+/)
  nums_i_have = clean_strings(card[1]).scan(/\d+/)
  num_winners = 0
  winning_nums.each do | number |
    nums_i_have.each do | num |
     if number == num
      num_winners += 1
     end
    end
  end
  num_winners
end

def process_input
  game_array = []
  File.foreach(INPUT) do | line |
    ind = line.index(":")
    line_remainder = line[ind+1..]
    game_array.push(line_remainder.split("|"))
  end
  game_array
end

total = []
process_input.each do | c |
  wins = count_matches(c)
  if wins <= 2
    total.push(wins)
  elsif
    exp = wins - 1
    value = 2**exp
    total.push(value)
  end
end

process_input
p total.sum
