class Card
  attr_accessor :rank, :suit, :value
     
  def initialize(rank, suit, value)
    @rank = rank
    @suit = suit
    @value = value
  end
  
  def generate_card(player)
    new_card = Card.new rank, suit, value
    player.card_in_hand << new_card
    if new_card.suit == 'A' && player.total >= 11
      player.total += 1
    else
      player.total +=  new_card.value 
    end     
  end
end
