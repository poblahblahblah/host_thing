class IpAddrsController < ApplicationController
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }

  respond_to :html, :json

  def index
    @ip_addrs = IpAddr.all
    respond_with(@ip_addrs)
  end

  def show
    @ip_addr = IpAddr.find(params[:id])
    respond_with(@ip_addr)
  end

  def new
    @ip_addr = IpAddr.new
    respond_with(@ip_addr)
  end

  def edit
    @ip_addr = IpAddr.find(params[:id])
    respond_with(@ip_addr)
  end

  def create
    @ip_addr = IpAddr.new(ip_addr_params)

    if @ip_addr.save
     respond_to do |format|
        format.html { redirect_to @ip_addr }
        format.json { render json: @ip_addr }
      end
    else
     respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @ip_addr.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ip_addr = IpAddr.find(params[:id])

    if @ip_addr.update(ip_addr_params)
      redirect_to @ip_addr
    else
      render 'edit'
    end
  end

  def destroy
    @ip_addr = IpAddr.find(params[:id])
    @ip_addr.destroy

    redirect_to ip_addr_path
  end

  private

  def ip_addr_params
    params.require(:ip_addr).permit(
      :address
    )
    params.require(:ip_addr).permit!
  end

end
