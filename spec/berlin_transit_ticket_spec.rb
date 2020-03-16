# frozen_string_literal: true

class BerlinTransitTicket
  attr_accessor :starting_station, :ending_station
  def fare
    if ending_station == 'Leopoldplatz'
      2.7
    elsif ending_station == 'Birkenwerder'
      3.3
    end
  end
end

RSpec.describe BerlinTransitTicket do
  starting_station = ''
  ending_station = ''

  let(:ticket) { BerlinTransitTicket.new }
  before do
    ticket.starting_station = starting_station
    ticket.ending_station = ending_station
  end
  let(:fare) { ticket.fare }
  context 'when starting in zone A' do
    let(:starting_station) { 'Bundestag' }
    context 'and ending in zone B' do
      let(:ending_station) { 'Leopoldplatz' }
      it 'cost $2.70' do
        expect(fare).to eq 2.7
      end
    end
  end
  context 'and ending in zone C' do
    let(:ending_station) { 'Birkenwerder' }
    it 'cost $3.30' do
      expect(fare).to eq 3.3
    end
  end
end

RSpec.describe BerlinTransitTicket do
  def fare_for(starting_station, ending_station)
    ticket = BerlinTransitTicket.new
    ticket.starting_station = starting_station
    ticket.ending_station = ending_station
    ticket.fare
  end

  context 'when starting in zone A and ending in zone B' do
    it 'costs $2.70' do
      expect(fare_for('Bundestag', 'Leopoldplatz')).to eq 2.7
    end
  end

  context 'when starting in zone A and ending in zone B' do
    it 'costs $3.30' do
      expect(fare_for('Bundestag', 'Birkenwerder')).to eq 3.3
    end
  end
end
