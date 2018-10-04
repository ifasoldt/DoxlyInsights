class BaseApi

  JSON_CONTENT_TYPE = 'application/json'
  XML_CONTENT_TYPE  = 'text/xml'

  def get(options={})
    raise 'Path not present' unless options[:path].present?
    headers = options.fetch(:headers, {})
    path    = options.fetch(:path)
    response = connection(options).get(path)
    parse_response(response)
  end

  def post(options={})
    raise 'Path not present' unless options[:path].present?
    headers   = options.fetch(:headers, {})
    data      = options.fetch(:data, {})
    path      = options.fetch(:path)
    response = connection(options).post do |request|
      request.url path
      request.body = data
    end
    handle_response(response, 'post', options)
  end

  def connection(options={})
    headers     = options.fetch(:headers)
    encoding_type = options.fetch(:encoding_type, nil)
    Faraday.new do |faraday|
      faraday.request encoding_type if encoding_type
      faraday.headers = headers
      faraday.response :logger, ::Logger.new(STDOUT), bodies: true
      faraday.adapter :net_http
    end
  end

  def parse_response(response)
    # have to use include? here because all sorts of things get tacked onto application/json, for example 'charset=utf-8'
    if response["content-type"]&.include?(JSON_CONTENT_TYPE)
      JSON.parse(response.body)
    elsif response["content-type"]&.include?(XML_CONTENT_TYPE)
      Hash.from_xml(response.body)
    else
      response.body
    end
  end

end
