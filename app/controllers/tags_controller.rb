class TagsController < ApplicationController
    before_action :authenticate_user!

    def index
      render json: Tag.all, status: :ok
    end

    def create
      @tag = Tag.new(tag_params)
      if @tag.save
        render json: @tag, status: :created
      else
        render json: { errors: @tag.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def tag_params
      params.require(:tag).permit(:nome)
    end
end
