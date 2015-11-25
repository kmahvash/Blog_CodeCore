class CommentsMailer < ApplicationMailer

  def notify_post_owner(comment)
    @comment = comment
    @post = comment.post
    @owner = @post.user
      if @owner.email.present?
        mail(to: @owner.email, subject: "Your post has received a new comment!")
		  end
  end

end
