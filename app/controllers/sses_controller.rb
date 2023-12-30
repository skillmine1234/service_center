class SsesController < InheritedResources::Base

  private

    def ss_params
      params.require(:ss).permit(:name, :phone)
    end

end
