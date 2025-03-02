class ConfirmationsController < ApplicationController
    def confirmed
      render json: { message: "Email successfully confirmed. You can now log in." }
    end
  end
  