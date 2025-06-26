Redmine::Plugin.register :redmine_send_issue_reply_email do
  name 'Redmine Send Issue Reply Email'
  author 'Matsukei Co.,Ltd'
<<<<<<< 5db1lo-codex/make-plugin-compatible-with-redline-5.1.1
  description 'Adds "send issue reply" e-mail functionality to Redmine.'
=======
  description 'It is a plugin that provides the email sending feature to non Redmine users when registering notes.'
>>>>>>> master
  version '1.1.0'
  requires_redmine version_or_higher: '5.1.1'
  url 'https://github.com/matsukei/redmine_send_issue_reply_email'
  author_url 'http://www.matsukei.co.jp/'

  project_module :send_issue_reply_email do
    permission :manage_email_delivery_setting, {
      email_delivery_setting_of_issue_replies: [
        :edit, :test_email
      ]
    }, require: :member
  end

end

require_relative 'lib/send_issue_reply_email'

# Ensure patches are reapplied on each reload
Rails.configuration.to_prepare do
  require_relative 'lib/send_issue_reply_email'

  if defined?(SendIssueReplyEmail::ProjectPatch) &&
     !Project.included_modules.include?(SendIssueReplyEmail::ProjectPatch)
    Project.include SendIssueReplyEmail::ProjectPatch
  end
end
