describe '#recommended_items_for_item' do
  let(:item) { double(:item, :id => 7917671 )}
  let(:response) do
    {
      "class" => ["recommendations", "collection"],
      "properties" => {
        "facts" => {
          "item_id" => "791671",
          "Site" => "themeforest.net",
          "category" => "wordpress"
        },
        "skipped" => [],
        "included" => ["item-items"]},
        "entities" => [{
          "class" => ["grouping"],
          "rel" => "http://www.envato.com/rels/recommended/recommendation-grouping",
          "properties" => {},
          "entities" => [{
            "class" => ["item", "recommendation"],
            "rel" => ["http://www.envato.com/rels/recommended/marketplace/item"],
            "properties" => {
              "id" => 7668951,
              "recommender" => "item-items"
              }
            }
          ]
        }
      ]
    }
  end
  let(:expected_url) { "http://localhost/recommender_api/get_recommendation?category=wordpress&item_id=7917671&restrictions=item-items&site=themeforest.net" }
  let(:options) { {:timeout => 1} }
  it 'calls the item item recommender' do
    item.sub_chain(:category, :root, :site, :domain).and_return("themeforest.net")
    item.sub_chain(:category, :root, :path).and_return("wordpress")
    expect(RecommanderApi::Recommender).to receive(:get_recommendations).and_return(response)
    result = RecommenderApiAdapter.recommended_items_for_item(item)
    expect(result).to eq([{
      :title => "Suggested items",
      :url => "http://themeforest.net",
      :ids => [RecommenderApiAdapter::Suggestion.new(7668951)]
      }])
  end
end
