class Game
    def initialize
        #change directory if you're downloading from GitHub
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
        puts "#{@selected_word}\n#{@selected_word.length}"
    end

    def chosen_word
        @chosen_word = @selected_word.to_s.split('')
    end

    def save_game
        #change directory if you're downloading from GitHub
        @save_file = File.open(File.expand_path("/home/jerry/repos/Hangman/savegames/savefile.txt"), 'w')
        @playerguess = @player_guess.join('')
        @chosenword = @chosen_word.join('')
        @save_file.puts("#{@playerguess}\n#{@chosenword}\n#{@count}")
        @save_file.close
    end

    def game_start
        @text_file.close
        chosen_word
        @player_guess = []
        @count = 1
        for i in @chosen_word
            @player_guess.append("_")
        end
        until @count >= 20 do
            puts "The word is #{@chosen_word.length} characters long.\n"
            print "Enter your guess. You're on turn #{@count}. Enter 's' if you wish to save your progress, or 'l' to load last save. Your current guess is: #{@player_guess}.\n"
            @current_guess = gets().chomp.to_s
            if @current_guess == "s" || @current_guess == "S"
                save_game
                redo
            elsif @current_guess == 'l' || @current_guess == "L"
                puts "Preceeding to load last save"
                @temp_array = []
                #change directory if you're downloading from GitHub
                @save_file = File.open(File.expand_path("/home/jerry/repos/Hangman/savegames/savefile.txt"), 'r')
                File.readlines(@save_file).each do |line|
                    line.to_s.chomp
                    @temp_array.append(line.chomp)
                end
                @player_guess = @temp_array[0].split('')
                @chosen_word = @temp_array[1].split('')
                @count = @temp_array[2]
                @save_file.close
                redo
            elsif @current_guess.split('').length != @chosen_word.length
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
                puts "You win! The word was #{@chosen_word.join('')}!"
                @count = 999
            end
            @count += 1
        end
    end
end

new_game = Game.new()
new_game.game_start


