namespace :jira_tasks do
  #if Rails.env == 'production'
    Rails.logger = Logger.new(STDOUT)
  #end
  task :build_epics => :environment do
    epics = api.get_epics
    epics.each do |epic|
      di_epic = create_or_update_epic(epic)
      di_epic.create_snapshot!
    end
  end

  def create_or_update_epic(epic)
    di_epic = Epic.find_by(jira_id: epic["id"]) || Epic.new
    di_epic.build_from_jira_epic(epic)
    di_epic.save
    di_epic
  end

  def api
    JiraApi.new
  end
end
