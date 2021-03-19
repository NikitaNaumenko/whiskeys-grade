# frozen_string_literal: true

class Web::WhiskyBrandsController < Web::ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @whisky_brands = Whisky::Brand.order(id: :desc)
  end

  def show
    @whisky_brand = Whisky::Brand.find(params[:id])
  end

  def new
    authorize Whisky::Brand

    @whisky_brand = Whisky::Brand.new
  end

  def create
    authorize Whisky::Brand

    @whisky_brand = Whisky::Brand.new(permitted_params)

    if @whisky_brand.save
      f(:success)

      redirect_to whisky_brand_path(@whisky_brand)
    else
      render :new
    end
  end

  def update
    @whisky_brand = Whisky::Brand.find(params[:id])

    authorize @whisky_brand

    @whisky_brand.assign_attributes(permitted_params)
    if @whisky_brand.save
      f(:success)

      redirect_to whisky_brand_path(@whisky_brand)
    else
      render :edit
    end
  end

  def edit
    @whisky_brand = Whisky::Brand.find(params[:id])
    authorize @whisky_brand
  end

  def destroy
    brand = Whisky::Brand.find(params[:id])
    authorize brand

    if brand.destroy
      f(:success)

      redirect_to whisky_brands_path
    else
      f(:failure)

      redirect_to whisky_brand_path(brand)
    end
  end

  private

  def permitted_params
    params.require(:whisky_brand).permit(:name, :description, :country)
  end
end
