class Api::ShoesController < ApplicationController
  before_action :set_shoe, only: [:show, :update, :destroy]

  def index
    @shoes = Shoe.all
    render json: ShoeSerializer.new(@shoes)
  end

  def show
    render json: ShoeSerializer.new(@shoe)
  end

  def create
    @shoe = Shoe.new(shoe_params_jsonapi)
    if @shoe.save
      render json: ShoeSerializer.new(@shoe), status: :created, location: api_brand_shoe_url(@shoe.brand, @shoe)
    else
      render status: :unprocessable_entity
    end
  end

  def update
    if @shoe.update(shoe_params_jsonapi)
      render json: ShoeSerializer.new(@shoe)
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    @shoe.destroy
  end

  private
    def set_shoe
      @shoe = Shoe.find(params[:id])
    end

    def shoe_params_jsonapi
      restify_param(:shoe).require(:shoe).permit(:brand_id, :name, :color, :year)
    end
end
