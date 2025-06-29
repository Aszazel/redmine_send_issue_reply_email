module SendIssueReplyEmail
  class IssueControllerHooks < Redmine::Hook::Listener
    def controller_issues_edit_after_save(context = {})
      params, issue, time_entry, journal = context.values_at(:params, :issue, :time_entry, :journal)

      if params['is_send_email'].to_i == 1 && journal.notes.present?
        IssueReplyMailer.notification(User.current, issue, journal).deliver_now
      end
    end

  end
end

# Zeitwerk expects IssueControllerHook for this path
IssueControllerHook = SendIssueReplyEmail::IssueControllerHooks
