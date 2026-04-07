class ServicesController < ApplicationController
  before_action :set_service, only: %i[show edit update destroy add_tag remove_tag]
  skip_before_action :authenticate_user!, only: :show
  before_action :authenticate_user!, only: %i[new create edit update destroy add_tag remove_tag]

  def index
    @tags = Tag.order(:name)

    if params[:mine].present? && user_signed_in?
      @my_services = true
      @services = current_user.services.includes(:tags)
    else
      @services = Service.by_approved_providers.includes(:user, :tags)
    end

    if params[:tag_id].present?
      @services = @services.search_by_tag(params[:tag_id])
      @selected_tag = Tag.find_by(id: params[:tag_id])
    end

    if params[:q].present?
      @services = @services.search_by_text(params[:q])
    end

    @services = @services.order(:title)
  end

  def show
    @quote = Quote.new
  end

  def new
    authorize Service
    @service = current_user.services.build
    @tags = Tag.order(:name)
  end

  def edit
    authorize @service
    @tags = Tag.order(:name)
  end

  def create
    authorize Service
    @service = current_user.services.build(service_params)

    if @service.save
      redirect_to @service, notice: "Service was successfully created."
    else
      @tags = Tag.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @service
    if @service.update(service_params)
      redirect_to @service, notice: "Service was successfully updated.", status: :see_other
    else
      @tags = Tag.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @service
    @service.destroy!
    redirect_to services_path, notice: "Service was successfully deleted.", status: :see_other
  end

  def add_tag
    authorize @service
    tag = Tag.find(params[:tag_id])
    @service.tags << tag unless @service.tags.include?(tag)
    redirect_to edit_service_path(@service), notice: "Tag added."
  end

  def remove_tag
    authorize @service
    tag = Tag.find(params[:tag_id])
    @service.tags.delete(tag)
    redirect_to edit_service_path(@service), notice: "Tag removed."
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:title, :description, images: [])
  end
end
