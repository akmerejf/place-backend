class PicturesController < ApplicationController
	before_action :authenticate_user!, only: [:create, :update, :destroy]
	before_action :set_picture, only: [:show]


	def index
		@pictures = Picture.all
		@pictures_count = @pictures.count
	end
  def create
    @picture = Picture.new(picture_params)

    if @picture.save
      # render :show
    else
      render json: { errors: @picture.errors }, status: :unprocessable_entity
    end
  end

  def show
    @picture = Picture.find_by!(slug: params[:slug])	
  end

  def update
    @picture = Picture.find(picture_params)

    if @picture.save
      render json: @picture, status: :created, picture: @picture
    else
      render json: @picture.errors, status: :unprocessable_entity
    end

  end

  def destroy
    @picture.destroy
  end

  private

  def set_picture
    @picture = Picture.find_by!(params[:image])
  end


  def picture_params
    params.require(:picture).permit(:image)
  end
end
