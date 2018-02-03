module GmapsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'check'
      check_gmaps_path
    elsif action_name == 'edit'
      gmap_path
    end
  end
end
