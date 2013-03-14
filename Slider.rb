require "highline/system_extensions"
include HighLine::SystemExtensions

class Slider
	attr_reader :blank

	def initialize(x, y)
		@x, @y = x.to_i, y.to_i
		@board = new_board(@x, @y)
		@blank = @x*@y - 1
	end

	def new_board(x, y)
		board = Array.new(x * y)
		Array(0..x*y-2).each { |i| board[i] = i + 1 }
		board [-1] = nil
		board
	end

	def display_board
		Array(0..@y-1).each { |i| 
			Array(0..@x-1).each { |j| 
				print "#{@board[i*@x+j]} "
			}
			puts
		}

	end

	def scramble
		50.times {make_move(["l", "r", "u", "d"].sample) }
	end

	def make_move(move)
		x, y= @blank % @x, @blank / @y


		case move
		when "u"
			y -= 1
		when "d"
			y += 1
		when "r"
			x += 1
		when "l"
			x -= 1
		end

		return if ( (y < 0) || (y >= @y) || (x < 0) || (x >= @x) )

		@board[@blank], @board[y*@x + x] = @board[y*@x + x], @board[@blank]
		@blank = y*@x + x
	end

	def solved
		@board == new_board(@x, @y)
	end

end

print "Please enter a height and width for your game:"
x = gets
print ", "
y = gets
puts

board = Slider.new(x, y)
board.scramble
board.make_move("u")
system 'cls'
board.display_board
move = ""
while move.chr != "q" do
	puts "Please enter u,d,l,r for desired move:"
	move = get_character
	system 'cls'
	board.make_move(move.chr)
	board.display_board
	break if board.solved
end

puts "You win!"

puts "Thanks for playing!"