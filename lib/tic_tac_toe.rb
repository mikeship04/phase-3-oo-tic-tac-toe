require 'pry'
class TicTacToe
    attr_accessor :board

    def initialize
        @board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
    end

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [6, 4, 2],
        [0, 4, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8]
    ]

    def display_board
        @board.each_slice(3) {|a, b, c| puts " #{a} | #{b} | #{c} -----------"  } 
    end

    def input_to_index(string)
        string.to_i-1
    end

    def move(index, token = 'X')
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
    # index.between?(0, 8) && !position_taken?(index)
        @board[index] == ' ' && index < 9 && index >= 0
    end

    def turn_count
        # @board.count {|pos| pos != " "}
       9 - @board.count(' ')
    end

    def current_player
        # turn_count.even? ? 'X' : 'O'
        if turn_count % 2 == 0 
            'X'
        else 
            'O'
        end
    end

    def turn
        puts "Enter your move [1-9]:"
        move_index = input_to_index(gets.strip)
            if valid_move?(move_index)
                move(move_index, current_player)
                display_board
            else 
                turn
            end
        # pmove = gets.chomp
        # index = self.input_to_index(pmove)
        # if self.valid_move?(index)
        #     self.current_player
        #     self.move(index)
        #     self.display_board
        # else
        #   self.turn
        # end
    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[0]]== @board[combo[2]]
                return combo
            end
        end
    end

    def full?
        @board.all? {|pos| pos != " " }
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
       if combo = won?
        @board[combo[0]]
       end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
        # while !over
        #     turn
        # end
    end

end