# Discord User Info API

This is a public API created with the API of a friend, owner of victims.bio

## Prerequisites

- **Ruby 3.x or later**
- **Sinatra**, **HTTP**, and **JSON** gems

### Install Dependencies

Run the following commands:

```bash
gem install sinatra http json
```

Or use Bundler by adding the gems to a `Gemfile`:

```ruby
gem 'sinatra'
gem 'http'
gem 'json'
```

Then run:

```bash
bundle install
```

### Run the Server

Start the server:

```bash
ruby main.rb
```

It will run on [http://localhost:4567](http://localhost:4567).

---

## API Usage

### 1. **Get User Info**

Send a GET request to `/user` with a query parameter `id` (Discord User ID).

#### Example Request:

```bash
curl "http://localhost:4567/user?id=922871214312144926"
```

#### Example Response:

```json
{
  "id": "922871214312144926",
  "username": "anjocriado",
  "premium_type": 2,
  "boost": {
    "current_level": "guild_booster_lvl4"
  },
  "nitro": {
    "current_badge": "nitro_platinum"
  }
}
```

### 2. **Error Handling**

- Missing `id` parameter:

```bash
curl "http://localhost:4567/user"
```

---

## License

MIT License.

Github: https://github.com/171ntw/

---

**Enjoy using the Discord User Info API!**