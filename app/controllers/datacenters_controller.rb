class DatacentersController < ApplicationController
  respond_to :html, :json

  def index
    @datacenters = Datacenter.all
    respond_with(@datacenters)
  end

  def show
    @datacenter = Datacenter.find(params[:id])
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
      redirect_to @datacenter
    else
      render 'new'
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
