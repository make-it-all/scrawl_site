module Api::V1
class NotesController < ApiBaseController
  before_action :set_note, only: %i[show create update destroy]

  def sync
    # x = false
    #
    # return unless x
    notes_json = JSON.parse params[:notes]
    new_remote_notes = {}
    notes_json.each do |local_id, note|
      id = note.delete('remote_id')
      if id.to_i == -1
        new_note = current_user.notes.create(note)
        new_remote_notes[local_id] = new_note.id
      else
        note['updated_at'] = DateTime.strptime(note['updated_at'][0..-4], '%s')
        saved_note = current_user.notes.find_by(id: id)
        if saved_note.updated_at < note['updated_at']
          saved_note.update(note)
        end
      end
    end
    json_response({notes: current_user.notes, new_notes: new_remote_notes})
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
