# frozen_string_literal: true

class CookieRecipe
  attr_reader :ingredients
  def initialize
    @ingredients = %i[butter milk flour sugar eggs chocolate_chips]
  end
end

RSpec.describe CookieRecipe, '#ingredients' do
  specify
    expect(CookieRecipe.new.ingredients).to include(:butter, :milk, :eggs)
  end

  specify do
    expect(CookieRecipe.new.ingredients).not_to include(:fish_oil)
  end
end
