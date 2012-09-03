class UrlsController < ApplicationController

  # POST /shorten
  def shorten
    @url = Url.find_or_shorten(params[:long_url])
    render :json => @url
  end

  # GET /go/:short_url
  def go
    @url = Url.find_by_short_value(params[:short_url])
    if @url.present?
      redirect_to @url.long
    else
      redirect_to no_url_path
    end
  end

  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @urls }
    end
  end

  # GET /urls/new
  def new
  end

  # GET /no_url
  def no_url
    render :status => 404
  end
end
