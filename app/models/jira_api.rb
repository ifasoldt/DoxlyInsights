class JiraApi < BaseApi
  # routes object that will hold all of the specific urls to hit the iManage10 api.
  ROUTES = {
    authenticate: -> {"https://doxly-jira.atlassian.net/rest/auth/1/session"}
  }

  def login
    headers = {
       'Accept': 'application/json',
       'Content-Type': 'application/json'
    }
    body = {
      'username': Rails.application.config.di_config["jira_username"],
      'password': Rails.application.config.di_config["jira_password"],
    }
    debugger
    response = post({path: ROUTES[:authenticate].call, data: body, headers: headers })
    debugger
  end
end
