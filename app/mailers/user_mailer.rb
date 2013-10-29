require 'digest/sha1'

class UserMailer < ActionMailer::Base
  default :from => OWP.config.email.from

  # TODO: tests

  def restore_password_email(user, link)
    @link = (link + "?user_id=#{user.id}&hash=" + Digest::SHA1.hexdigest(user.crypted_password + user.login))
    mail(
      :to      => user.email,
      :subject => I18n.t('restore_password.mail.restore_link.subject')
    )
  end

  def request_email(user, request)
    @request = request
    mail(
      :to      => user.email,
      :subject => I18n.t('admin.requests.mail.new_request.subject', :id => request.id)
    )
  end

  def request_comment_email(user, comment)
    @comment = comment
    mail(
      :to      => user.email,
      :subject => I18n.t('admin.requests.mail.new_comment.subject', :request_id => comment.request_id)
    )
  end

end
