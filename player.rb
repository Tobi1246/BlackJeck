# frozen_string_literal: true

class Player
  attr_accessor :bank, :card_in_hand, :name, :total

  # класс игрока в который мы помещаем наши карты , а так же баланс и имя игрока
  STEP_RATE = 10
  WIN_BET = 20
  DRAW_BET = 10
  def initialize(name)
    @name = name
    @bank = 100
    @card_in_hand = []
    @total = 0
  end
end
