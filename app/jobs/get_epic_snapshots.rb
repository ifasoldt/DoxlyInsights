class GetEpicSnapShots < ApplicationJob
  queue_as :get_epic_snapshots

  def perform
    build_epics
  end

  def build_epics
    epics = api.get_epics
    epics.each do |epic|
      create_or_update_epic(epic)
    end
  end

  def create_or_update_epic(epic)
    di_epic(epic).build_from_jira_epic(epic)
    di_epic.save
  end

  def di_epic(epic)
    Epic.find_by(jira_id: epic["id"]) || Epic.new
  end

  def api
    JiraApi.new
  end
end
