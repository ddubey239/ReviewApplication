json.extract! post, :id, :reviewable_type, :reviewable_id, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)