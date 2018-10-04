class JiraParser

  def issue_parser(response)
    response["issues"]
  end
end
