module WelcomeHelper

  def powerball
    # get the source
    doc = Nokogiri::HTML(URI.open('https://www.lotteryusa.com/powerball/year'))
    results = []
    doc.css('li').each do |data|
      d = data.content.strip
      if d.to_i != 0
        results.push(d)
      end
    end
    latest_draws = Array.new # holds latest draws
    draws = Array.new #holds all draww
    splits = [9,17,17,17,9]
    ball_one = Hash.new
    ball_two = Hash.new
    ball_three = Hash.new
    ball_four = Hash.new
    ball_five = Hash.new
    positions = Array.new
    
    positions = Array.new
    positions = [ball_one, ball_two, ball_three, ball_four, ball_five]

    #push numbers into array and only get enough so that all numbers are accounted for
    100.times do
      draws.push(results.shift(5))
      results.shift(1)
      count = draws.length
      break if draws.flatten.uniq.length >= 69
    end
  
    c=1
    5.times do |i|
      splits[i].times do
        positions[i][c.to_s] = 0
        c+=1
      end
    end

    draws.each do |draw|
      draw.each do |pick|
        positions.each do |ball|
          ball.each do |key,value|
            if key == pick
              ball[pick] = ball[pick] + 1
            end
          end
        end
      end
    end    

    latest_draws = draws.shift(7)
    latest_draws.flatten!.uniq!.sort!

    latest_draws.each do |pick|
      positions.each do |ball|
        ball.delete_if {|k,v| k == pick}
      end
    end

    # sorting out highest counts
    positions.each do |position|
      g = position.values
      g.sort!
      position.delete_if {|k, v| v < g.last}
    end

    #get the money ball counts

    total_ball = []
    doc.css('span').each do |span|
      s = span.content.strip
      if s.to_i != 0
        total_ball.push(s)
      end
    end

    ball = []
    count.times do |element|
      ball.push(total_ball[element])
      #break if ball.flatten.uniq.length >= 26
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
    balls.delete_if {|k, v| v < cv.last(8).first}

    positions.push(balls)

    return positions

  end

  ###########################################
  ###########################################

  def megaball
    # get the source
    doc = Nokogiri::HTML(URI.open('https://www.lotteryusa.com/mega-millions/year'))
    results = []
    doc.css('li').each do |data|
      d = data.content.strip
      if d.to_i != 0
        results.push(d)
      end
    end
    latest_draws = Array.new # holds latest draws
    draws = Array.new #holds all draww
    splits = [9,17,18,17,9]
    ball_one = Hash.new
    ball_two = Hash.new
    ball_three = Hash.new
    ball_four = Hash.new
    ball_five = Hash.new
    positions = Array.new
    
    positions = Array.new
    positions = [ball_one, ball_two, ball_three, ball_four, ball_five]

    #push numbers into array and only get enough so that all numbers are accounted for
    100.times do
      draws.push(results.shift(5))
      results.shift(1)
      count = draws.length
      break if draws.flatten.uniq.length >= 70
    end
  
    c=1
    5.times do |i|
      splits[i].times do
        positions[i][c.to_s] = 0
        c+=1
      end
    end

    draws.each do |draw|
      draw.each do |pick|
        positions.each do |ball|
          ball.each do |key,value|
            if key == pick
              ball[pick] = ball[pick] + 1
            end
          end
        end
      end
    end

    latest_draws = draws.shift(7)
    latest_draws.flatten!.uniq!.sort!

    latest_draws.each do |pick|
      positions.each do |ball|
        ball.delete_if {|k,v| k == pick}
      end
    end

    # sorting out highest counts
    positions.each do |position|
      g = position.values
      g.sort!
      position.delete_if {|k, v| v < g.last}
    end

    #get the money ball counts

    total_ball = []
    doc.css('span').each do |span|
      s = span.content
      if s.to_i != 0
        total_ball.push(s)
      end
    end

    ball = []
    count.times do |element|
      ball.push(total_ball[element])
      #break if ball.flatten.uniq.length >= 25
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
    balls.delete_if {|k, v| v < cv.last(8).first}

    positions.push(balls)

    return positions
  end

  ###############################################
  ###############################################

  def match6

    # get the source
    doc = Nokogiri::HTML(URI.open('https://www.lotteryusa.com/pennsylvania/match-6/year'))
    results = []
    doc.css('li').each do |data|
      d = data.content.strip
      if d.to_i != 0
        results.push(d)
      end
    end

    latest_draws = Array.new #holds strings of numbers

    #push numbers into array and only get enough so that all numbers are accounted for
    100.times do
      latest_draws.push(results.shift(6))
      break if latest_draws.flatten.uniq.length >= 49
    end
  
    #put all 49 numbers into an array as strings
    all_numbers = Array.new
    49.times do |t|
      all_numbers.push((t+1).to_s)
    end

    #create hash with all numbers and set value to zero
    candidates = Hash.new
    all_numbers.each do |a|
      candidates[a] = 0
    end

    #set all numbers that were drawn to 1
    4.times do |draw|
      latest_draws[draw].each do |pick|
        candidates[pick] = 1
      end
    end
    
    #remove all numbers that were drawn
    candidates.delete_if {|k, v| v == 1}
    
    #initialize ranges
    ball_six = Hash.new
    all_numbers.pop(5).each do |h|
      candidates.each do |key, value|
        if key == h
          ball_six[key] = 0
        end
      end
    end

    ball_five = Hash.new
    all_numbers.pop(9).each do |b|
      candidates.each do |key, value|
        if key == b
          ball_five[key] = 0
        end
      end
    end

    ball_four = Hash.new
    all_numbers.pop(10).each do |c|
      candidates.each do |key, value|
        if key == c
          ball_four[key] = 0
        end
      end
    end

    ball_three = Hash.new
    all_numbers.pop(10).each do |d|
      candidates.each do |key, value|
        if key == d
          ball_three[key] = 0
        end
      end
    end

    ball_two = Hash.new
    all_numbers.pop(10).each do |e|
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
        draw.each do |j|
          if key == j
            if key.to_i < 6
              ball_one[key] = ball_one[key] + 1
            elsif key.to_i < 16
              ball_two[key] = ball_two[key] + 1
            elsif key.to_i < 26
              ball_three[key] = ball_three[key] + 1
            elsif key.to_i < 36
              ball_four[key] = ball_four[key] + 1
            elsif key.to_i < 45
              ball_five[key] = ball_five[key] + 1
            else
              ball_six[key] = ball_six[key] + 1
            end
          end
        end
      end
    end

    # sorting out highest counts
    positions = Array.new
    positions = [ball_one, ball_two, ball_three, ball_four, ball_five, ball_six]
    positions.each do |position|
      g = position.values
      g.sort!
      position.delete_if {|k, v| v < g.last}
    end

    return positions

  end

  ################################################
  ################################################

  def cash5

    # get the source
    doc = Nokogiri::HTML(URI.open('https://www.lotteryusa.com/pennsylvania/cash-5/year'))
    results = []
    doc.css('li').each do |data|
      d = data.content.strip
      if d.to_i != 0
        results.push(d)
      end
    end

    latest_draws = Array.new #holds strings of numbers

    #push numbers into array and only get enough so that all numbers are accounted for
    counter = 3
    100.times do
      latest_draws.push(results.shift(5))
      break if latest_draws.flatten.uniq.length >= 43
    end
  
    #put all 43 numbers into an array as strings
    all_numbers = Array.new
    43.times do |t|
      all_numbers.push((t+1).to_s)
    end

    #create hash with all numbers and set value to zero
    candidates = Hash.new
    all_numbers.each do |a|
      candidates[a] = 0
    end

    #set all numbers that were drawn to 1
    4.times do |draw|
      latest_draws[draw].each do |pick|
        candidates[pick] = 1
      end
    end
    
    #remove all numbers that were drawn
    candidates.delete_if {|k, v| v == 1}
    
    #initialize ranges

    ball_five = Hash.new
    all_numbers.pop(5).each do |b|
      candidates.each do |key, value|
        if key == b
          ball_five[key] = 0
        end
      end
    end

    ball_four = Hash.new
    all_numbers.pop(11).each do |c|
      candidates.each do |key, value|
        if key == c
          ball_four[key] = 0
        end
      end
    end

    ball_three = Hash.new
    all_numbers.pop(11).each do |d|
      candidates.each do |key, value|
        if key == d
          ball_three[key] = 0
        end
      end
    end

    ball_two = Hash.new
    all_numbers.pop(11).each do |e|
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
        draw.each do |j|
          if key == j
            if key.to_i < 6
              ball_one[key] = ball_one[key] + 1
            elsif key.to_i < 17
              ball_two[key] = ball_two[key] + 1
            elsif key.to_i < 28
              ball_three[key] = ball_three[key] + 1
            elsif key.to_i < 39
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

    return positions

  end

##########################################
##########################################

  def treasurehunt

    # get the source
    doc = Nokogiri::HTML(URI.open('https://www.lotteryusa.com/pennsylvania/treasure-hunt/year'))
    results = []
    doc.css('li').each do |data|
      d = data.content.strip
      if d.to_i != 0
        results.push(d)
      end
    end

    latest_draws = Array.new #holds strings of numbers

    #push numbers into array and only get enough so that all numbers are accounted for
    
    100.times do
      latest_draws.push(results.shift(5))
      break if latest_draws.flatten.uniq.length >= 30
    end

    #put all 30 numbers into an array as strings
    all_numbers = Array.new
    30.times do |t|
      all_numbers.push((t+1).to_s)
    end

    #create hash with all numbers and set value to zero
    candidates = Hash.new
    all_numbers.each do |a|
      candidates[a] = 0
    end

    #set all numbers that were drawn to 1
    3.times do |draw|
      latest_draws[draw].each do |pick|
        candidates[pick] = 1
      end
    end
    
    #remove all numbers that were drawn
    candidates.delete_if {|k, v| v == 1}
    
    #initialize ranges

    ball_five = Hash.new
    all_numbers.pop(4).each do |b|
      candidates.each do |key, value|
        if key == b
          ball_five[key] = 0
        end
      end
    end

    ball_four = Hash.new
    all_numbers.pop(7).each do |c|
      candidates.each do |key, value|
        if key == c
          ball_four[key] = 0
        end
      end
    end

    ball_three = Hash.new
    all_numbers.pop(8).each do |d|
      candidates.each do |key, value|
        if key == d
          ball_three[key] = 0
        end
      end
    end

    ball_two = Hash.new
    all_numbers.pop(7).each do |e|
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
        draw.each do |j|
          if key == j
            if key.to_i < 5
              ball_one[key] = ball_one[key] + 1
            elsif key.to_i < 12
              ball_two[key] = ball_two[key] + 1
            elsif key.to_i < 20
              ball_three[key] = ball_three[key] + 1
            elsif key.to_i < 27
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

    return positions

  end

  ################################################################
  ################################################################


  def cash4life

    # get the source
    doc = Nokogiri::HTML(URI.open('https://www.lotteryusa.com/pennsylvania/cash4life/year'))
    results = []
    doc.css('li').each do |data|
      d = data.content.strip
      if d.to_i != 0
        results.push(d)
      end
    end

    latest_draws = Array.new #holds strings of numbers

    #push numbers into array and only get enough so that all numbers are accounted for
    100.times do
      latest_draws.push(results.shift(5))
      #break if latest_draws.flatten.uniq.length >= 60
    end
  
    #put all 49 numbers into an array as strings
    all_numbers = Array.new
    60.times do |t|
      all_numbers.push((t+1).to_s)
    end

    #create hash with all numbers and set value to zero
    candidates = Hash.new
    all_numbers.each do |a|
      candidates[a] = 0
    end

    #set all numbers that were drawn to 1
    6.times do |draw|
      latest_draws[draw].each do |pick|
        candidates[pick] = 1
      end
    end
    
    #remove all numbers that were drawn
    candidates.delete_if {|k, v| v == 1}
    
    #initialize ranges

    ball_five = Hash.new
    all_numbers.pop(7).each do |b|
      candidates.each do |key, value|
        if key == b
          ball_five[key] = 0
        end
      end
    end
    
    ball_four = Hash.new
    all_numbers.pop(15).each do |c|
      candidates.each do |key, value|
        if key == c
          ball_four[key] = 0
        end
      end
    end
    
    ball_three = Hash.new
    all_numbers.pop(16).each do |d|
      candidates.each do |key, value|
        if key == d
          ball_three[key] = 0
        end
      end
    end
    
    ball_two = Hash.new
    all_numbers.pop(15).each do |e|
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
        draw.each do |j|
          if key == j
            if key.to_i < 8
              ball_one[key] = ball_one[key] + 1
            elsif key.to_i < 23
              ball_two[key] = ball_two[key] + 1
            elsif key.to_i < 39
              ball_three[key] = ball_three[key] + 1
            elsif key.to_i < 54
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

    return positions

  end

end
