module TasksHelper

  def status_options
    Task::TASK_STATUSES.map { |status| [status.to_s.humanize.capitalize, status] }
  end
end
