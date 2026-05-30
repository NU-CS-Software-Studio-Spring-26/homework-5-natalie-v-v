class Todo < ApplicationRecord
    validates :description, presence: true
  
    def toggle_priority!
      toggle!(:high_priority)
    end

    def snooze!
        new_date = (due_date || Time.current) + 24.hours
        update!(due_date: new_date)
      end
  
    def full_description
      if due_date.present?
        "#{description} (Due: #{due_date.strftime('%Y')})"
      else
        description
      end
    end
  end