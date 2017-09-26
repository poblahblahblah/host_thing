class NodesController < ApplicationController
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
    @node = Node.new(node_params)

    ensure_status

    if @node.save
      redirect_to @node
    else
      render 'new'
    end

  end

  def update
    @node = Node.find(params[:id])

    ensure_status
   
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
      :name, :status_id, :fqdn, :serial, :operating_system_id, :role_id,
      :datacenter_id, :internal_ip_address, :management_ip_address
    )
  end

  def ensure_status
    if !params[:node].include?(:status_id)
      status = nil
      if params.include?(:status) and !params[:status][:name].blank?
        status = Status.find_or_create_by(name: params[:status][:name].to_s)
      else
        status = Status.find_or_create_by(name: 'setup')
      end
      params[:node][:status_id] = status.id
    end
  end

  def ensure_operating_system
    if !params[:node].include?(:operating_system_id)
      operating_system = nil
      if params.include?(:operating_system) and !params[:operating_system][:name].blank?
        operating_system = OperatingSystem.find_or_create_by(name: params[:operating_system][:name].to_s)
      else
        operating_system = OperatingSystem.find_or_create_by(name: 'Unknown Operating System')
      end
      params[:node][:operating_system_id] = operating_system.id
    end
  end

end
