# encoding: utf-8

require 'card'
require 'player'
require 'hand'
require 'spec_helper'
require 'output'

describe Player do

  context 'when created' do

    before do
      @cards = []
      SUITS.product(RANKS) do |suit, rank|
        @cards << Card.new(suit: suit, rank: rank)
      end

      @h2   = Card.new(suit: 'H', rank: '2')
      @c2 = Card.new(suit: 'C', rank: '2')

      @hand = []
      @hand << @h2
      @hand << @c2
      @hand << Card.new(suit: 'H', rank: '3')
      @hand << Card.new(suit: 'H', rank: '4')
      @hand << Card.new(suit: 'H', rank: '5')
      @hand << Card.new(suit: 'H', rank: '6')
      @hand << Card.new(suit: 'H', rank: '7')
      @hand << Card.new(suit: 'H', rank: '8')
    end

    subject { Player.new(name: 'Luís', hand: Hand.new(@hand)) }

    it 'has a name' do
      expect(subject.name).to eq 'Luís'
    end

  end

  context '#discard_pairs' do

    subject { Player.new(name: 'Luís', hand: Hand.new([])) }

    context 'when there is a pair' do

      it 'discards the pair' do
        subject.hand << Card.new(suit: 'H', rank: '2')
        subject.hand << Card.new(suit: 'C', rank: '2')
        expect(subject.hand.cards).to have(2).items
        subject.discard_pairs
        expect(subject.hand.cards).to have(0).items
      end

      it 'only discards a pair' do
        %w{C D S}.each do |suit|
          subject.hand << Card.new(suit: suit, rank: '10')
        end
        expect(subject.hand.cards.count).to eq 3
        expect(subject.hand.cards.map(&:to_s)).to include('10C', '10D', '10S')
        subject.discard_pairs
        expect(subject.discarded_pairs).to have(1).item
        expect(subject.pairs).to have(1).item
        expect(subject.hand.cards).to have(1).item
      end
    end

    context 'when there is *no* pair' do

      it 'doesn\'t discard anything' do
        %w{2 3 4 5 A}.each do |rank|
          subject.hand << Card.new(suit: 'H', rank: rank)
        end
        expect(subject.hand.cards).to have(5).items
        expect(subject.hand.cards.map(&:to_s)).to include 'AH'
        subject.discard_pairs
        expect(subject.pairs).to have(0).items
        expect(subject.hand.cards.count).to eq 5
      end
    end
  end

  context '#to_s' do

    subject { Player.new(name: 'Luís', hand: Hand.new([])) }

    it 'prints the user info' do
      expect(subject.to_s).to include 'Luís'
      expect(subject.to_s).to include '0 pairs'
      expect(subject.to_s).to include '0 cards'
    end
  end
end
