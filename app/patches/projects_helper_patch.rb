require_dependency 'projects_helper'

module SendIssueReplyEmail
  module ProjectsHelperPatch
    unloadable

    def project_settings_tabs
      tabs = super

      if User.current.allowed_to?(:manage_email_delivery_setting, @project) &&
          @project.module_enabled?(:send_issue_reply_email)

        tabs << {
          name: 'email_delivery_setting_of_issue_reply',
          action: :manage_email_delivery_setting,
          partial: 'projects/settings/email_delivery_setting_of_issue_reply',
          label: :label_send_issue_reply_email
        }
      end

      tabs
    end

  end
end

SendIssueReplyEmail::ProjectsHelperPatch.tap do |mod|
  ProjectsHelper.prepend mod
end

# Zeitwerk expects ProjectsHelperPatch for this path
ProjectsHelperPatch = SendIssueReplyEmail::ProjectsHelperPatch
