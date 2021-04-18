module Api
  module V1
    class ParsersController < BaseController
      def create
        data = ParserService.new(params[:payload]).execute

        render json: data, status: data[:status_code]
      end
    end
  end
end
