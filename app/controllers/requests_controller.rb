# frozen_string_literal: true

# This class is for the requests controller
class RequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @turno_id = params[:id_viaje]
    @request = Request.new
  end

  def create
    request_params_create[:turno] = Turno.find(params[:request][:turno_id].to_i)
    @request = Request.new(request_params_create)
    @request.estado = 'PENDIENTE'
    @request.user = current_user
    if @request.save
      redirect_to requests_index_path, notice: 'Solicitud enviada exitosamente'
    else
      @turno_id = params[:request][:turno_id].to_i
      render action: 'new', notice: 'Error al crear solicitud'
    end
  end

  #### READ
  def index
    @requests = Request.all
    @tipo_index = params[:tipo]
    @tipo_lista = params[:tipo_lista]
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
    if request_params_update.key?('descripcion')
      if @request.update(request_params_update)
        redirect_to requests_index_path, notice: 'Solicitud editada exitosamente'
      else
        redirect_to requests_index_path, notice: 'Error al editar solicitud'
      end
    elsif request_params_update.key?('estado')
      if @request.update(request_params_update)
        redirect_to requests_index_path, notice: 'Solicitud editada exitosamente'
      else
        render action: 'edit', notice: 'Error al editar solicitud'
      end
    end
  end

  #### DELETE
  def delete
    @request = Request.find(params[:id])
    @request.destroy

    redirect_to requests_index_path, notice: 'Request eliminado'
  end

  private

  def request_params_create
    params.require(:request).permit(:descripcion, :turno_id)
  end

  def request_params_update
    params.require(:request).permit(:estado, :descripcion)
  end
end
