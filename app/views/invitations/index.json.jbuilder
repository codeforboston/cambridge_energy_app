json.array!(@invitations) do |invitation|
  json.extract! invitation, :id, :receiver_id, :sender_id
  json.url invitation_url(invitation, format: :json)
end
