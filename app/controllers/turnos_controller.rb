# frozen_string_literal: true

# This class is for the turnos controller
class TurnosController < ApplicationController
  before_action :authenticate_user!
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
    @turno = "-"
    @users = User.all
    @requests = Request.all
    @tipo_index = params[:tipo]
    if params[:conductor].present?
      @turnos = @turnos.where(user_id: (@users.find {|item| 
      ((item.name).include? params[:conductor]) or (params[:conductor].include? (item.name))}).id)
    end
    if params[:dia_semana].present?
      @turnos = @turnos.where(dia_semana: params[:dia_semana])
      puts "--------------------dia"
    end
    if params[:tipo_turno].present?
      @turnos = @turnos.where(tipo: params[:tipo_turno])
      puts "--------------------tipo"
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
