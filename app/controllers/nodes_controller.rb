class NodesController < ApplicationController
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }

  respond_to :html, :json

  def index
    @nodes = Node.all
    respond_with(@nodes)
  end

  def show
    @node = Node.friendly.find(params[:id])
    respond_with(@node)
  end

  def new
    @node = Node.new
    respond_with(@node)
  end

  def edit
    @node = Node.find(params[:id])
    respond_with(@node)
  end

  def create
    reject_empty_roles

    ensure_status
    ensure_operating_system
    ensure_datacenter

    @node = Node.new(node_params)

    if @node.save
     respond_to do |format|
        format.html { redirect_to @node }
        format.json { render json: @node }
      end
    else
     respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    reject_empty_roles

    ensure_status
    ensure_operating_system
    ensure_datacenter

    @node = Node.find(params[:id])
   
    if @node.update(node_params)
      redirect_to @node
    else
      render 'edit'
    end
  end

  def destroy
    @node = Node.find(params[:id])
    @node.destroy
   
    redirect_to nodes_path
  end

  private

  def node_params
    params.require(:node).permit(
      :name, :fqdn, :serial, :datacenter, :datacenter_id, :status, :status_id,
      :operating_system, :operating_system_id,
      interface_attributes: [mac_attributes: [:address, ip_addrs_attributes: [:address]]],
      roles: []
    )
    params.require(:node).permit!
  end

  def ensure_status
    if !params[:node].key?(:status_id)
      status = nil
      if params[:node].key?(:status) && !params[:node][:status].blank?
        status = Status.find_or_create_by(name: params[:node][:status].to_s)
      else
        status = Status.find_or_create_by(name: 'setup')
      end
      params[:node][:status_id] = status.id unless status.nil?
    end
  end

  def ensure_datacenter
    if !params[:node].key?(:datacenter_id)
      datacenter = nil
      if params[:node].key?(:datacenter)
        datacenter = Datacenter.find_by(name: params[:node][:datacenter].to_s)
      end
      params[:node][:datacenter_id] = datacenter.id unless datacenter.nil?
    end
  end

  def ensure_operating_system
    if !params[:node].key?(:operating_system_id)
      operating_system = nil
      if params[:node].key?(:operating_system) and !params[:node][:operating_system].blank?
        operating_system = OperatingSystem.find_or_create_by(name: params[:node][:operating_system].to_s)
      else
        operating_system = OperatingSystem.find_or_create_by(name: 'Unknown Operating System')
      end
      params[:node][:operating_system_id] = operating_system.id
    end
  end

  def reject_empty_roles
    if params[:node].key?(:roles)
      params[:node][:roles].delete_if(&:empty?)
      params[:node][:roles].map! {|p| p = Role.find(p)}
    end
  end

end
