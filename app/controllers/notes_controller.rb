class NotesController < ApplicationController

  before_action :set_note, only: %i[show edit update]

  def index
    @notes = Note.all
  end

  def show
  end

  def new
    @note = Note.new(user: current_user)
  end

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    if @note.save
      redirect_to :notes, notice: 'Note Updated'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to :notes, notice: 'Note Updated'
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to :notes
  end

private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:name, :body)
  end

end
