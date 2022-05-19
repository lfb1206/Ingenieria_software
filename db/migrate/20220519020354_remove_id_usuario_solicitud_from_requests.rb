class RemoveIdUsuarioSolicitudFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :id_usuario_solicitud, :integer
  end
end
