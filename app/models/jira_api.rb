class JiraApi < BaseApi
  # routes object that will hold all of the specific urls to hit the iManage10 api.
  ROUTES = {
    get_epics: -> {"https://doxly-jira.atlassian.net/rest/api/3/search?jql=project=10000%26type=epic%26created>-10w&maxResults=100"},
    get_epic_issues: -> (epic_id) {"https://doxly-jira.atlassian.net/rest/api/3/search?jql='epic link'=#{epic_id}&maxResults=100"}
  }

  def get_epics(options={})
    parser.issues_parser(get({ path: ROUTES[:get_epics].call, headers: authentication_header }))
  end

  def get_epic_issues(options={})
    epic_id = options.fetch(:epic_id, nil)
    parser.issues_parser(get({ path: ROUTES[:get_epic_issues].call(epic_id), headers: authentication_header }))
  end


  private

  def authentication_header
    { Authorization: "Basic #{encoded_jira_credentials}" }
  end

  def encoded_jira_credentials
    Base64.encode64("#{ENV["jira_username"]}:#{ENV["jira_password"]}")
  end

  def parser
    JiraParser.new
  end

end
