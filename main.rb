require 'sinatra'
require 'http'
require 'json'

get '/' do
  content_type :json
  { 
    status: 200,
    author: {
        github: 'https://github.com/171ntw',
        download: 'https://github.com/171ntw/victims.rb',
        message: "This is a public API created with the API of a friend, owner of victims.bio"
    },
    routes: {
        userinfo: 'https://localhost:4567/user?id=userID',
        usercard: 'https://localhost:4567/card?id=userID'
    }
  }.to_json
end

get '/user' do
  content_type :json

  begin
    discord_id = params['id']

    if discord_id.nil? || discord_id.empty?
      return { error: "Parameter 'id' is required. Example: /user?id=123456789" }.to_json
    end

    response = HTTP.get("https://api.victims.bio/discord/user/#{discord_id}")
    parsed_data = JSON.parse(response.body.to_s)

    if parsed_data['user']
      parsed_data.to_json
    else
      { error: 'User not found or error in external API' }.to_json
    end
  rescue => e
    { status: 500, error: 'Internal server error', details: e.message }.to_json
  end
end

get '/card' do
  discord_id = params['id']

  if discord_id.nil? || discord_id.empty?
    content_type :json
    return { error: "Parameter 'id' is required. Example: /card?id=123456789" }.to_json
  end

  begin
    response = HTTP.get("https://api.victims.bio/discord/user/discord-arts/#{discord_id}/card")

    if response.status.success?
      content_type 'image/png'
      response.to_s
    else
      content_type :json
      status 404
      {
        message: "Erro ao gerar o card do Discord",
        error: "Not Found",
        statusCode: 404
      }.to_json
    end
  rescue => e
    content_type :json
    status 500
    {
      message: "Erro interno ao buscar o card",
      error: e.message,
      statusCode: 500
    }.to_json
  end
end
