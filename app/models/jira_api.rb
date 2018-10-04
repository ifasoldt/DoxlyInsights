class JiraApi < BaseApi
  # routes object that will hold all of the specific urls to hit the iManage10 api.
  ROUTES = {
    get_epics: -> {"https://doxly-jira.atlassian.net/rest/api/3/search?jql=project=10000%26type=epic%26created>-10w&maxResults=100"},
    get_epic_issues: -> (epic_id) {"https://doxly-jira.atlassian.net/rest/api/3/search?jql='epic link'=#{epic_id}&maxResults=100"}
  }

  def get_epics
    parser.issues_parser(get({ path: ROUTES[:get_epics].call, headers: authentication_header }))
  end

  def get_epic_issues
  end


  private

  def authentication_header
    { Authorization: "Basic #{encoded_jira_credentials}" }
  end

  def encoded_jira_credentials
    rails_config = Rails.application.config.di_config
    Base64.encode64("#{rails_config["jira_username"]}:#{rails_config["jira_password"]}")
  end

  def parser
    JiraParser.new
  end

end
