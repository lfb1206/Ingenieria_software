# frozen_string_literal: true

# This class is for the turnos controller
class TurnosController < ApplicationController
  before_action :authenticate_user!
  #### CREATE
  def new
    @turno = Turno.new
  end

  def create
    @turnos_params = turno_params
    hora = @turnos_params['hora_salida(4i)']
    minuto = @turnos_params['hora_salida(5i)']
    horario = "#{hora}:#{minuto}"
    @turno = Turno.create(turno_params)
    @turno.estado = 'ACTIVO'
    @turno.hora_salida = horario
    @turno.user = current_user
    if @turno.save
      redirect_to turnos_index_path, notice: 'Turno creado exitosamente'
    else
      redirect_to turnos_index_path, notice: 'Error al crear turno'
    end
  end

  #### READ
  def index
    @turnos = Turno.all
    @users = User.all
    @requests = Request.all
  end

  def show
    @turno = Turno.find(params[:id])
    @requests = Request.all
    @resenas = @turno.resenas.all
  end

  #### UPDATE
  def edit
    @turno = Turno.find(params[:id])
  end

  def update
    @turno = Turno.find(params[:id])
    @turnos_params = turno_params
    @turnos_params.merge!(user_id: current_user.id)
    if @turno.update(@turnos_params)
      redirect_to turnos_index_path, notice: 'Turno editado exitosamente'
    else
      redirect_to turnos_index_path, notice: 'Error al editar turno'
    end
  end

  #### DELETE
  def delete
    @turno = Turno.find(params[:id])
    puts "Entro"
    @turno.destroy

    redirect_to turnos_index_path, notice: 'Turno eliminado'
  end

  private

  def turno_params
    params.require(:turno).permit(:cantidad_asientos, :hora_salida, :direccion_salida,
      :direccion_llegada, :dia_semana, :tipo)
  end
end
