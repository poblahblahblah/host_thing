class InterfacesController < ApplicationController
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }

  respond_to :html, :json

  def index
    @interfaces = Interface.all
    respond_with(@interfaces)
  end

  def show
    @interface = Interface.find(params[:id])
    respond_with(@interface)
  end

  def new
    @interface = Interface.new
    respond_with(@interface)
  end

  def edit
    @interface = Interface.find(params[:id])
    respond_with(@interface)
  end

  def create
    @interface = Interface.new(interface_params)

    if @interface.save
     respond_to do |format|
        format.json { render json: @interface }
      end
    else
     respond_to do |format|
        format.json { render json: @interface.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @interface = Interface.find(params[:id])

    if @interface.update(interface_params)
      redirect_to @interface
    else
      render 'edit'
    end
  end

  def destroy
    @interface = Interface.find(params[:id])
    @interface.destroy

    redirect_to interface_path
  end

  private

  def interface_params
    params.require(:interface).permit(
      :name, mac_attributes: [:address, ip_addrs_attributes: [:address]]
    )
  end

end
