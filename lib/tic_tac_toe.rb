WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,4,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  index = user_input.to_i - 1
  index
end

def move(board, index, token)
  board[index] = token
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board,index)
    true
  else
    false
  end
end

def turn(board)
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index) == true
    move(board, index, token = "X")
  else
    user_input = gets.strip
    index
  end
end

def turn_count(board)
  count = 0
  board.each {|char| count += 1 if char == "X" || char == "O"}
  count
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    slot_1 = board[index_0]
    slot_2 = board[index_1]
    slot_3 = board[index_2]

    if slot_1 == "X" && slot_2 == "X" && slot_3 == "X"
      return win_combo
    elsif slot_1 == "O" && slot_2 == "O" && slot_3 == "O"
      return win_combo
    end
  end
  false
end

def full?(board)
  board.all? { |index| if index == "X" || index == "O"
      true
    end
  }
end

def draw?(board)
  if !won?(board) && full?(board)
    true
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  end
end

def winner(board)
  index = won?(board)
  if index == false
    nil
  elsif board[index[0]] == "X"
     return "X"
  elsif board[index[0]] == "O"
    return "O"
  end
end

def play(board)
   until over?(board)
      turn(board)
    end
   if won?(board)
      winner(board) == "X" || winner(board) == "O"
      puts "Congratulations #{winner(board)}!"
   elsif draw?(board)
      puts "Cat's Game!"
   end
end
