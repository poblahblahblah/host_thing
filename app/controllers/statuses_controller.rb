class StatusesController < ApplicationController
  # disable the need for AuthenticityToken if JSON
  protect_from_forgery unless: -> { request.format.json? }

  respond_to :html, :json

  def index
    @statuses = Status.all
    respond_with(@statuses)
  end

  def show
    @status = Status.find(params[:id])
    respond_with(@status)
  end

  def new
    @status = Status.new
    respond_with(@status)
  end

  def edit
    @status = Status.find(params[:id])
    respond_with(@status)
  end

  def create
    @status = Status.new(status_params)

    if @status.save
     respond_to do |format|
        format.html { redirect_to @status }
        format.json { render json: @status }
      end
    else
     respond_to do |format|
        format.html { render 'new' }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @status = Status.find(params[:id])

    if @status.update(status_params)
      redirect_to @status
    else
      render 'edit'
    end
  end

  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    redirect_to status_path
  end

  private

  def status_params
    params.require(:status).permit(:name)
  end

end
