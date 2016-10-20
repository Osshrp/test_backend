class SortUsers
  def self.sort(params)
    # users = User.select('DISTINCT *').
    #   joins(:posts).
    #   where('posts.published_at >= ?', params["start_date"].to_date).
    #   where('posts.published_at <= ?', params["end_date"].to_date).to_a
    # users.sort_by do |user|
    #   -(user.posts.count + user.comments.count)
    # end
    sql_posts = "select users.nickname,
                  users.email,
                  count(users.nickname) as qp
          from users
            inner join posts on users.id = posts.user_id
          where posts.published_at > \'#{params["start_date"]}\'
          group by users.nickname, users.email"

    sql_comments = "select users.nickname,
                  users.email,
                  count(users.nickname) as qc
          from users
            inner join comments on users.id = comments.user_id
          where comments.published_at > \'#{params["start_date"]}\'
          group by users.nickname, users.email"

    users_posts = ActiveRecord::Base.connection.execute(sql_posts).to_a
    users_comments = ActiveRecord::Base.connection.execute(sql_comments).to_a
    return [users_posts, users_comments]
  end
end