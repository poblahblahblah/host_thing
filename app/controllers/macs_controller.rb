class MacsController < ApplicationController
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }

  respond_to :html, :json

  def index
    @macs = Mac.all
    respond_with(@macs)
  end

  def show
    @mac = Mac.find(params[:id])
    respond_with(@mac)
  end

  def new
    @mac = Mac.new
    respond_with(@mac)
  end

  def edit
    @mac = Mac.find(params[:id])
    respond_with(@mac)
  end

  def create
    ensure_ip_addrs
    reject_empty_ips

    @mac = Mac.new(mac_params)

    if @mac.save
     respond_to do |format|
        format.json { render json: @mac }
      end
    else
     respond_to do |format|
        format.json { render json: @mac.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    ensure_ip_addrs
    reject_empty_ips

    @mac = Mac.find(params[:id])

    if @mac.update(mac_params)
      redirect_to @mac
    else
      render 'edit'
    end
  end

  def destroy
    @mac = Mac.find(params[:id])
    @mac.destroy

    redirect_to mac_path
  end

  private

  def mac_params
    params.require(:mac).permit(
      :address, ip_addrs: []
    )
    params.require(:mac).permit!
  end

  def ensure_ip_addrs
    ip_addresses = []
    if params.include?(:ip_addrs) and !params[:ip_addrs].empty?
      params[:ip_addrs].each do |ip_addr|
        ip_addresses << IpAddr.find_or_create_by(address: ip_addr)
      end
    end
    params[:ip_addrs] = ip_addresses
  end

  def reject_empty_ips
    if params[:mac].key?(:ip_addrs)
      params[:mac][:ip_addrs].delete_if(&:empty?)
      params[:mac][:ip_addrs].map! {|p| p = IpAddr.find(p)}
    end
  end

end
