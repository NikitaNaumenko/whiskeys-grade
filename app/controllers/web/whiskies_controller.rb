# frozen_string_literal: true

class Web::WhiskiesController < Web::ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @whiskies = Whisky.includes(:brand).order(id: :desc)
  end

  def show
    @whisky = Whisky.find(params[:id])
  end

  def new
    authorize Whisky

    @whisky = Whisky.new
  end

  def create
    authorize Whisky

    brand = Whisky::Brand.find(permitted_params[:brand_id])
    whisky = brand.whiskies.new(permitted_params)

    if whisky.save
      f(:success)

      redirect_to whisky_path(whisky)
    else
      render :new
    end
  end

  def update
    whisky = Whisky.find(params[:id])

    authorize whisky

    whisky.assign_attributes(permitted_params)
    if whisky.save
      f(:success)

      redirect_to whisky_path(whisky)
    else
      render :edit
    end
  end

  def edit
    @whisky = Whisky.find(params[:id])
    authorize @whisky
  end

  def destroy
    whisky = Whisky.find(params[:id])
    authorize whisky

    if whisky.destroy
      f(:success)

      redirect_to whiskies_path
    else
      f(:failure)

      redirect_to whisky_path(whisky)
    end
  end

  private

  def permitted_params
    params.require(:whisky).permit(:title, :description, :brand_id)
  end
end
