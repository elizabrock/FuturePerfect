module ApplicationHelper
  def last_progress_in_words(goal)
    last_progress = goal.last_progress
    if last_progress.present?
      "#{time_ago_in_words(last_progress.created_at)} ago"
    else
      "never"
    end
    if last_progress.present?
      "#{time_ago_in_words(last_progress.created_at)} ago"
    else
      "never"
    end
  end
end
