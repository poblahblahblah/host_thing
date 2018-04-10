class RolesController < ApplicationController
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }

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
    reject_empty_applications

    @role = Role.new(role_params)

    if @role.save
     respond_to do |format|
        format.html { redirect_to @role }
        format.json { render json: @role }
      end
    else
     respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
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
    params.require(:role).permit(:name, :software_apps)
  end

  def reject_empty_roles
    params[:node][:roles].delete_if(&:empty?)
    params[:node][:roles].map! {|p| p = Role.find(p)}
  end

end
