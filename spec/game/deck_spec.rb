require 'spec_helper'
require 'deck'

describe Deck do

  SUITS = %w{ H D S C }
  RANKS = %w{ 2 3 4 5 6 7 8 9 10 J Q K A }

  subject { Deck.new }

  context 'when is created' do
    it 'has 52 cards' do
      expect(subject.cards).to have(52).items
    end

    it 'is already shuffled' do
      expect(subject).to_not eq @cards
    end
  end

  context '#pop' do
    before do
      @card = subject.pop
    end

    it 'reduces deck size by one' do
      expect(subject.cards).to have(51).items
    end

    it 'draws a real card' do
      expect(subject.cards).to include(@card)
    end
  end

  context '#include_rank?' do
    it 'returns false if rank in deck' do
      expect(subject.include_rank?('L')).to eq false
    end

    it 'returns true if rank in deck' do
      RANKS.each do |rank|
        expect(subject.include_rank?(rank)).to eq true
      end
    end

  end

  context '#empty?' do
    before do
      51.times { subject.pop }
    end

    it 'returns false if deck is not empty' do
      expect(subject.empty?).to eq false
    end

    it 'returns true if deck is not empty' do
      subject.pop
      expect(subject.empty?).to eq true
    end

  end

end
