require 'spec_helper'

describe "urls/show" do
  before(:each) do
    @url = assign(:url, stub_model(Url,
      :long => "Long",
      :short => "Short"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Long/)
    rendered.should match(/Short/)
  end
end
