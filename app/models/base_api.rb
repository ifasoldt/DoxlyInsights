class BaseApi
  include HTTMultiParty

  def get(options={})
    raise Exception unless options[:path].present?
    headers = options.fetch(:headers, {})
    HTTParty.get(URI.encode(options[:path]), headers: headers).parsed_response
  end

  def post(options={})
    raise Exception unless options[:path].present?
    headers   = options.fetch(:headers, {})
    data      = options.fetch(:data, {})
    HTTParty.post(URI.encode(options[:path]), { body: data, headers: headers }).parsed_response
  end

end
