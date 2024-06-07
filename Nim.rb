def main ()
    puts "spelet går ut på att plocka upp pinnar från olika högar. Den som plockar upp den sista pinnen vinner.\nLycka till!"
    sleep 2

    while true
        puts "Vill du spela PvE eller PvP? (pvp/pve)"
        game_mode = gets.chomp.downcase

        if game_mode == "pvp"
            puts "Skriv in namnet på spelare 1."
            player1 = gets.chomp

            puts "Skriv in namnet på spelare 2."
            player2 = gets.chomp

            system("cls")
            break
        elsif game_mode == "pve"
            puts "Skriv ditt namn"
            player1 = gets.chomp

            puts "Vilken svårighetsgrad vill du spela på. (Rookie/Veteran)"

            while true
                diff = gets.chomp.downcase

                if diff == "rookie"
                    player2 = "Bob the robot"
                    break

                elsif diff == "veteran"
                    player2 = "Rob the bobot"
                    break

                end
                puts "Fel input, försök igen. (Rookie/Veteran)"
            end

            system("cls")
            break
        end
        puts "Fel input, försök igen. (pve/pvp)"
    end

    stacks = [rand(5..7), rand(4..6), rand(3..5)]

    turn = rand(1..2)

    while stacks[0] > 0 || stacks[1] > 0 || stacks[2] > 0
        puts "Det är #{stacks[0]} pinnar kvar i hög 1\ndet är #{stacks[1]} pinnar kvar i hög 2\ndet är #{stacks[2]} pinnar kvar i hög 3"

        if turn % 2 == 0
            puts "Det är #{player2}s tur"
        else
            puts "Det är #{player1}s tur"
        end

        if game_mode == "pve" && turn % 2 == 0

            if diff == "rookie"
                sleep 2
                bobs_choice = [rand(0..2), rand(1..3)]

                while stacks[bobs_choice[0]] <= 0
                    bobs_choice[0] = rand(0..2)
                end

                while stacks[bobs_choice[0]] < bobs_choice[1]
                    bobs_choice[1] = rand(1..3)
                end

                puts "Bob valde hög nummer #{bobs_choice[0] + 1}"
                sleep 2
                stacks[bobs_choice[0]] -= bobs_choice[1]

                if bobs_choice[1] == 1
                    puts "Bob tog #{bobs_choice[1]} pinne"
                else
                    puts "Bob tog #{bobs_choice[1]} pinnar"
                end

                sleep 2
            elsif diff == "veteran"
                sleep 2
                rob_stack = stacks.clone
                robs_choice = makeMove(rob_stack, 3)

                puts "Rob valde hög nummer #{robs_choice[0] + 1}"
                sleep 2
                stacks[robs_choice[0]] -= robs_choice[1]

                if robs_choice[1] == 1
                    puts "Rob tog #{robs_choice[1]} pinne"
                else
                    puts "Rob tog #{robs_choice[1]} pinnar"
                end

                sleep 2
            end

        else
            while true
                puts "Vilken hög vill du plocka ifrån?"
                stack_choice = gets.chomp.to_i

                if validering (stack_choice)

                    puts "Hur mång pinnar vill du plocka upp? (1-3)"
                    stick_choice = gets.chomp.to_i

                    if validering (stick_choice)

                        if stick_choice <= stacks[stack_choice-1]
                            stacks[stack_choice-1] -= stick_choice
                            break
                        end
                        puts "Du kan tyvär inte ta fler pinnar än vad det finns i högen"
                    end
                end
                puts "Fel input, försök igen. (1-3)"
            end
        end
        turn += 1
        system("cls")
    end

    if turn % 2 == 0
        puts "#{player1} tog upp den sista pinnen och vann! Tjhoho!"
    else
        puts "#{player2} tog upp den sista pinnen och vann! Tjhoho!"
    end

    puts "Vill du köra igen? (Ja)"

    if gets.chomp.downcase == "ja"
        return main
    end
end

def validering (input)
    if input >= 1 && input <= 3
        return true
    end
    return false
end

def calculateNimSum(piles, n)
    nimsum = piles[0]
    i = 1
    while i < n
        nimsum = nimsum ^ piles[i]
        i += 1
    end
    return nimsum
end

def makeMove(piles, n)
    i = 0
    sticks_removed = 0
    pile_index = 0
    nim_sum = calculateNimSum(piles, 3)
 
    if nim_sum != 0
        while i < n
 
            if ((piles[i] ^ nim_sum) < piles[i])
 
                pile_index = i
                sticks_removed = piles[i]-(piles[i] ^ nim_sum)
                piles[i] = (piles[i] ^ nim_sum)
                break if sticks_removed <= 3 && sticks_removed > 0
            end
            i += 1
            sticks_removed = 1
        end
    else
        sticks_removed = 1
    end
    optimal_return = [pile_index, sticks_removed]
    return optimal_return
end

main