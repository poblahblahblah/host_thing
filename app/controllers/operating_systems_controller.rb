class OperatingSystemsController < ApplicationController
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }

  respond_to :html, :json

  def index
    @operating_systems = OperatingSystem.all
    respond_with(@operating_systems)
  end

  def show
    @operating_system = OperatingSystem.find(params[:id])
    respond_with(@operating_system)
  end

  def new
    @operating_system = OperatingSystem.new
    respond_with(@operating_system)
  end

  def edit
    @operating_system = OperatingSystem.find(params[:id])
    respond_with(@operating_system)
  end

  def create
    @operating_system = OperatingSystem.new(operating_system_params)

    if @operating_system.save
     respond_to do |format|
        format.html { redirect_to @operating_system }
        format.json { render json: @operating_system }
      end
    else
     respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @operating_system.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @operating_system = OperatingSystem.find(params[:id])

    if @operating_system.update(operating_system_params)
      redirect_to @operating_system
    else
      render 'edit'
    end
  end

  def destroy
    @operating_system = OperatingSystem.find(params[:id])
    @operating_system.destroy

    redirect_to operating_system_path
  end

  private

  def operating_system_params
    params.require(:operating_system).permit(:name)
  end

end
