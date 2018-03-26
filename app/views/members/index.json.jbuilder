json.array!(@members) do |member|
  json.extract! member, :id, :first_name, :last_name, :team_id, :dietary_restrictions
  json.url member_url(member, format: :json)
end
