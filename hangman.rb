class Game
    def initialize
        @text_file = File.open(File.expand_path("/home/jerry/repos/Hangman/google-10000-english-no-swears.txt"))
        @available_words = []
        File.readlines(@text_file).each do |line|
            line.to_s
            #puts "#{line} #{line.length}"
            if line.chomp.length >= 5 && line.chomp.length <= 12
                @available_words.append(line.chomp)
            end
        end
        @selected_word = @available_words.sample
    end

    def selected_word
        puts "#{@selected_word}, #{@selected_word.length}"
    end

    def chosen_word
        @chosen_word = @selected_word.to_s.split('')
    end

    def game_start
        chosen_word
        @player_guess = []
        @count = 0
        for i in @chosen_word
            @player_guess.append("_")
        end
        until @count >= 10 do
            puts "The word is #{@chosen_word.length} characters long.\n"
            print "Please enter your guess. You are on turn #{@count+1}. Your current guess is: #{@player_guess}.\n"
            @current_guess = gets().chomp.to_s
            if @current_guess.split('').length != @chosen_word.length
                puts "You did not enter the right length, try again."
                redo
            end
            @current_guess = @current_guess.split('')
            for i in (0...(@chosen_word.length))
                if @chosen_word[i] == @current_guess[i]
                    @player_guess[i] = @chosen_word[i]
                end
            end
            if @current_guess == @chosen_word
                puts "You win! The word was #{@selected_word}!"
                @count = 10
            end
            @count += 1
        end
    end
end

new_game = Game.new()
new_game.game_start


