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
      point: point.to_i
    }

    new_score_board = $score_board.sort_by{|item| item[1]}.reverse
    $score_board = new_score_board.slice(0, 30)
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
  <title>Scratoon</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
</head>
<body>
  <div class="container">
    <h1>Leaderboard</h1>
    <table class="table">
      <thead>
        <tr>
          <th>#</th>
          <th>Name</th>
          <th>Score</th>
        </tr>
      </thead>
      <tbody>
        <% score_board.each_with_index do |score, index| %>
        <tr>
          <th scope="row"><%= index + 1 %></th>
          <td><%= score[:holder] %></td>
          <td><%= score[:point] %></td>
        </tr>
        <% end %>
      </tbody>
    </table>
  </div>
</body>
</html>

@@ crossdomain
<cross-domain-policy xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.adobe.com/xml/schemas/PolicyFile.xsd">
  <site-control permitted-cross-domain-policies="master-only"/>
  <allow-access-from domain="scratchx.org"/>
  <allow-access-from domain="llk.github.io"/>
</cross-domain-policy>
