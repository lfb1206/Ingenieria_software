class ResenasController < ApplicationController
  #### CREATE 
  def new
    @resena = Resena.new
    @id_viaje = params[:id_viaje]
  end

  def create
    @resenas_params = params.require(:resena).permit(:contenido, :calificacion, :turno_id, :user_id)
    @resena = Resena.create(@resenas_params)
    @resena.user = current_user
    @resena.turno = Turno.find(@resenas_params["turno_id"])

    if @resena.save!
      redirect_to turnos_show_path(:id => @resena.turno.id), notice: 'Solicitud enviada exitosamente'
    else
      redirect_to turnos_show_path(:id => @resena.turno.id), notice: 'Error al enviar solicitud'
    end

  end

  #### READ
  def index
    @resenas = Resena.all
    @id_viaje = params[:id_viaje]
  end

  def show
    @resena = Resena.find(params[:id])
    @user_conductor = User.find(@resena.turno.id_usuario)
  end

  #### UPDATE
  def edit
    @resena = Resena.find(params[:id])
  end

  def update
    @resena = Resena.find(params[:id])
    @resenas_params = params.require(:resena).permit(:contenido, :calificacion, :turno_id, :user_id)
    if @resena.update(@resenas_params)
      redirect_to turnos_show_path(:id => @resena.turno.id), notice: 'Reseña editada exitosamente'
    else
      redirect_to turnos_show_path(:id => @resena.turno.id), notice: 'Error al editar reseña'
    end
  end

  #### DELETE
  def delete
    @resena = Resena.find(params[:id])
    @resena.destroy

    redirect_to turnos_show_path(:id => @resena.turno.id), notice: 'Reseña eliminado'
  end
end
