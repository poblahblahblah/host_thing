class NodesController < ApplicationController
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }

  respond_to :html, :json

  def index
    @nodes = Node.all
    respond_with(@nodes)
  end

  def show
    @node = Node.find(params[:id])
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

    ensure_status
    ensure_operating_system
    ensure_datacenter
    ensure_role

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
      :name, :status, :status_id, :fqdn, :serial, :role, :role_id,
      :datacenter, :datacenter_id, :operating_system, :operating_system_id,
      :internal_ip_address, :management_ip_address
    )
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

  def ensure_role
    if !params[:node].include?(:role_id)
      role = nil
      if params.include?(:role)
        role = Role.find_by(name: params[:role].to_s)
      end
      params[:node][:role_id] = role.id
    end
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


end