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
      # count = 0
      # if @book[:title] == ''
      #   create_error_title = "<li>Title can't be blank</li>"
      #   count = count + 1
      # end
      # if @book[:body] == ''
      #   create_error_body = "<li>Body can't be blank</li>"
      #   count = count + 1
      # end
      # flash[:create_error] = "
      # <div class=\"error_explanation\">
      # <h2>#{count} errors prohibited this book from being saved:</h2>
      # <ul>
      #   #{create_error_title}
      #   #{create_error_body}
      # </ul>
      # </div>
      # "
      error
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
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.update(book_params)
      flash[:edit_success] = "successfully edited"
      redirect_to book_path(@book.id)
    else
      error
      redirect_to edit_book_path(@book.id)
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

  def error
    count = 0
      if @book[:title] == ''
        create_error_title = "<li>Title can't be blank</li>"
        count = count + 1
      end
      if @book[:body] == ''
        create_error_body = "<li>Body can't be blank</li>"
        count = count + 1
      end
      flash[:error] = "
      <div class=\"error_explanation\">
      <h2>#{count} errors prohibited this book from being saved:</h2>
      <ul>
        #{create_error_title}
        #{create_error_body}
      </ul>
      </div>
      "
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
