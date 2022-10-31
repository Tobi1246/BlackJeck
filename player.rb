class Player
  attr_accessor :bank, :card_in_hand, :name, :total
# класс игрока в который мы помещаем наши карты , а так же баланс и имя игрока
  STEP_RATE = 10
  MAX_POINTS = 21
  def initialize(name)
    @name = name
    @bank = 100
    @card_in_hand = []
    @total = 0
  end
end
