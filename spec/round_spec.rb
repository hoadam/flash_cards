require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'

RSpec.describe Round do
  let(:card_1) { Card.new("What is the capital of Alaska?", "Juneau", "Geography") }
  let(:card_2) { Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", "STEM") }
  let(:card_3) { Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", "STEM") }
  let(:deck) { Deck.new([card_1, card_2, card_3]) }

  describe '#initialize' do
    it 'is an instance of Round' do
      deck = Deck.new([])
      round = Round.new(deck)

      expect(round).to be_a Round
    end

    it 'has a deck' do
      deck = Deck.new([])
      round = Round.new(deck)

      expect(round.deck).to be_a (Deck)
    end

    it 'has turns' do
      deck = Deck.new([])
      round = Round.new(deck)
      expect(round.turns).to eq ([])
    end
  end

  describe '#current_card' do
    it "show the current card" do
      round = Round.new(deck)

      expect(round.current_card).to eq (card_1)
    end
  end

  describe '#take_turn' do
    it 'create a Turn object and add it to turns array' do
      round = Round.new(deck)

      new_turn = round.take_turn("Juneau")

      expect(new_turn).to be_a (Turn)
      expect(round.turns).to eq ([new_turn])
    end

    it 'return the next card' do
      round = Round.new(deck)

      round.take_turn("guess")

      expect(round.current_card).to eq (card_2)
    end
  end

  describe '#number_correct' do
    it 'count the number of correct turns' do
      round = Round.new(deck)

      round.take_turn("Juneau")
      round.take_turn("Venus")
      round.take_turn("North North West")

      expect(round.number_correct).to eq (2)
    end
  end

  describe '#number_correct_by_category' do
    it 'count the number of correct turns for each category' do
      round = Round.new(deck)

      round.take_turn("Juneau")
      round.take_turn("Venus")
      round.take_turn("North North West")

      expect(round.number_correct_by_category("Geography")).to eq (1)
      expect(round.number_correct_by_category("STEM")).to eq (1)
    end
  end

  describe '#percent_correct' do
    it 'calculate the percentage of correct turns' do
      round = Round.new(deck)

      round.take_turn("Juneau")
      round.take_turn("Venus")
      round.take_turn("North North West")

      expect(round.percent_correct).to eq (66.67)
    end
  end

  describe '#percent_correct_by_category' do
    it 'calculate the percentage of correct turns for a specific category' do
      round = Round.new(deck)

      round.take_turn("Juneau")
      round.take_turn("Venus")
      round.take_turn("North North West")

      expect(round.percent_correct_by_category("STEM")).to eq (50)
      expect(round.percent_correct_by_category("Geography")).to eq (50)
    end
  end
end
