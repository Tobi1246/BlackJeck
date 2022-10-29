class Interface
  attr_reader :stack_deck, :player, :player2, :total

  def initialize 
    puts "Добро пожаловать на игру BlackJeck"
    print "Введите ваше имя:"
    name = gets.chomp
    @player = Player.new(name)
    @player2 = Player.new('Дилер')
    @stack_deck = Deck.new
  end

  def game_menu
    loop do 
       main_menu = [
        '1. Начать игру',
        '0 - выход из меню'
      ]
      main_menu.each { |item| puts item } 
      case gets.chomp.to_i
      when 1
      game
      else 
      break
      end
    end    
  end

  def show_card_user(player)
    print "В вашей руке #{player.name}"
    player.card_in_hand.each do |card, index|
      print " #{card.rank}#{card.suit} "
    end
    print "очков: "
  end

  def game
    @stack_deck.deal(2,@player)
    show_card_user(@player)
    puts @player.total
    @stack_deck.deal(2,@player2)
    puts "Карты Дилера ** **"
    puts "Сделаны ставки в размени 10$"
    bet
    puts "Ваш баланс составляет #{@player.bank}$\tБаланс Дилера: #{@player2.bank}$"
    choice 
  end

  def choice
    loop do 
      if win_game
        break
      end
      if max_card
        puts "Ко-во карт обоих игроков достигло 3"
        break
      end
      puts "Желаете взять карту или пропустить ход, открыть карты?"
      puts "Взять карту ? -нажмите 1, пропуск хода -2, открыть карты -3"     
      case gets.chomp.to_i
      when 1
        if @player.card_in_hand.size == 2
          @stack_deck.deal(1,@player)  
          show_card_user(@player)
          puts @player.total
        else
          puts "У вас максимально ко-во карт в руке"
        end
        if @player.total > 21
          lose 
          break 
        end
      when 2
        bot_value 
        puts "Диллер завершил свой ход"
      when 3 
        bot_value 
        lose
        break
      end
    end    
  end

  def bet
    @player.bank -=10
    @player2.bank -=10
  end

  def results
    show_card_user(@player)
    puts @player.total
    show_card_user(@player2)
    puts @player2.total
    if @player2.total > 21
      @player.bank += 20
      puts "Вы выиграли!!! вы получаете 10$ ваш текущий баланс:#{@player.bank}$"
      puts "На счету у Дилерра осталось:#{@player2.bank}$"
    elsif @player.total > @player2.total  
      @player.bank += 20
      puts "Вы выиграли!!! вы получаете 10$ ваш текущий баланс:#{@player.bank}$"
      puts "На счету у Дилерра осталось:#{@player2.bank}$"
    elsif @player2.total > @player.total  
      @player2.bank += 20   
      puts "Вы проиграли =(  10$ ваш текущий баланс:#{@player.bank}$"
      puts "На счету у Дилерра осталось:#{@player2.bank}$"  
    else @player2.total == @player.total
      puts "Вы сыграли в ничью !!! Все остаются при своих деньгах!"
      @player.bank += 10
      @player2.bank += 10
    end
    delete_date
  end

  def lose
    if @player.total > 21 
      show_card_user(@player2)
      puts @player2.total      
      puts "Вы проиграли =(  10$ ваш текущий баланс:#{@player.bank}$"
      delete_date
    else
      results
    end
  end

  def bot_value   
    @stack_deck.deal(1,@player2) if @player2.total < 17 && @player2.card_in_hand.size == 2
  end

  def delete_date
    @player.card_in_hand.clear
    @player.total = 0
    @player2.card_in_hand.clear
    @player2.total = 0    
    @stack_deck = []
    @stack_deck = Deck.new
  end

  def max_card
   results if @player.card_in_hand.size == 3 && @player2.card_in_hand.size == 3 
  end

  def win_game
    if @player2.bank == 0
      puts "У Дилера не осталось денег!!!"
      puts "Вы ПОБЕДИЛИ!!! =)"
    elsif @player.bank == 0
      puts "У Вас не осталось денег!!!"
      puts "Вы потерпели ПОРАЖЕНИЕ!!!"  
    end    
  end
end
