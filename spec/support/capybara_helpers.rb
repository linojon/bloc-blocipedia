def current_path
  URI.parse(current_url).request_uri
end
