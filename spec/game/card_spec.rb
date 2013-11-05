require 'spec_helper'
require 'deck'
require 'card'

describe Card do
  let(:card) { Card.new(rank: 'A', suit: 'H') }

  context Card do
    it 'has a suit' do
      expect(card.suit).to eq 'H'
    end

    it 'has a rank' do
      expect(card.rank).to eq 'A'
    end
  end

  context '#==' do
    let(:ac) { Card.new(rank: 'A', suit: 'C') }
    let(:ad) { Card.new(rank: 'A', suit: 'D') }
    let(:qd) { Card.new(rank: 'Q', suit: 'D') }
    it 'test equality of cards by rank' do
      expect(ac == ad).to eq true
      expect(ac == qd).to_not eq true
    end
  end

  context '#<=>' do
    let(:ac) { Card.new(rank: 'A', suit: 'C') }
    let(:ad) { Card.new(rank: 'A', suit: 'D') }
    let(:kd) { Card.new(rank: 'K', suit: 'D') }
    let(:qd) { Card.new(rank: 'Q', suit: 'D') }
    let(:jd) { Card.new(rank: 'J', suit: 'D') }
    let(:tend) { Card.new(rank: '10', suit: 'D') }
    let(:nined) { Card.new(rank: '9', suit: 'D') }
    let(:threed) { Card.new(rank: '3', suit: 'D') }
    let(:twod) { Card.new(rank: '2', suit: 'D') }
    it 'compares cards by rank' do
      expect(ac <=> qd).to eq 1
      expect(qd <=> ac).to eq -1
      expect(ac <=> ad).to eq 0
      expect(ad <=> kd).to eq 1
      expect(kd <=> qd).to eq 1
      expect(qd <=> jd).to eq 1
      expect(jd <=> tend).to eq 1
      expect(tend <=> nined).to eq 1
      expect(threed <=> twod).to eq 1
    end
  end

  context '#to_s' do
    it 'converts Card to String' do
      expect(card.to_s).to eq 'AH'
    end
  end
end
