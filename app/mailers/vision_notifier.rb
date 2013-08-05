class VisionNotifier < ActionMailer::Base
  default from: 'Sam Ruby <depot@example.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.vision_notifier.published.subject
  #
  def published(vision)
    @vision = vision
    @user = User.find(@vision.publisher)

    mail to: vision.email, subject: 'Pragmatic Store Vision Disposed'
  end
end
