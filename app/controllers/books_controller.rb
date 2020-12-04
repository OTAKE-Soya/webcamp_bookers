class BooksController < ApplicationController
  def top
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.save
    if @book.save
      flash[:create_succes] = "successfully created"
      redirect_to book_path(@book.id)
    else
      flash[:create_error] = "create error"
      if @book[:title] == ''
        flash[:create_error_title] = "error title can't be blank"
      end
      if @book[:body] == ''
        flash[:create_error_body] = "error body can't be blank"
      end
      redirect_to books_path
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    if book.update(book_params)
      flash[:edit_success] = "successfully edited"
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
      flash[:success_destroy] = "successfully destroyed"
    end
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
