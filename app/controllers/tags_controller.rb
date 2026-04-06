class TagsController < ApplicationController
  before_action :set_tag, only: %i[show]

  def index
    @tags = Tag.order(:name)
  end

  def show
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
