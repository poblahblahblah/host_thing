class DatacentersController < ApplicationController
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }

  respond_to :html, :json

  def index
    @datacenters = Datacenter.all
    respond_with(@datacenters)
  end

  def show
    @datacenter = Datacenter.friendly.find(params[:id])
    respond_with(@datacenter)
  end

  def new
    @datacenter = Datacenter.new
    respond_with(@datacenter)
  end

  def edit
    @datacenter = Datacenter.find(params[:id])
    respond_with(@datacenter)
  end

  def create
    @datacenter = Datacenter.new(datacenter_params)

    if @datacenter.save
     respond_to do |format|
        format.html { redirect_to @datacenter }
        format.json { render json: @datacenter }
      end
    else
     respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @datacenter.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @datacenter = Datacenter.find(params[:id])

    if @datacenter.update(datacenter_params)
      redirect_to @datacenter
    else
      render 'edit'
    end
  end

  def destroy
    @datacenter = Datacenter.find(params[:id])
    @datacenter.destroy

    redirect_to datacenter_path
  end

  private

  def datacenter_params
    params.require(:datacenter).permit(:name, :vendor, :provider)
  end

end
