require 'sinatra'
require 'rack/cors'
require 'erubis'
require 'json'

use Rack::Cors do
  allow do
    origins '*'
    resource '/register', :headers => :any, :methods => :post
  end
end

set :erb, :escape_html => true

# {holder: name, point: num}
$score_board = []

helpers do
  def register_score(name, point)
    $score_board << {
      holder: name,
      point: point
    }
  end
end

get '/' do
  erb :index, locals: { score_board: $score_board }
end

post '/register' do
  register_score(params[:name], params[:point])
  content_type :json
  { success: true }.to_json
end

get '/crossdomain.xml' do
  content_type :xml
  erb :crossdomain
end

__END__

@@ index
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title></title>
</head>
<body>
  <h1>Leaderboard</h1>
  <% score_board.each do |score| %>
    <%= score[:holder] %>
    <%= score[:point] %>
  <% end %>
</body>
</html>

@@ crossdomain
<cross-domain-policy xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.adobe.com/xml/schemas/PolicyFile.xsd">
  <site-control permitted-cross-domain-policies="master-only"/>
  <allow-access-from domain="scratchx.org"/>
  <allow-access-from domain="llk.github.io"/>
</cross-domain-policy>
