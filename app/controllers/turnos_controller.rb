# frozen_string_literal: true

# This class is for the turnos controller
class TurnosController < ApplicationController
  #### CREATE
  def new
    @turno = Turno.new
  end

  def create
    @turnos_params = params.require(:turno).permit(:cantidad_asientos, :hora_salida, :direccion_salida, :direccion_llegada, :dia_semana, :tipo)
    hora = @turnos_params["hora_salida(4i)"]
    minuto = @turnos_params["hora_salida(5i)"]
    horario = hora+':'+minuto
    @turnos_params.merge!(:hora_salida => horario)
    @turnos_params.delete("hora_salida(1i)")
    @turnos_params.delete("hora_salida(2i)")
    @turnos_params.delete("hora_salida(3i)")
    @turnos_params.delete("hora_salida(4i)")
    @turnos_params.delete("hora_salida(5i)")
    @turnos_params.merge!(:id_usuario => current_user.id) 
    @turnos_params.merge!(:estado => "ACTIVO")                                           
    @turno = Turno.create(@turnos_params)
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
  end

  #### UPDATE
  def edit
    @turno = Turno.find(params[:id])
  end

  def update
    @turno = Turno.find(params[:id])
    @turnos_params = params.require(:turno).permit(:cantidad_asientos, :hora_salida, 
    :direccion_salida, :direccion_llegada, :dia_semana, :tipo, :estado)
    hora = @turnos_params["hora_salida(4i)"]
    minuto = @turnos_params["hora_salida(5i)"]
    horario = hora+':'+minuto
    @turnos_params.merge!(:hora_salida => horario)
    @turnos_params.delete("hora_salida(1i)")
    @turnos_params.delete("hora_salida(2i)")
    @turnos_params.delete("hora_salida(3i)")
    @turnos_params.delete("hora_salida(4i)")
    @turnos_params.delete("hora_salida(5i)")
    @turnos_params.merge!(:id_usuario => current_user.id)
    if @turno.update(@turnos_params)
      redirect_to turnos_index_path, notice: 'Turno editado exitosamente'
    else
      redirect_to turnos_index_path, notice: 'Error al editar turno'
    end
  end

  #### DELETE
  def delete
    @turno = Turno.find(params[:id])
    @turno.destroy

    redirect_to turnos_index_path, notice: 'Turno eliminado'
  end
end
