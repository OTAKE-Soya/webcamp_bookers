class BooksController < ApplicationController
  def top
  end

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(create_book_params)
    @book.save
    if @book.save
      flash[:create_succes] = "Successfully created"
    else
      flash[:create_error] = "Create error"
    end
    redirect_to books_path
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(update_book_params)
    if book.update(update_book_params)
      flash[:edit_success] = "Successfully edited"
      redirect_to book_path(book.id)
    else
      flash[:edit_error] = "edit error"
      redirect_to edit_book_path(book.id)
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    if book.destroy
      flash[:success_destroy] = "Successfully destroyed"
    end
    redirect_to books_path
  end

  private
  def create_book_params
    params.permit(:title, :body)
  end

  def update_book_params

    params.require(:book).permit(:title, :body)
  end



end
