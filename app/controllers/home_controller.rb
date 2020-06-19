class HomeController < ApplicationController
  def index
    @recently_added = Item.order(created_at: :desc).limit(10)
    @recently_returned = Item.order(returned_at: :desc).limit(10)
  end
end
