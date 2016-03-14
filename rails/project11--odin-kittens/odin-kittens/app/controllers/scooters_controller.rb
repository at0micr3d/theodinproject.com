class ScootersController < ApplicationController
  before_action :set_scooter, only: [:show, :edit, :update, :destroy]

  # GET /scooters
  # GET /scooters.json
  def index
    @scooters = Scooter.all
  end

  # GET /scooters/1
  # GET /scooters/1.json
  def show
  end

  # GET /scooters/new
  def new
    @scooter = Scooter.new
  end

  # GET /scooters/1/edit
  def edit
  end

  # POST /scooters
  # POST /scooters.json
  def create
    @scooter = Scooter.new(scooter_params)

    respond_to do |format|
      if @scooter.save
        format.html { redirect_to @scooter, notice: 'Scooter was successfully created.' }
        format.json { render :show, status: :created, location: @scooter }
      else
        format.html { render :new }
        format.json { render json: @scooter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scooters/1
  # PATCH/PUT /scooters/1.json
  def update
    respond_to do |format|
      if @scooter.update(scooter_params)
        format.html { redirect_to @scooter, notice: 'Scooter was successfully updated.' }
        format.json { render :show, status: :ok, location: @scooter }
      else
        format.html { render :edit }
        format.json { render json: @scooter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scooters/1
  # DELETE /scooters/1.json
  def destroy
    @scooter.destroy
    respond_to do |format|
      format.html { redirect_to scooters_url, notice: 'Scooter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scooter
      @scooter = Scooter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scooter_params
      params.fetch(:scooter, {})
    end
end
