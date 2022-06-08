# frozen_string_literal: true

module Users
  # This class is for the users controller
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    def show
      @user = User.find(params[:id])
      @existen_resenas = false
      if Resena.any?
        @resenas_usuario = []
        resenas = Resena.all
        cantidad = 0
        acumulado = 0
        resenas.each do |resena|
          next unless resena.turno.user_id == @user.id

          cantidad += 1
          acumulado += resena.calificacion.to_i
          @resenas_usuario << resena
        end
        if cantidad != 0
          @existen_resenas = true
          @promedio = acumulado / cantidad
        end
      end
    end

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource

    # GET /resource/edit

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[name address description gender phone foto reglas])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: %i[name address description gender phone foto reglas])
    end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
