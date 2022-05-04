class TurnosController < ApplicationController

  #### CREATE
  def new
    @turno = Turno.new
  end

  def create
    @turnos_params = params.require(:turno).permit(:cantidad_asientos, :hora_salida, :direccion_salida, :direccion_llegada, :dia_semana, :tipo)
    @turnos_params.merge!(:id_usuario => current_user.id)
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
  end

  def show
    @turno = Turno.find(params[:id])
  end

  #### UPDATE
  def edit
    @turno = Turno.find(params[:id])
  end

  def update
    @turno = Turno.find(params[:id])
    @turnos_params = params.require(:turno).permit(:cantidad_asientos, :hora_salida, :direccion_salida, :direccion_llegada, :dia_semana, :tipo)
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
