class Todo < ActiveRecord::Base

  def complete?
    complete
  end

  def toggle_completeness
    toggle!(:complete)
  end

end
