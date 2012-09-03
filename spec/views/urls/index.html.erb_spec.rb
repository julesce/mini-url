require 'spec_helper'

describe "urls/index" do
  before(:each) do
    assign(:urls, [
      stub_model(Url,
        :long => "Long",
        :short => "Short"
      ),
      stub_model(Url,
        :long => "Long",
        :short => "Short"
      )
    ])
  end

  it "renders a list of urls" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Long".to_s, :count => 2
    assert_select "tr>td", :text => "Short".to_s, :count => 2
  end
end
