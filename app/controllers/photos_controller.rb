class PhotosController < ApplicationController
  include ResourceDependencies
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  add_breadcrumb :index

  def index
    @photos = @resource.photos.all
    respond_with(@photos)
  end

  def show
    respond_with(@photo)
  end

  def new
    @photo = @resource.photos.build
    respond_with(@photo)
  end

  def edit
  end

  def create
    @photo = @resource.photos.build(photo_params)
    @photo.save
    @resource.photos<<@photo
    respond_with(@resource, @photo)
  end

  def update
    @photo.update(photo_params)
    respond_with(@photo)
  end

  def destroy
    @photo.destroy
    # respond_with(@resource, @photo)
    respond_with(@resource, location: edit_contact_path(@resource))
  end

  private
    def set_photo
      @photo = @resource.photos.find(params[:id])
    end
    def photo_params
      params.require(:photo).permit(:file, :main)
    end
end
