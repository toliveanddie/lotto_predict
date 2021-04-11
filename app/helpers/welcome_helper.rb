module WelcomeHelper

  def powerball
    #get the source
    results = JSON.parse(HTTParty.get('https://data.ny.gov/resource/d6yy-54nr.json').body)

    #push the results into an array.
    winning_numbers = Array.new
    results.each do |key|
      winning_numbers.push(key['winning_numbers'].split)
    end

    #get enough draws so that all numbers are accounted for
    latest_draws = []
    100.times do |picks|
      latest_draws.push(winning_numbers[picks].take(5))
      break if latest_draws.flatten.uniq.length == 69
    end
    all_numbers = []
    all_numbers = latest_draws.flatten.uniq.sort

    #create hash with all numbers and set value to zero
    candidates = Hash.new
    all_numbers.each do |a|
      candidates[a] = 0
    end

    #set all numbers that were drawn to 1
    7.times do |draw|
      latest_draws[draw].each do |pick|
        candidates[pick] = 1
      end
    end
  
    #remove all numbers that were drawn
    candidates.delete_if {|k, v| v == 1}

    #initialize ranges
    ball_five = Hash.new
    all_numbers.pop(14).each do |b|
      candidates.each do |key, value|
        if key == b
          ball_five[key] = 0
        end
      end
    end

    ball_four = Hash.new
    all_numbers.pop(14).each do |c|
      candidates.each do |key, value|
        if key == c
          ball_four[key] = 0
        end
      end
    end

    ball_three = Hash.new
    all_numbers.pop(14).each do |d|
      candidates.each do |key, value|
        if key == d
          ball_three[key] = 0
        end
      end
    end

    ball_two = Hash.new
    all_numbers.pop(14).each do |e|
      candidates.each do |key, value|
        if key == e
          ball_two[key] = 0
        end
      end
    end

    ball_one = Hash.new
    all_numbers.each do |f|
      candidates.each do |key, value|
        if key == f
          ball_one[key] = 0
        end
      end
    end


    # get counts for each number drawn and fill in ranges
    candidates.each do |key, value|
      latest_draws.each do |draw|
        draw.each do |g|
          if key == g
            if key.to_i < 14
              ball_one[key] = ball_one[key] + 1
            elsif key.to_i < 28
              ball_two[key] = ball_two[key] + 1
            elsif key.to_i < 42
              ball_three[key] = ball_three[key] + 1
            elsif key.to_i < 55
              ball_four[key] = ball_four[key] + 1
            else
              ball_five[key] = ball_five[key] + 1
            end
          end
        end
      end
    end

    # sorting out highest counts
    positions = Array.new
    positions = [ball_one, ball_two, ball_three, ball_four, ball_five]
    positions.each do |position|
      g = position.values
      g.sort!
      position.delete_if {|k, v| v < g.last}
    end

    #get the money ball counts
    ball = []
    300.times do |picks|
    ball.push(winning_numbers[picks].last)
      break if ball.flatten.uniq.length == 26
    end
    all_balls = ball.flatten.uniq.sort

    #initialize the hash
    balls = Hash.new
    all_balls.each do |ball|
      balls[ball] = 0
    end

    ball.each do |number|
      balls[number] = balls[number] + 1
    end

    #get highest counts
    cv = balls.values
    cv.uniq!.sort!
    balls.delete_if {|k, v| v < cv.last(5).first}

    positions.push(balls)

    return positions

  end

  ###########################################
  ###########################################

  def megaball
    #get the source
    results = JSON.parse(HTTParty.get('https://data.ny.gov/resource/5xaw-6ayf.json').body)

    #push the results into an array.
    winning_numbers = Array.new
    results.each do |key|
      winning_numbers.push(key['winning_numbers'].split)
    end

    #get enough draws so that all numbers are accounted for
    latest_draws = []
    100.times do |picks|
      latest_draws.push(winning_numbers[picks])
      break if latest_draws.flatten.uniq.length == 70
    end
    all_numbers = []
    all_numbers = latest_draws.flatten.uniq.sort

    #create hash with all numbers and set value to zero
    candidates = Hash.new
    all_numbers.each do |a|
      candidates[a] = 0
    end

    #set all numbers that were drawn to 1
    7.times do |draw|
      latest_draws[draw].each do |pick|
        candidates[pick] = 1
      end
    end
  
    #remove all numbers that were drawn
    candidates.delete_if {|k, v| v == 1}

    #initialize ranges
    ball_five = Hash.new
    all_numbers.pop(14).each do |b|
      candidates.each do |key, value|
        if key == b
          ball_five[key] = 0
        end
      end
    end

    ball_four = Hash.new
    all_numbers.pop(14).each do |c|
      candidates.each do |key, value|
        if key == c
          ball_four[key] = 0
        end
      end
    end

    ball_three = Hash.new
    all_numbers.pop(14).each do |d|
      candidates.each do |key, value|
        if key == d
          ball_three[key] = 0
        end
      end
    end

    ball_two = Hash.new
    all_numbers.pop(14).each do |e|
      candidates.each do |key, value|
        if key == e
          ball_two[key] = 0
        end
      end
    end

    ball_one = Hash.new
    all_numbers.each do |f|
      candidates.each do |key, value|
        if key == f
          ball_one[key] = 0
        end
      end
    end


    # get counts for each number drawn and fill in ranges
    candidates.each do |key, value|
      latest_draws.each do |draw|
        draw.each do |g|
          if key == g
            if key.to_i < 15
              ball_one[key] = ball_one[key] + 1
            elsif key.to_i < 29
              ball_two[key] = ball_two[key] + 1
            elsif key.to_i < 43
              ball_three[key] = ball_three[key] + 1
            elsif key.to_i < 57
              ball_four[key] = ball_four[key] + 1
            else
              ball_five[key] = ball_five[key] + 1
            end
          end
        end
      end
    end

    # sorting out highest counts
    positions = Array.new
    positions = [ball_one, ball_two, ball_three, ball_four, ball_five]
    positions.each do |position|
      g = position.values
      g.sort!
      position.delete_if {|k, v| v < g.last}
    end

    #get the money ball counts

    total_ball = []
    results.each do |picks|
      total_ball.push(picks['mega_ball'])
    end

    ball = []
    100.times do |element|
      ball.push(total_ball[element])
      break if ball.flatten.uniq.length == 25
    end
    all_balls = ball.flatten.uniq

    #initialize the hash
    balls = Hash.new
    all_balls.each do |number|
      balls[number] = 0
    end

    ball.each do |number|
      balls[number] = balls[number] + 1
    end

    #get highest counts
    cv = balls.values
    cv.sort!
    balls.delete_if {|k, v| v < cv.last(5).first}

    positions.push(balls)

    return positions
  end

end
