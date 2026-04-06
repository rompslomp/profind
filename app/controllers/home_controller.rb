class HomeController < ApplicationController
  def index
    @tags = Tag.order(:name)
    @featured_services = Service.by_approved_providers.includes(:user, :tags).order(:title).limit(6)
  end
end
