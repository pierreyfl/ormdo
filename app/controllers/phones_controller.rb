class PhonesController < ApplicationController
  include ResourceDependencies
  before_action :set_phone, only: [:show, :edit, :update, :destroy]

  def index
    @phones = @resource.phones.all
    respond_with(@phones)
  end

  def show
    respond_with(@phone)
  end

  def new
    @phone = @resource.phones.build
    @phone.area = @resource.region.ddd
    respond_with(@phone)
  end

  def edit
  end

  def create
    @phone = @resource.phones.build(phone_params)
    @phone.save
    respond_with(@resource, @phone)
  end

  def update
    @phone.update(phone_params)
    respond_with(@resource, @phone)
  end

  def destroy
    @phone.destroy
    respond_with(@resource, @phone)
  end

  private
    def set_phone
      @phone = @resource.phones.find(params[:id])
    end

    def phone_params
      params.require(:phone).permit(:area, :number, :priority, :description, :carrier)
    end
end
