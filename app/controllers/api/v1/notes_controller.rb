module Api::V1
class NotesController < ApiBaseController
  before_action :set_note, only: %i[show create update destroy]

  def sync
    params.to_unsafe_h.each do |_, note|
      id = note.delete('remote_id')
      if  id == -1
        current_user.notes.create(note)
      else
        current_user.notes.find(id).update(note)
      end
    end
    render json: {message: current_user.notes}
  end

  def index
    json_response(current_user.notes.visible)
  end

  def show
    render json: current_user
    # json_response(@note)
  end

  def create
    note = current_user.notes.build(note_params)
    if note.save
      json_response({message: 'Note Saved'}, :created)
    else
      json_response({error: note.errors}, :unprocessable_entity)
    end
  end

  def update
    if @note.update(note_params)
      head :no_content
    else
      json_response({error: note.errors}, :unprocessable_entity)
    end
  end

  def destroy
    @note.destroy
    head :no_content
  end

  private

  def set_note
    @note = current_user.notes.find(params[:id])
  end

  def note_params
    params.permit(:name, :body)
  end

end
end
