class ResenasController < ApplicationController
  #### CREATE 
  def new
    @resena = Resena.new
  end

  def create
    @resenas_params = params.require(:request).permit(:id_viaje, :id_cliente_evaluador, :id_cliente_evaluado, :contenido, :calificacion)
    @resena = Resena.create(@resenas_params)

    if @resena.update(@resenas_params)
      redirect_to resenas_index_path, notice: 'Solicitud enviada exitosamente'
    else
      redirect_to resenas_index_path, notice: 'Error al enviar solicitud'
    end

  end

  #### READ
  def index
    @resenas = Resena.all
  end

  def show
  end

  #### UPDATE
  def edit
  end

  #### DELETE
end
