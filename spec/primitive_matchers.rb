# frozen_string_literal: true

require 'rspec/core'
require 'rspec/expectations'
require 'stringio'

class Permutations
  def of(_words)
    :result
  end
end
long_word_list = []

class User
  def initialize(admin)
    @admin = admin
  end

  def admin?
    @admin
  end

  def to_s
    '#<User name="Daphne">'
  end

  alias inspect to_s
end

def heredoc_without_markers(heredoc)
  heredoc
    .chomp
    .split("\n")
    .reject { |l| l =~ /# (START|END)/ }
    .join("\n")
    .gsub(/^  /, '')
end

RSpec.describe 'primitive matchers' do
  it 'primitive' do
    expect(Math.sqrt(9)).to eq(3)

    perms = Permutations.new
    first_try = perms.of(long_word_list)
    second_try = perms.of(long_word_list)
    expect(second_try).to eq(first_try)

    expect(second_try).to equal(first_try)

    expect(3).to eq(3.0)
    expect(3).not_to eql(3.0)

    expect([String, Regexp]).to include(String)
    expect(['a string', Regexp]).to include(String)
    expect([String, Regexp]).to include(an_object_eq_to(String))

    # Truthiness
    expect(true).to be_truthy
    expect(0).to be_truthy
    expect(false).not_to be_truthy
    expect(nil).not_to be_truthy

    expect(false).to be_falsey
    expect(nil).to be_falsey
    expect(true).not_to be_falsey
    expect(0).not_to be_falsey

    expect(1.odd?).to be true
    expect(2.odd?).to be false

    # Operator Comparisons
    expect(1).to be == 1
    expect(1).to be < 2
    expect(1).to be <= 2
    expect(2).to be > 1
    expect(2).to be >= 1
    expect(String).to be === 'a string'
    expect(/foo/).to be =~ 'food'

    squares = 1.upto(4).map { |i| i * i }
    expect(squares).to include(a_value > 15)

    # Delta and Range Comparisons
    # expect(0.1 + 0.2).to eq(0.3)
    expect(0.1 + 0.2).to be_within(0.0001).of(0.3)

    town_population = 1237
    expect(town_population).to be_within(25).percent_of(1000)
    expect(town_population).to be_between(750, 1250)

    # Dynamic Predicates
    expect([]).to be_empty

    user = User.new(true)
    expect(user).to be_admin
    expect(user).to be_an_admin

    hash = { name: 'Harry Potter', age: 17, house: 'Gryffindor' }
    expect(hash).to have_key(:age)
    expect(user.admin?).to eq(true)

    array_of_hashes = [{ lol: nil }]
    expect(array_of_hashes).to include(have_key(:lol))

    # Satisfaction
    # expect(1).to satisfy { |num| number.odd? }
    expect(1).to satisfying(&:odd?)
    expect([1, 2, 3]).to include(an_object_satisfying(&:even?))

    # include
    expect('a string').to include('str')
    expect('a string').to include('str', 'ing')
    expect([1, 2, 3]).to include(3)
    expect([1, 2, 3]).to include(3, 2)

    expect(hash).to include(:name)
    expect(hash).to include(:name, :age)
    expect(hash).to include(age: 17)
    expect(hash).to include(name: 'Harry Potter', age: 17)

    expecteds = [3, 2]
    expect([1, 2, 3]).to include(*expecteds)

    # start_with, end_with
    expect('a string').to start_with('a str').and end_with('ng')
    expect([1, 2, 3]).to start_with(1).and end_with(3)
    expect([1, 2, 3]).to start_with(1, 2)
    expect([1, 2, 3]).to end_with(2, 3)

    expect(%w[list of words]).to start_with(
      a_string_ending_with('st')
    ).and end_with(
      a_string_starting_with('wo')
    )

    # all
    numbers = [2, 4, 6, 8]
    expect(numbers).to all be_even

    def self.evens_up_to(n = 0)
      0.upto(n).select(&:odd?)
    end

    expect(evens_up_to).to all be_even
    # expect do
    #   RSpec::Matchers.define_negated_matcher :be_non_empty, :be_empty
    #   expect(evens_up_to).to be_non_empty.and all be_even
    # end.to raise(a_string_including(heredoc_without_markers(<<-EOM)))
    # expected `[].empty?` to return false, got true
    # EOM

    # match
    children = [
      { name: 'Coen', age: 6 },
      { name: 'Daphne', age: 4 },
      { name: 'Crosby', age: 2 }
    ]

    expect(children).to match [
      { name: 'Coen', age: a_value > 5 },
      { name: 'Daphne', age: a_value_between(3, 5) },
      { name: 'Crosby', age: a_value < 3 }
    ]

    # contain_exactly
    expect(children).to contain_exactly(
      { name: 'Daphne', age: a_value_between(3, 5) },
      { name: 'Crosby', age: a_value < 3 },
      { name: 'Coen', age: a_value > 5 }
    )

    expect(children).to contain_exactly(
      { name: 'Crosby', age: a_value < 3 },
      { name: 'Coen', age: a_value > 5 },
      { name: 'Daphne', age: a_value_between(3, 5) }
    )

    # match
    expect('a string').to match(/str/)
    expect('a string').to match('str')

    # Object Attributes
    require 'uri'
    uri = URI('http://github.com/rspec/rspec')
    expect(uri).to have_attributes(host: 'github.com', path: '/rspec/rspec')
    expect([uri]).to include(an_object_having_attributes(host: 'github.com'))

    # Block matchers
    expect(3).to eq(3)
    expect { raise 'boom' }.to raise_error('boom')

    expect do
      'hello'.world
    end.to raise_error(an_object_having_attributes(name: :world))

    expect { 'hello'.world }.to raise_error(NoMethodError) do |ex|
      expect(ex.name).to eq(:world)
    end

    MissingDataError = Class.new(StandardError)

    # risks false positive, since it will catch any exception
    # expect { age__of(user) }.not_to raise_error(MissingDataError)

    expect { throw :found }.to throw_symbol(:found)
    expect { throw :found, 10 }.to throw_symbol(:found, a_value > 9)

    def self.just_yield
      yield
    end

    expect { |block_checker| just_yield(&block_checker) }.to yield_control
    expect { |block| 2.times(&block) }.to yield_control.twice
    expect { |block| 2.times(&block) }.to yield_control.at_most(4).times
    expect { |block| 4.times(&block) }.to yield_control.at_least(3).times

    def self.just_yield_these(*args)
      yield(*args)
    end

    expect do |block|
      just_yield_these(10, 'food', Math::PI, &block)
    end.to yield_with_args(10, /foo/, a_value_within(0.1).of(3.14))

    expect { |block| just_yield_these(&block) }.to yield_with_no_args

    expect do |block|
      %w[football barstool].each_with_index(&block)
    end.to yield_successive_args([/foo/, 0],
                                 [a_string_starting_with('bar'), 1])

    # Mutation
    array = [1, 2, 3]
    expect { array << 4 }.to  change { array.size }
    expect { array.concat([1, 2, 3]) }.to change { array.size }.by(3)
    expect { array.concat([1, 2, 3]) }.to change { array.size }.by_at_least(2)
    expect { array.concat([1, 2, 3]) }.to change { array.size }.by_at_most(4)

    array = [1, 2, 3]
    expect { array << 4 }.to change { array.size }.from(3)
    expect { array << 5 }.to change { array.size }.to(5)
    expect { array << 6 }.to change { array.size }.from(5).to(6)
    expect { array << 7 }.to change { array.size }.to(7).from(6)

    x = 5
    expect { x += 10 }.to change { x }
      .from(a_value_between(2, 7))
      .to(a_value_between(12, 17))

    x = 5
    expect { x += 1 }.to change { x }.from(a_value_between(2, 7))

    x = 5
    expect {}.not_to change { x }.from(5)

    # Output
    expect { print 'OK' }.to output('OK').to_stdout
    expect { warn 'problem' }.to output(/prob/).to_stderr

    expect { system('echo OK') }.to output("OK\n").to_stdout_from_any_process
  end
end

RSpec.describe RSpec do
  describe '.configuration' do
    it 'returns the same object every time' do
      expect(RSpec.configuration).to equal(RSpec.configuration)
      expect(RSpec.configuration).to be(RSpec.configuration)
    end
  end
end
