require 'pathname'

module SendIssueReplyEmail
  def self.root
    @root ||= Pathname.new File.expand_path('..', File.dirname(__FILE__))
  end

  def self.load_patches
    Dir[root.join('app/patches/**/*_patch.rb')].each { |f| require_dependency f }
  end
end


# Load patches at startup and reload them on each prepare
SendIssueReplyEmail.load_patches
Rails.configuration.to_prepare { SendIssueReplyEmail.load_patches }

# Load hooks
Dir[SendIssueReplyEmail.root.join('app/hooks/*_hook.rb')].each {|f| require_dependency f }
