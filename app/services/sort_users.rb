class SortUsers
  def self.sort(params)
    users = []
    User.all.each do |user|
      user_hash = {}
      user_hash = {
        nickname: user.nickname,
        email: user.email,
        posts: user.posts.where("published_at between ? and ?" , '2016-10-17', '2016-10-18').count,
        comments: user.comments.where("published_at between ? and ?", '2016-10-17', '2016-10-18').count
      }
      users << user_hash
    end
    users.sort_by { |user| user[:quality] = -(user[:posts]+user[:comments]).to_f/10 }
  end
end