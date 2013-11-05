# encoding: utf-8

require 'spec_helper'
require 'game'
require 'deck'

describe Game do

  context 'when Go Fish! starts' do
    subject { Game.new }

    its(:user) { have(7).items }
    its(:computer) { have(7).items }
    its(:deck) { have(52).items }
  end

  context "#opponent_has?" do
    subject { Game.new }

    it 'transfers cards to player' do
      card = Card.new(rank: 'A', suit: 'H')
      subject.opponent.hand << card
      expect(subject.player_has_rank?(subject.opponent, 'A')).to eq true
      subject.opponent_has?('A')
      expect(subject.player_has_rank?(subject.opponent, 'A')).to eq false
      expect(subject.current_player.hand.include?('A')).to eq true
      expect(subject.current_player.hand.cards).to include(card)
    end
  end

  context "#player_has_rank?" do
    let(:opponent) { Player.new(name: 'Luís', hand: Hand.new([])) }

    it 'returns true if player has rank' do
      opponent.hand << Card.new(rank: 'A', suit: 'H')
      expect(subject.player_has_rank?(opponent, 'A')).to eq true
      expect(subject.player_has_rank?(opponent, 'Q')).to eq false
    end
  end

  context "go_fish" do
    subject { Game.new }
    it 'draws a card from the deck' do
      expect(subject.deck.cards).to have(38).items
      subject.current_player = Player.new(name: 'Luís', hand: Hand.new([]))
      expect(subject.current_player.hand.cards).to have(0).items
      subject.go_fish
      expect(subject.deck.cards).to have(37).items
      expect(subject.current_player.hand.cards).to have(1).items
    end
  end

  context "compare_pairs" do
    subject { Game.new }

    context 'when user has more pairs' do
      it 'returns -1' do
        subject.computer.pairs = %w{p p}
        expect(subject.computer.pairs).to eq %w{p p}
        subject.user.pairs = %w{p p p p p}
        expect(subject.user.pairs).to eq %w{p p p p p}
        expect(subject.compare_pairs).to eq -1
      end
    end

    context 'when computer has more pairs' do
      it 'returns 1' do
        subject.computer.pairs = %w{p p p p p}
        expect(subject.computer.pairs).to eq %w{p p p p p}
        subject.user.pairs = %w{p p}
        expect(subject.user.pairs).to eq %w{p p}
        expect(subject.compare_pairs).to eq 1
      end
    end

    context 'both have same number of pairs' do
      it 'returns 0' do
        subject.computer.pairs = %w{p p}
        expect(subject.computer.pairs).to eq %w{p p}
        subject.user.pairs = %w{p p}
        expect(subject.user.pairs).to eq %w{p p}
        expect(subject.compare_pairs).to eq 0
      end
    end
  end
end
