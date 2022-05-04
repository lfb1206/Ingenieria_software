# frozen_string_literal: true

# This class is for the requests controller
class RequestsController < ApplicationController
  def new
    @request = Request.new
    @turno = Turno.find(params[:id])
  end

  def create
    @requests_params = params.require(:request).permit(:id_turno, :id_usuario_turno, :descripcion)
    @requests_params.merge!(:id_publicacion => params["id_turno"])
    @requests_params.merge!(:id_usuario => params["id_usuario_turno"])
    @requests_params.merge!(:estado => "PENDIENTE")
    @requests_params.merge!(:id_usuario_solicitud => current_user.id)
    puts @requests_params
    @request = Request.create(@requests_params)
    if @request.id_usuario == current_user.id
      if @request.update(@requests_params)
        redirect_to users_show_path, notice: 'Solicitud enviada exitosamente'
      else
        redirect_to users_show_path, notice: 'Error al enviar solicitud'
      end
    elsif @request.id_usuario_solicitud == current_user.id
      if @request.update(@requests_params)
        redirect_to turnos_index_path, notice: 'Solicitud enviada exitosamente'
      else
        redirect_to turnos_index_path, notice: 'Error al enviar solicitud'
      end
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
    @requests_params = params.require(:request).permit(:estado, :descripcion)
    if @request.id_usuario == current_user.id
      if @request.update(@requests_params)
        redirect_to users_show_path, notice: 'Solicitud editada exitosamente'
      else
        redirect_to users_show_path, notice: 'Error al editar solicitud'
      end
    elsif @request.id_usuario_solicitud == current_user.id
      if @request.update(@requests_params)
        redirect_to turnos_index_path, notice: 'Solicitud editada exitosamente'
      else
        redirect_to turnos_index_path, notice: 'Error al editar solicitud'
      end
    end
  end

  #### DELETE
  def delete
    @request = Request.find(params[:id])
    @request.destroy

    redirect_to requests_index_path, notice: 'Request eliminado'
  end
end
