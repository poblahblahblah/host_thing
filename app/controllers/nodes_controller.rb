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
    reject_empty_interfaces

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
    reject_empty_interfaces

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
      :name, :status_id, :fqdn, :serial, :datacenter_id, :operating_system_id,
      :interfaces, roles: []
    )
    params.require(:node).permit!
  end

  def ensure_status
    if !params[:node].include?(:status_id)
      status = nil
      if params.include?(:status) and !params[:status].blank?
        status = Status.find_or_create_by(name: params[:status].to_s)
      else
        status = Status.find_or_create_by(name: 'setup')
      end
      params[:node][:status_id] = status.id
    end
  end

  def ensure_datacenter
    if !params[:node].include?(:datacenter_id)
      datacenter = nil
      if params.include?(:datacenter)
        datacenter = Datacenter.find_by(name: params[:datacenter].to_s)
      end
      params[:node][:datacenter_id] = datacenter.id
    end
  end

  def ensure_interfaces
    #if !params[:node].key?(:interfaces) && !params[:node][:interfaces].empty?
      interface_ids = []
      # FIXME(pob): We will want to automatically create multiple interfaces when getting a POST/PUT
      # interfaces should have a single mac address
      # mac addresses should have 0-many IP addresses
      #params[:node][:interfaces].each do |interface|
      #  interface_ids << Interface.find_or_create_by(
      #    name: interface[:name],
      #    mac: interface[:mac],
      #    ips: interface[:ips]
      #  )
      #end
      #params[:node][:interface_ids] = interface_ids
    #end
  end

  def ensure_operating_system
    if !params[:node].include?(:operating_system_id)
      operating_system = nil
      if params.include?(:operating_system) and !params[:operating_system].blank?
        operating_system = OperatingSystem.find_or_create_by(name: params[:operating_system].to_s)
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

  def reject_empty_interfaces
    if params[:node].key?(:interfaces)
      params[:node][:interfaces].delete_if(&:empty?)
      params[:node][:interfaces].map! {|p| p = Interface.find(p)}
    end
  end

end
