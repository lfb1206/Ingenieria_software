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
    @turno = "form"
    @users = User.all
    @requests = Request.all
    @tipo_index = params[:tipo]
    @tipo_lista = params[:tipo_lista]
    if params[:filtro].present?
      @filtrar = params[:filtro]
    end
    if params[:form].present?
      if params[:form][:conductor].present?
        lista_turno_id = []
        @users.each do |user|
          if (user.name).include?(params[:form][:conductor]) or (params[:form][:conductor]).include?(user.name)
            @turnos.each do |turno|
              if turno.user_id == user.id
                lista_turno_id.append(turno.id)
              end
            end
          end
        end
        @turnos = @turnos.where(id: lista_turno_id)
      end
      if params[:form][:direccion_salida].present?
        turnos_id = []
        @turnos.each do |turno|
          if (turno.direccion_salida.downcase).include?(params[:form][:direccion_salida].downcase) or (params[:form][:direccion_salida].downcase).include?(turno.direccion_salida.downcase)
            turnos_id.append(turno.id)
          end
        end
        @turnos = @turnos.where(id: turnos_id)
      end
      if params[:form][:direccion_llegada].present?
        turnos_id = []
        @turnos.each do |turno|
          if (turno.direccion_llegada.downcase).include?(params[:form][:direccion_llegada].downcase) or (params[:form][:direccion_llegada].downcase).include?(turno.direccion_llegada.downcase)
            turnos_id.append(turno.id)
          end
        end
        @turnos = @turnos.where(id: turnos_id)
      end
      if params[:form][:direccion_salida].present?
        puts params[:form][:direccion_salida]
      end
      if params[:form][:direccion_llegada].present?
        puts params[:form][:direccion_llegada]
      end
      if params[:form][:dia_semana].present?
        @turnos = @turnos.where(dia_semana: params[:form][:dia_semana])
      end
      if params[:form][:tipo_turno].present?
        @turnos = @turnos.where(tipo: params[:form][:tipo_turno])
      end
      if params[:form]["hora_salida_min(4i)"].present? and params[:form]["hora_salida_max(4i)"].present?
        turnos_id = []
        hora_min = params[:form]["hora_salida_min(4i)"]
        minuto_min = params[:form]["hora_salida_min(5i)"]
        hora_max = params[:form]["hora_salida_max(4i)"]
        minuto_max = params[:form]["hora_salida_max(5i)"]
        @turnos.each do |turno|
          lista = turno.hora_salida.split(":")
          if lista[0].to_i > hora_min.to_i and lista[0].to_i < hora_max.to_i
            turnos_id.append(turno.id)
          elsif lista[0].to_i == hora_min.to_i and lista[0].to_i < hora_max.to_i
            if lista[1].to_i >= minuto_min.to_i
              turnos_id.append(turno.id)
            end
          elsif lista[0].to_i > hora_min.to_i and lista[0].to_i == hora_max.to_i
            if lista[1].to_i <= minuto_max.to_i
              turnos_id.append(turno.id)
            end
          elsif lista[0].to_i == hora_min.to_i and lista[0].to_i == hora_max.to_i
            if lista[1].to_i >= minuto_min.to_i and lista[1].to_i <= minuto_max.to_i
              turnos_id.append(turno.id)
            end
          end
        end
        @turnos = @turnos.where(id: turnos_id)
      end 
      if params[:form][:tipo].present?
        @tipo_index = params[:form][:tipo]
      end
      if params[:form][:tipo_lista].present?
        @tipo_lista = params[:form][:tipo_lista]
      end
      if params[:form][:filtro].present?
        @filtrar = params[:filtro]
      end
    end
  end

  def show
    @turno = Turno.find(params[:id])
    @requests = Request.all
    @resenas = @turno.resenas.all
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
    puts "search"
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
