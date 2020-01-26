json.extract! post, :id, :question, :answer, :user_id, :num_anser, :num_correct, :next_time, :before_answer, :created_at, :updated_at
json.url post_url(post, format: :json)
