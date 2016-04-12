json.array!(@invitations) do |invitation|
  json.extract! invitation, :id, :email, :inviter_id, :receiver_id, :sender_id, :token
  json.url invitation_url(invitation, format: :json)
end
