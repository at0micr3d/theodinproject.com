class KittensController < ApplicationController
	def new
		@kitten = Kitten.new
	end

	def create
		@kitten = Kitten.new(kitten_params)

		if @kitten.save
			flash[:succes] = "Woow a new kitten!"
			redirect_to @kitten
		else
			flash[:error].now = "Damn that aint no kitten!"
			render :new
		end
	end

	def index
		@kittens = Kitten.all
		respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @kittens }
    end
	end

	def show
		@kitten = Kitten.find(params[:id])
		respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @kitten }
    end
	end

	def edit
		@kitten = Kitten.find(params[:id])
	end

	def destroy
		@kitten = Kitten.find(params[:id])
		@kitten.destroy
		redirect_to kittens_url		
	end

	def update
		@kitten = Kitten.update(kitten_params)

		if @kitten.save
			redirect_to @kitten
		else
			render :edit
		end
	end

	private

	def kitten_params
		params.require(:kitten).permit(:name, :age, :softness, :cuteness)
	end

end
