# frozen_string_literal: true

# This class is for the requests mensajes
class MensajesController < ApplicationController
  #### CREATE
  def new
    mensajes = Mensaje.all.sort_by(&:created_at)
    turnos = Turno.all
    solicitudes = Request.all
    @turnos_usuario = []
    @mensajes_turnos = {}
    if Turno.any?
      @existen_turnos = true
      turnos.each do |turno|
        @turnos_usuario << turno if turno.user_id == current_user.id
        mensajes_turno = []
        existen_mensajes = false
        if Mensaje.any?
          mensajes.each do |mensaje|
            if mensaje.turno_id == turno.id
              mensajes_turno << mensaje
              existen_mensajes = true
            end
          end
        end
        @mensajes_turnos[turno.id] = { mensajes: mensajes_turno, existen: existen_mensajes }
      end
      if Request.any?
        solicitudes.each do |solicitud|
          if (solicitud.user_id == current_user.id) && (solicitud.estado == 'ACEPTADO')
            @turnos_usuario << Turno.find(solicitud.turno_id)
          end
        end
      end
      @mensaje = Mensaje.new
    else
      @existen_turnos = false
    end
    @turno_chat = params[:id_turno]
  end

  def create
    @mensajes_params = params.require(:mensaje).permit(:contenido, :turno_id, :user_id)
    @mensaje = Mensaje.create(@mensajes_params)
    @mensaje.user = current_user
    @mensaje.turno = Turno.find(@mensajes_params['turno_id'])
    if @mensaje.save
      redirect_to mensajes_path(id_turno: @mensajes_params['turno_id']), notice: 'Solicitud enviada exitosamente'
    else
      redirect_to mensajes_path(id_turno: @mensajes_params['turno_id']), notice: 'Error al crear mensaje'
    end
  end
end
