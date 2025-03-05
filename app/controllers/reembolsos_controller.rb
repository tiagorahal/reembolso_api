class ReembolsosController < ApplicationController
    before_action :authenticate_user!

    def index
      @reembolsos = current_user.reembolsos.includes(:tags)
      render json: @reembolsos.as_json(include: :tags), status: :ok
    end    

    def show
      @reembolso = current_user.reembolsos.find(params[:id])
      render json: @reembolso, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Reembolso não encontrado" }, status: :not_found
    end

    def create
      @reembolso = current_user.reembolsos.new(reembolso_params.except(:tag_ids))
    
      if @reembolso.save
        tag_names = params[:reembolso][:tag_ids] || []
        tags = tag_names.map { |tag_name| Tag.find_or_create_by(nome: tag_name.strip) }
        @reembolso.tags = tags
    
        render json: @reembolso.as_json(include: :tags), status: :created
      else
        render json: { errors: @reembolso.errors.full_messages }, status: :unprocessable_entity
      end
    end    
    
    def update
      @reembolso = current_user.reembolsos.find(params[:id])
    
      if @reembolso.update(reembolso_params.except(:tag_ids))
        tag_names = params[:reembolso][:tag_ids] || []
        tags = tag_names.map { |tag_name| Tag.find_or_create_by(nome: tag_name.strip) }
        @reembolso.tags = tags
    
        render json: @reembolso, status: :ok
      else
        render json: { errors: @reembolso.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @reembolso = current_user.reembolsos.find(params[:id])
      @reembolso.destroy
      render json: { message: "Reembolso deletado com sucesso" }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Reembolso não encontrado" }, status: :not_found
    end

    private

    def reembolso_params
      params.require(:reembolso).permit(:descricao, :valor, :data, tag_ids: [])
    end
end
