class TrucksController < ApplicationController
  # GET /trucks
  def index
    @trucks = Truck.all
  end

  # GET /trucks/1
  def show
    @truck = Truck.find(params[:id])
  end

  # GET /trucks/new
  def new
    @truck = Truck.new
  end

  # GET /trucks/1/edit
  def edit
    @truck = Truck.find(params[:id])
  end

  # POST /trucks
  def create
    @truck = Truck.new(truck_params)

    if @truck.save
      redirect_to @truck, notice: 'Truck was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /trucks/1
  def update
    @truck = Truck.find(params[:id])
    if @truck.update(truck_params)
      redirect_to @truck, notice: 'Truck was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /trucks/1
  def destroy
    @truck = Truck.find(params[:id])
    @truck.destroy
    redirect_to trucks_url, notice: 'Truck was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def truck_params
      params.require(:truck).permit(:name, :location, :latitude, :longitude)
    end
end
