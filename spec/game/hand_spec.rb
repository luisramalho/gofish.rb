require 'spec_helper'
require 'hand'

describe Hand do

  subject { Hand.new([]) }

  context 'when is created' do
    it 'has 0 cards' do
      expect(subject.cards).to have(0).items
    end
  end

  context '#random_rank' do
    it 'returns random rank' do
      subject.cards << Card.new(rank: 'A', suit: 'H')
      subject.cards << Card.new(rank: '5', suit: 'H')
      subject.cards << Card.new(rank: 'Q', suit: 'C')
      subject.cards << Card.new(rank: 'A', suit: 'C')
      expect(subject.random_rank).to be_a String
    end
  end

  context '#include?' do
    it 'returns true if hand has rank' do
      subject.cards << Card.new(rank: 'A', suit: 'H')
      subject.cards << Card.new(rank: '5', suit: 'H')
      subject.cards << Card.new(rank: 'Q', suit: 'C')
      subject.cards << Card.new(rank: 'A', suit: 'C')
      expect(subject.include?('A')).to eq true
      expect(subject.include?('5')).to eq true
      expect(subject.include?('3')).to eq false
      subject.cards << Card.new(rank: '3', suit: 'C')
      expect(subject.include?('3')).to eq true
    end
  end

  context '#count' do
    it 'returns the number of cards' do
      expect(subject.count).to eq 0
      subject.cards << Card.new(rank: 'A', suit: 'H')
      expect(subject.count).to eq 1
    end
  end

  context '#cards_same_rank' do
    it 'returns cards with same rank' do
      subject.cards << Card.new(rank: 'A', suit: 'H')
      subject.cards << Card.new(rank: '5', suit: 'H')
      subject.cards << Card.new(rank: 'Q', suit: 'C')
      subject.cards << Card.new(rank: 'A', suit: 'C')
      expect(subject.cards_same_rank('A').map(&:to_s)).to eq %w{AH AC}
    end
  end

  context '#delete' do
    it 'deletes cards' do
      expect(subject.count).to eq 0
      card = Card.new(rank: 'A', suit: 'H')
      subject.cards << card
      expect(subject.count).to eq 1
      subject.delete(card)
      expect(subject.count).to eq 0
    end
  end

  context '#sort!' do
    it 'sorts cards by rank' do
      subject.cards << Card.new(rank: 'A', suit: 'H')
      subject.cards << Card.new(rank: '5', suit: 'H')
      subject.cards << Card.new(rank: 'Q', suit: 'H')
      subject.cards << Card.new(rank: '3', suit: 'H')
      expect(subject.to_s).to eq 'AH, 5H, QH, 3H'
      subject.sort!
      expect(subject.to_s).to eq '3H, 5H, QH, AH'
    end
  end

  context '#empty?' do
    it 'returns true if no cards' do
      ha = Card.new(rank: 'A', suit: 'H')
      h5 = Card.new(rank: '5', suit: 'H')
      subject.cards << ha
      subject.cards << h5
      expect(subject.empty?).to eq false
      subject.delete(ha)
      expect(subject.empty?).to eq false
      subject.delete(h5)
      expect(subject.empty?).to eq true
    end
  end

  context '#to_s' do
    it 'stringified hand' do
      subject.cards << Card.new(rank: 'A', suit: 'H')
      subject.cards << Card.new(rank: '5', suit: 'H')
      subject.cards << Card.new(rank: 'Q', suit: 'C')
      subject.cards << Card.new(rank: 'A', suit: 'C')
      expect(subject.to_s).to be_a String
      expect(subject.to_s).to eq 'AH, 5H, QC, AC'
    end
  end

end