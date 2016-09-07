class PagesController < ApplicationController
  def home
    @trucks = Truck.all
  end
end
