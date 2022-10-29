class Interface
  attr_reader :stack_deck, :player, :player2, :total
# интерфейс и логика игры 
  def initialize 
    puts "Добро пожаловать на игру BlackJeck"
    print "Введите ваше имя:"
    name = gets.chomp
    @player = Player.new(name)
    @player2 = Player.new('Дилер')
    @stack_deck = Deck.new
  end
# просим ввести имя игрока и начинаем нашу игру
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
# меню для игрока с уловиями победы и поражения , 
# а так же возможность выйти и не продолжать игру
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
# начало игры , инстантно добавляем карты игроку и дилеру 
# делаем ставки в размере 10 баксов и вызываем меню выборов(choice)  
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
# здесь мы предлогаем игроку варианты событий  
  def bet
    @player.bank -=10
    @player2.bank -=10
  end
# стартовые ставки 
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
# подсчёт результатов с приоритетом для организации(если игрок набрал выше 21 автоматически проиграл) 
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
#условия при которыз игрок проиграл , если не проиграл то вызываем подсчёт очков игроков
  def bot_value   
    @stack_deck.deal(1,@player2) if @player2.total < 17 && @player2.card_in_hand.size == 2
  end
# берём карту на нашем Диллере по условию
  def delete_date
    @player.card_in_hand.clear
    @player.total = 0
    @player2.card_in_hand.clear
    @player2.total = 0    
    @stack_deck = []
    @stack_deck = Deck.new
  end
# что бы не награмождать данными просто удаляем карты из руки и колоды
# и создаём уникальную колоду   
  def max_card
   results if @player.card_in_hand.size == 3 && @player2.card_in_hand.size == 3 
  end
# лимит на владения картами в руке одного игрока
  def win_game
    if @player2.bank == 0
      puts "У Дилера не осталось денег!!!"
      puts "Вы ПОБЕДИЛИ!!! =)"
    elsif @player.bank == 0
      puts "У Вас не осталось денег!!!"
      puts "Вы потерпели ПОРАЖЕНИЕ!!!"  
    end
# уловия победы/поражения в игре    
  end
end
