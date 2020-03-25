# frozen_string_literal: true

require 'erb'

# weekday = Time.now.strftime('%A')
# simple_template = 'Today is <%= weekday %>'
#
# renderer = ERB.new(simple_template)
# puts output = renderer.result

def get_items
  %w[bread milk eggs spam]
end

def get_template
  %w[ Shopping List for <%= @date.strftime('%A %d %B %Y') %>
      You need to buy:
      <% for @item in @items %>
      <%= h(@item) %>
      <% end %>]
end

class ShoppingList
  include ERB::Util
  attr_accessor :items, :template, :date

  def initialize(items, template, date = Time.now)
    @date = date
    @items = items
    @template = template
  end

  def render
    ERB.new(@template).result(binding)
    # renderer.result(binding)
  end

  def display
    puts render
  end

  def save(file)
    File.open(file, 'w+') do |f|
      f.write(render)
    end
  end
end

# list = ShoppingList.new(items)
# renderer = ERB.new(template)
# puts output = renderer.result(list.get_binding)
list = ShoppingList.new(get_items, get_template)
list.display
# list.save(File.join(ENV['HOME'], 'list.html'))
