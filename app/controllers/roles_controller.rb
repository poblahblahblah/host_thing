class RolesController < ApplicationController
  respond_to :html, :json

  def index
    @roles = Role.all
    respond_with(@roles)
  end

  def show
    @role = Role.find(params[:id])
    respond_with(@role)
  end

  def new
    @role = Role.new
    respond_with(@role)
  end

  def edit
    @role = Role.find(params[:id])
    respond_with(@role)
  end

  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to @role
    else
      render 'new'
    end
  end

  def update
    @role = Role.find(params[:id])

    if @role.update(role_params)
      redirect_to @role
    else
      render 'edit'
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy

    redirect_to role_path
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

end
