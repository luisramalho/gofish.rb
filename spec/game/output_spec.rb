require 'spec_helper'
require 'output'

describe Output do

  subject { Output.new }

  context '#pluralize' do
    it 'returns the plural' do
      expect(subject.pluralize(1, 'card')).to eq '1 card'
      expect(subject.pluralize(2, 'card')).to eq '2 cards'
      expect(subject.pluralize(1, 'person', 'people')).to eq '1 person'
      expect(subject.pluralize(2, 'person', 'people')).to eq '2 people'
    end
  end

end
