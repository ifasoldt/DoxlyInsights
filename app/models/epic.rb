class Epic < ApplicationRecord
  has_many :epic_snapshots

  COMPLETED_STATUSES = ["Closed", "Ready To Deploy", "Dev Complete", "QA", "Done"]

  def build_from_jira_epic(epic)
    is_active = -> { epic["fields"]["description"].to_s.include?("active!") }
    assign_attributes(
      jira_id: epic["id"],
      name: epic["fields"]["customfield_10019"],
      origin_date: epic["fields"]["customfield_10801"],
      is_active: is_active.call
    )
  end

  def create_snapshot!
    epic_issues = api.get_epic_issues({ epic_id: jira_id })
    total_storypoints = 0
    total_completed_storypoints = 0
    number_of_completed_tickets = 0
    self.unestimated_tickets = 0
    epic_issues.each do |epic_issue|
      storypoints = epic_issue["fields"]["customfield_10021"].to_i
      total_storypoints += storypoints
      completed = COMPLETED_STATUSES.include?(epic_issue["fields"]["status"]["name"])
      if completed
        total_completed_storypoints += storypoints
        number_of_completed_tickets += 1
      end
      self.unestimated_tickets +=1 if storypoints == 0
    end
    epic_snapshots.create(completed_storypoints: total_completed_storypoints, total_storypoints: total_storypoints)
    self.highest_storypoint_count = total_storypoints
    self.total_tickets = epic_issues.length
    self.completed_tickets = number_of_completed_tickets
    save
  end


  def api
    JiraApi.new
  end
end
