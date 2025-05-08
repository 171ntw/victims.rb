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
        userinfo: 'https://localhost:4567/user?id=profileID'
    }
 }.to_json
end

get '/user' do
  content_type :json
  
  begin
    discord_id = params['id'] || false

    if discord_id == false || discord_id.nil? || discord_id.empty?
      return { error: "Parameter 'id' is required. Example: /user?id=123456789" }.to_json
    end

    response = HTTP.get("https://api.victims.bio/discord/user/#{discord_id}")
    
    if response.parse['user']
    
      JSON.pretty_generate(response)
    else
      { error: 'User not found or error in external API' }.to_json
    end
  rescue => e
    { status: 500, error: 'Internal server error', details: e.message }.to_json
  end
end