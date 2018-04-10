class SoftwareAppsController < ApplicationController
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }

  respond_to :html, :json

  def index
    @software_apps = SoftwareApp.all
    respond_with(@software_apps)
  end

  def show
    @software_app = SoftwareApp.find(params[:id])
    respond_with(@software_app)
  end

  def new
    @software_app = SoftwareApp.new
    respond_with(@software_app)
  end

  def edit
    @software_app = SoftwareApp.find(params[:id])
    respond_with(@software_app)
  end

  def create
    reject_empty_roles

    @software_app = SoftwareApp.new(software_app_params)

    if @software_app.save
     respond_to do |format|
        format.html { redirect_to @software_app }
        format.json { render json: @software_app }
      end
    else
     respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @software_app.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @software_app = SoftwareApp.find(params[:id])

    if @software_app.update(software_app_params)
      redirect_to @software_app
    else
      render 'edit'
    end
  end

  def destroy
    @software_app = SoftwareApp.find(params[:id])
    @software_app.destroy

    redirect_to software_app_path
  end

  private

  def software_app_params
    params.require(:software_app).permit(
      :name, roles: []
    )
    params.require(:software_app).permit!
  end

  def reject_empty_roles
    params[:software_app][:roles].delete_if(&:empty?)
    params[:software_app][:roles].map! {|p| p = Role.find(p)}
  end

end
