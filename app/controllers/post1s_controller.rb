class Post1sController < InheritedResources::Base

  private

    def post1_params
      params.require(:post1).permit(:name, :role)
    end

end
