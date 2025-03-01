class ReembolsosController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @reembolsos = current_user.reembolsos
      render json: @reembolsos, status: :ok
    end
  
    def show
      @reembolso = current_user.reembolsos.find(params[:id])
      render json: @reembolso, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Reembolso não encontrado" }, status: :not_found
    end
  
    def create
      @reembolso = current_user.reembolsos.new(reembolso_params)
      if @reembolso.save
        render json: @reembolso, status: :created
      else
        render json: { errors: @reembolso.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      @reembolso = current_user.reembolsos.find(params[:id])
      if @reembolso.update(reembolso_params)
        render json: @reembolso, status: :ok
      else
        render json: { errors: @reembolso.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Reembolso não encontrado" }, status: :not_found
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
  