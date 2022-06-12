# frozen_string_literal: true

# This class is for the turnos controller
class TurnosController < ApplicationController
  #### CREATE
  def new
    @turno = Turno.new
  end

  def create
    @turnos_params = turno_params_create
    hora = @turnos_params['hora_salida(4i)']
    minuto = @turnos_params['hora_salida(5i)']
    horario = "#{hora}:#{minuto}"
    @turno = Turno.create(turno_params_create)
    @turno.estado = 'ACTIVO'
    @turno.hora_salida = horario
    @turno.user = current_user
    if @turno.save
      redirect_to turnos_index_path(tipo: 2), notice: 'Turno creado exitosamente'
    else
      @turno.hora_salida = nil
      render action: 'new', notice: 'Error al crear turno'
    end
  end

  #### READ
  def index
    @turnos = Turno.all
    @turno = 'form'
    @users = User.all
    @requests = Request.all
    @tipo_index = params[:tipo]
    @tipo_lista = params[:tipo_lista]
    @filtrar = params[:filtro] if params[:filtro].present?
    if params[:form].present?
      if params[:form][:conductor].present?
        lista_turno_id = []
        @users.each do |user|
          next unless (user.name).include?(params[:form][:conductor]) || (params[:form][:conductor]).include?(user.name)

          @turnos.each do |turno|
            lista_turno_id.append(turno.id) if turno.user_id == user.id
          end
        end
        @turnos = @turnos.where(id: lista_turno_id)
      end
      if params[:form][:direccion_salida].present?
        turnos_id = []
        @turnos.each do |turno|
          condicion1 = (turno.direccion_salida.downcase).include?(params[:form][:direccion_salida].downcase)
          condicion2 = (params[:form][:direccion_salida].downcase).include?(turno.direccion_salida.downcase)
          turnos_id.append(turno.id) if condicion1 || condicion2
        end
        @turnos = @turnos.where(id: turnos_id)
      end
      if params[:form][:direccion_llegada].present?
        turnos_id = []
        @turnos.each do |turno|
          condicion1 = (turno.direccion_llegada.downcase).include?(params[:form][:direccion_llegada].downcase)
          condicion2 = (params[:form][:direccion_llegada].downcase).include?(turno.direccion_llegada.downcase)
          turnos_id.append(turno.id) if condicion1 || condicion2
        end
        @turnos = @turnos.where(id: turnos_id)
      end
      @turnos = @turnos.where(dia_semana: params[:form][:dia_semana]) if params[:form][:dia_semana].present?
      @turnos = @turnos.where(tipo: params[:form][:tipo_turno]) if params[:form][:tipo_turno].present?
      if params[:form]['hora_salida_min(4i)'].present? && params[:form]['hora_salida_max(4i)'].present?
        turnos_id = []
        hora_min = params[:form]['hora_salida_min(4i)']
        minuto_min = params[:form]['hora_salida_min(5i)']
        hora_max = params[:form]['hora_salida_max(4i)']
        minuto_max = params[:form]['hora_salida_max(5i)']
        @turnos.each do |turno|
          lista = turno.hora_salida.split(':')
          if (lista[0].to_i > hora_min.to_i) && (lista[0].to_i < hora_max.to_i)
            turnos_id.append(turno.id)
          elsif (lista[0].to_i == hora_min.to_i) && (lista[0].to_i < hora_max.to_i)
            turnos_id.append(turno.id) if lista[1].to_i >= minuto_min.to_i
          elsif (lista[0].to_i > hora_min.to_i) && (lista[0].to_i == hora_max.to_i)
            turnos_id.append(turno.id) if lista[1].to_i <= minuto_max.to_i
          elsif (lista[0].to_i == hora_min.to_i) && (lista[0].to_i == hora_max.to_i)
            turnos_id.append(turno.id) if (lista[1].to_i >= minuto_min.to_i) && (lista[1].to_i <= minuto_max.to_i)
          end
        end
        @turnos = @turnos.where(id: turnos_id)
      end
      @tipo_index = params[:form][:tipo] if params[:form][:tipo].present?
      @tipo_lista = params[:form][:tipo_lista] if params[:form][:tipo_lista].present?
      @filtrar = params[:filtro] if params[:form][:filtro].present?
    end
  end

  def show
    @turno = Turno.find(params[:id])
    @requests = Request.all
    @resenas = @turno.resenas.all
    @condicion = true
    @requests.each do |solicitud|
      if (solicitud.user_id.to_i == current_user.id.to_i) && (solicitud.turno_id.to_i == params[:id].to_i)
        @condicion = false
      end
    end
  end

  #### UPDATE
  def edit
    @turno = Turno.find(params[:id])
    @turno.hora_salida = nil
  end

  def update
    @turno = Turno.find(params[:id])
    @parametros = turno_params_update
    hora = @parametros['hora_salida(4i)']
    minuto = @parametros['hora_salida(5i)']
    horario = { 'hora_salida' => "#{hora}:#{minuto}" }
    @parametros.merge!(horario)
    @parametros.delete('hora_salida(1i)')
    @parametros.delete('hora_salida(2i)')
    @parametros.delete('hora_salida(3i)')
    @parametros.delete('hora_salida(4i)')
    @parametros.delete('hora_salida(5i)')
    if @parametros['cantidad_asientos'] == '0'
      parametro_estado = { 'estado' => 'CONFIRMADO' }
      @parametros.delete('estado')
      @parametros.merge!(parametro_estado)
    end
    if @turno.update(@parametros)
      redirect_to turnos_index_path(tipo: 2), notice: 'Turno editado exitosamente'
    else
      @turno.hora_salida = nil
      render action: 'edit', notice: 'Error al crear turno'
    end
  end

  #### DELETE
  def delete
    @turno = Turno.find(params[:id])
    @turno.destroy

    redirect_to turnos_index_path, notice: 'Turno eliminado'
  end

  #### FILTRO
  def search
  end

  private

  def turno_params_create
    params.require(:turno).permit(:cantidad_asientos, :hora_salida, :direccion_salida,
                                  :direccion_llegada, :dia_semana, :tipo, :espacio)
  end

  def turno_params_update
    params.require(:turno).permit(:cantidad_asientos, :hora_salida,
                                  :direccion_salida, :direccion_llegada, :dia_semana, :tipo, :estado, :espacio)
  end
end
