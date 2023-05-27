# frozen_string_literal: true

class LotosController < ApplicationController
  def show
    unless Loto.kinds.value?(kind)
      render status: :not_found, json: {}
      return
    end

    @lotos = Loto.where(kind:).order(times: 'ASC').includes(:loto_numbers)
  end

  private

  def kind
    params[:kind].to_i
  end
end
