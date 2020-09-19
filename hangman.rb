class Hangman
    def initialize
        infile = File.readlines("words.txt")
        wordarray = infile.map { |item| item.strip }
        @word = wordarray.sample
        @underscores = ""
        for i in 0..@word.size-1
            @underscores += "_ "
        end
        @livesleft = 7
        @incorrectused = ""
    end

    def ascii(livesleft)
        if livesleft == 6
            print("=========\n  +---+\n  |   |\n      |\n      |\n      |\n      |\n=========\n\n")
        end
        if livesleft == 5
            print("=========\n  +---+\n  |   |\n  O   |\n      |\n      |\n      |\n=========\n\n")
        end
        if livesleft == 4
            print("=========\n  +---+\n  |   |\n  O   |\n  |   |\n      |\n      |\n=========\n\n")
        end
        if livesleft == 3
            print("=========\n  +---+\n  |   |\n  O   |\n /|   |\n      |\n      |\n=========\n\n")
        end
        if livesleft == 2
            print("=========\n  +---+\n  |   |\n  O   |\n /|\\  |\n      |\n      |\n=========\n\n")
        end
        if livesleft == 1
            print("=========\n  +---+\n  |   |\n  O   |\n /|\\  |\n /    |\n      |\n=========\n\n")
        end
        if livesleft == 0
            print("=========\n  +---+\n  |   |\n  O   |\n /|\\  |\n / \\  |\n      |\n=========\n\n")
        end
    end

    def updateunderscores(guess)
        newunderscores = @underscores.split
        letterindex = (0...@word.length).find_all { |i| @word[i,1] == guess }
        for i in 0..letterindex.size-1
            newunderscores[letterindex[i]] = guess
        end
        @underscores = newunderscores.join(" ")
        puts @underscores
    end

    def settings(playagain)
        if playagain == 'y'
            print("\n")
            initialize
            startgame
        else
            exit(0)
        end
    end

    def inputletter
        if @livesleft > 0
            puts "Enter a letter:"
            guess = gets.chomp
            if guess.length > 1
                puts "Input one letter only!"
                inputletter
            end
            correct = @word.include? guess
            if @underscores.include? guess
                puts "Letter already guessed!"
                print("\n")
                inputletter
            elsif correct
                puts "You guessed a correct letter!"
                print("\n")
                updateunderscores(guess)
                if @underscores.split.join == @word
                    puts "You win!"
                    print("\n")
                    puts "Play again? (y/n)"
                    playagain = gets.chomp
                    settings(playagain)
                else
                    inputletter
                end
            else
                if @incorrectused.include? guess
                    puts "Letter already guessed!"
                    print("\n")
                    inputletter
                else
                    @livesleft -= 1
                    @incorrectused = @incorrectused + guess
                    puts "Incorrect. You have #{@livesleft} lives left."
                    ascii(@livesleft)
                    puts @underscores
                    inputletter
                end
            end
        else
          puts "Out of lives! You lose!"
          puts "Correct word was: #{@word}"
          print("\n")
          puts "Play again? (y/n)"
          playagain = gets.chomp
          settings(playagain)
        end
    end

    def startgame
        puts "Welcome to Hangman!"
        puts "Your word is #{@word.size} letters long."
        puts "You have #{@livesleft} lives."
        puts @underscores
        inputletter
    end
end

game = Hangman.new
game.startgame