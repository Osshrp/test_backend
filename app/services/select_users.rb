class SelectUsers
  def self.select(params)
    users = []
    User.all.each do |user|
      user_hash = {}
      user_hash = {
        nickname: user.nickname,
        email: user.email,
        posts: user.posts.where("published_at between ? and ?",
         params[:start_date], params[:end_date]).count,
        comments: user.comments.where("published_at between ? and ?",
         params[:start_date], params[:end_date]).count
      }
      users << user_hash
    end
    users.sort_by { |user| user[:quality] = -(user[:posts]+user[:comments]).to_f/10 }
  end
end
