require_dependency 'mail_handler'

module SendIssueReplyEmail
  module MailHandlerPatch
    extend ActiveSupport::Concern
    unloadable

    included do
      unloadable

      private

        def receive_issue(*args, &block)
          issue = super
          EmailAddressOfIssueReply.create_by_received_mail(issue.id, email)
          issue
        end

        def receive_issue_reply(issue_id, from_journal = nil, *args, &block)
          journal = super
          EmailAddressOfIssueReply.create_by_received_mail(issue_id, email)
          journal
        end
    end

  end
end

SendIssueReplyEmail::MailHandlerPatch.tap do |mod|
  MailHandler.prepend mod
end

# Zeitwerk expects MailHandlerPatch for this path
MailHandlerPatch = SendIssueReplyEmail::MailHandlerPatch
