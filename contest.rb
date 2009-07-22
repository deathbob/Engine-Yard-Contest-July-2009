require 'digest/sha1'

class Bob
    def initialize
        @phrase_to_match = "I would much rather hear more about your whittling project"
        @hash_to_match = Digest::SHA1.hexdigest(@phrase_to_match).to_i(16)
        @dictionary = open("dict.txt").readlines
        @current_best = 160
        @picks = ''
    end
    def compute_hamming_distance(to_test)
        temp = @hash_to_match ^ to_test
        acc = 0
        (temp.size * 8 - 1).downto(0) do |n|
            acc = acc + temp[n]
        end
        acc    
    end
    def show_binary(num)
        (num.size * 8 - 1).downto(0) do |n|
            print num[n]
        end
    end
    def fill_picks
        @picks = ''
        12.times do 
            @picks << @dictionary[rand(999)].chomp + ' '
        end
        @picks.chop!
    end
    def hash_picks
        @picks_hash = Digest::SHA1.hexdigest(@picks).to_i(16)
    end

    def cycle
        fill_picks
        hash_picks
        distance = compute_hamming_distance(@picks_hash)
        if distance < @current_best
            puts distance.to_s + " " + @picks
#            f = open("keepers.txt", 'a')
#            f << distance << " "<< @picks << "\n"
#            f.close
            @current_best = distance
        end
    end
end

bob = Bob.new
1000000.times do
    bob.cycle
end






