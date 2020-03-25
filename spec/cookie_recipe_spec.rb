# frozen_string_literal: true

class CookieRecipe
  attr_reader :ingredients
  def initialize
    @ingredients = %i[butter milk flour sugar eggs chocolate_chips]
  end
end

RSpec.describe CookieRecipe, '#ingredients' do
  subject { CookieRecipe.new.ingredients }
  it { should include(:butter, :milk, :eggs) }
  it { should_not include(:fish_oil) }
end
