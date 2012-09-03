require 'spec_helper'

describe "urls/new" do
  before(:each) do
    assign(:url, stub_model(Url,
      :long => "MyString",
      :short => "MyString"
    ).as_new_record)
  end

  it "renders new url form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => urls_path, :method => "post" do
      assert_select "input#url_long", :name => "url[long]"
      assert_select "input#url_short", :name => "url[short]"
    end
  end
end
