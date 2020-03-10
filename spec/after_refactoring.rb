describe '#recommended_items_for_item' do
  let(:item) { mock_model(Item).as_null_object }
  let(:response) do
    {
      "class" => ["recommendations", "collection"],
      "entities" => [{
        "class" => ["grouping"],
        "properties" => {
          "name" => "Suggested items",
          "href" => "http://themeforest.net"
        },
        "entities" => [{
          "class" => ["item", "recommendation"],
          "properties" => { "id" => 7668951, }
        }]
      }]
    }
  end
  it "returns the recommended items as suggestions" do
    expect(RecommenderApi::Recommender).to receive(:get_recommendations).and_return(response)
    result = RecommenderApiAdapter.recommended_items_for_item(item)
    expect(result).to eq([{
      :title => "Suggested items",
      :url => "http://themeforest",
      :ids => [RecommenderApiAdapter::Suggestion.new(7668951)]
      }])
  end
end
