class ResenasController < ApplicationController
  #### CREATE 
  def new
    @resena = Resena.new
    @id_viaje = params[:id_viaje]
    @users = User.all
    @turnos = Turno.all
  end

  def create
    @resenas_params = params.require(:resena).permit(:id_viaje, :id_cliente_evaluador, :id_cliente_evaluado, :contenido, :calificacion, :turnos, :users)
    @resena = Resena.create(@resenas_params)

    if @resena.update(@resenas_params)
      redirect_to resenas_index_path, notice: 'Solicitud enviada exitosamente'
      puts '****************************************************** Éxito'
    else
      redirect_to resenas_index_path, notice: 'Error al enviar solicitud'
      puts '****************************************************** Fracaso'
    end

  end

  #### READ
  def index
    @resenas = Resena.all
    @id_viaje = params[:id_viaje]
  end

  def show
    @resena = Resena.find(params[:id])
  end

  #### UPDATE
  def edit
    @resena = Resena.find(params[:id])
  end

  def update
    @resena = Resena.find(params[:id])
    @resenas_params = params.require(:resena).permit(:id_viaje, :id_cliente_evaluador, :id_cliente_evaluado, :contenido, :calificacion, :turnos, :users)
    if @resena.update(@resenas_params)
      redirect_to resenas_index_path, notice: 'Reseña editada exitosamente'
    else
      redirect_to resenas_index_path, notice: 'Error al editar reseña'
    end
  end

  #### DELETE
  def delete
    @resena = Resena.find(params[:id])
    @resena.destroy

    redirect_to resenas_index_path, notice: 'Reseña eliminado'
  end
end
