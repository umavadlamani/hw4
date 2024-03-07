class EntriesController < ApplicationController
  def index
    @entries = Entry.all
  end

  def new
    @place = Place.find_by({"id" => params["place_id"]})
    @entry = Entry.new
  end

  def create
    if @current_user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = @current_user["id"]
      @entry.uploaded_image.attach(params["uploaded_image"])
      @entry.save
      redirect_to "/places/#{@entry["place_id"]}"
    else
      flash["notice"] = "Login first please!"
    end
  end
end
