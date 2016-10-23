module Refinery
  module Pianos
    module Admin
      class PianosController < ::Refinery::AdminController

        crudify :'refinery/pianos/piano',
                :title_attribute => 'name'

        private

        # Only allow a trusted parameter "white list" through.
        def piano_params
          params.require(:piano).permit(:name, :dimensions, :manufactured_on, :upright, :photo_id, :description)
        end
      end
    end
  end
end
