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
    if tasks.all?(&:complete?)
      'complete'
    elsif tasks.any?(&:in_progress?)
      'in-progress'
    else
      'not-started'
    end
  end
end
