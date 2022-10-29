class Deck
  attr_accessor :stack_deck
    
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
end
