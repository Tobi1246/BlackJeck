class Deck
  attr_accessor :stack_deck
 #клас колоды , здесь мы возданные карты помещаем в нашу колоду   
  def initialize
    @rank = [*(2..10), 'J', 'Q', 'K', 'A']
    @suit = %i[♥ ♣ ♦ ♠]
    @stack_deck = []

    @rank.each do |rank|
      if rank.class == Integer
        value = rank
      elsif rank == 'A'
        value = 11
      else
        value = 10
      end
      @suit.each do |suit|   
        @stack_deck << Card.new(rank, suit, value)
      end   
    end
    @stack_deck.shuffle!
  end

  def deal(num, player)
    num.times {@stack_deck.shift.generate_card(player)}
  end
  #что бы не грамаздить код создали метод выдающий карты игроку и надему Дилеру
end
