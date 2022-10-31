# frozen_string_literal: true

class Card
  attr_accessor :rank, :suit, :value

  # класс карт , сдесь создаём наминал, масти и значения
  MAX_POINTS = 21
  def initialize(rank, suit, value)
    @rank = rank
    @suit = suit
    @value = value
  end

  # соёздаём сами карты и подсчитываем сразу их значения с условием на туза
  def generate_card(player)
    new_card = Card.new rank, suit, value
    player.card_in_hand << new_card
    player.total += if new_card.suit == 'A' && player.total >= 11
                      1
                    else
                      new_card.value
                    end
  end
end
