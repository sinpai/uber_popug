class Task < ActiveRecord::Base

  TASK_STATUSES = [:open, :in_progress, :completed]

end
