require 'spec_helper'

describe UrlsController do

  def valid_post_attributes
    {:long_url => 'http://www.google.com'}
  end

  describe "POST shorten" do
    it "creates a new Url" do
      expect {
        post :shorten, valid_post_attributes
      }.to change(Url, :count).by(1)
    end

    it "renders the url as json" do
      post :shorten, valid_post_attributes
      response.should be_ok
      json_url = JSON.parse(response.body)
      json_url['long'].should == 'http://www.google.com'
      json_url['short'].should be_present
    end
  end

  describe "GET go/:short_url" do
    it "assigns the requested url as @url" do
      url = create(:url, :long => 'http://www.google.com', :short => 'abcde')
      get :go, {:short_url => url.short}
      assigns(:url).should eq(url)
    end

    it "redirects to the long url value" do
      url = create(:url, :long => 'http://www.google.com', :short => 'abcde')
      get :go, {:short_url => url.short}
      response.should redirect_to(url.long)
    end
  end
end