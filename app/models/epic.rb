class Epic < ApplicationRecord

  def build_from_jira_epic(epic)
    is_active = -> { epic["issues"].second["fields"]["description"].to_s.include?("active!") }
    assign_attributes(
      jira_id: epic["id"],
      name: epic["fields"]["customfield_10019"],
      origin_date: epic["fields"]["customfield_10801"],
      is_active: is_active.call
    )
  end

  def create_epic_snapshot!

  end
end
