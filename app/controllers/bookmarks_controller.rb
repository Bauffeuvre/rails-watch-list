class BookmarksController < ApplicationController

  def index
    @bookmarks = Bookmark.all
  end
  
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(params_bookmark)
    @list = List.find(params[:list_id])
    # @movie = Movie.find(params[:movie_id])
    # @bookmark.movie_id = @movie
    @bookmark.list = @list
    if @bookmark.save
      flash[:success] = "Bookmark successfully created"
      redirect_to @list
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  def destroy
    @bookmark = Bookmark.find(params[:id])
    if @bookmark.destroy
      flash[:success] = 'Bookmark was successfully deleted.'
      redirect_to @bookmark.list
    else
      flash[:error] = 'Something went wrong'
      redirect_to bookmark_path
    end
  end
  
  private

  def params_bookmark
    params.require(:bookmark).permit(:comment, :movie_id)
  end

end
