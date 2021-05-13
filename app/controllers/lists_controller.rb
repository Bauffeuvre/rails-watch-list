class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end
  
  def create
    @list = List.new(params_list)
    if @list.save
      flash[:success] = "List successfully created"
      redirect_to @list
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  def show
    @list = List.find(params[:id])
  end
    
  private

  def params_list
    params.require(:list).permit(:name)
  end
  
end
