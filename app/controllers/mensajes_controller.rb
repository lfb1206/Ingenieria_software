class MensajesController < ApplicationController
  #### CREATE
  def new
    @mensaje = Mensaje.new
    @id_viaje = params[:id_viaje]
  end

  def create
    @mensajes_params = params.require(:mensaje).permit(:contenido, :calificacion, :turno_id, :user_id)
    @mensaje = Mensaje.create(@mensajes_params)
    @mensaje.user = current_user
    @mensaje.turno = Turno.find(@mensajes_params['turno_id'])
    if @mensaje.save
      redirect_to mensaje_index_path(id_viaje: @mensaje.turno.id, ), notice: 'Solicitud enviada exitosamente'
    else
      @id_viaje = @mensajes_params['turno_id']
      render 'new', notice: 'Error al crear mensaje'
    end
  end

  #### READ
  def index
    @mensajes = Mensaje.all
    @chat_turno = @mensajes[0]
    @id_viaje = @mensajes[0].turno_id
  end

  def show
    @mensaje = Mensaje.find(params[:id])
    @user_conductor = User.find(@mensaje.turno.user_id)
  end

  #### UPDATE
  # def edit
  # end

  # def update
  # end

  #### DELETE
  # def delete
  # end
end
