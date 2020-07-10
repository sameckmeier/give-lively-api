# frozen_string_literal: true

module Api
  module V1
    class NonProfitsController < ApplicationController
      def index
        render status: :ok
      end
    end
  end
end
