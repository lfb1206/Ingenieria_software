# frozen_string_literal: true

# This class is for the requests controller
class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @requests_params = params.require(:request).permit(:id_solicitud, :id_usuario, :id_publicacion, :estado,
                                                       :descripcion)
    @request = Request.create(@requests_params)
    if @request.save
      redirect_to requests_index_path, notice: 'Request creado exitosamente'
    else
      redirect_to requests_index_path, notice: 'Error al crear request'
    end
  end

  #### READ
  def index
    @requests = Request.all
  end

  def show
    @request = Request.find(params[:id])
  end

  #### UPDATE
  def edit
    @request = Request.find(params[:id])
  end

  def update
    @request = Request.find(params[:id])
    @requests_params = params.require(:request).permit(:id_solicitud, :id_usuario, :id_publicacion, :estado,
                                                       :descripcion)
    if @request.update(@requests_params)
      redirect_to requests_index_path, notice: 'Request editado exitosamente'
    else
      redirect_to requests_index_path, notice: 'Error al editar request'
    end
  end

  #### DELETE
  def delete
    @request = Request.find(params[:id])
    @request.destroy

    redirect_to requests_index_path, notice: 'Request eliminado'
  end
end
