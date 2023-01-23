class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user

  def badge_color
    case status
    when 'not-started'
      'secondary'
    when 'in-progress'
      'info'
    when 'complete'
      'success'
    end
  end

  def status
    return 'not-started' if tasks.none?
    if tasks.all?(&:complete?)
      'complete'
    elsif tasks.any?(&:in_progress?) || tasks.any?(&:complete?)
      'in-progress'
    else
      'not-started'
    end
  end

  def percent_complete
    return 0 if tasks.none?

    # original way shown in tutorial - replaced instead by total_complete method
    # complete_tasks = tasks.select(&:complete?).count
    ((total_complete.to_f / tasks.count) * 100).round
  end

  def total_complete
    tasks.select(&:complete?).count
  end

  def total_tasks
    tasks.count
  end
end
