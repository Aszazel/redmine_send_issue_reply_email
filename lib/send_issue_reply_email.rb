require 'pathname'

module SendIssueReplyEmail
  def self.root
    @root ||= Pathname.new File.expand_path('..', File.dirname(__FILE__))
  end

  def self.load_patches
    Dir[File.join(root.to_s, 'app', 'patches', '**', '*_patch.rb')].each do |f|
      require_dependency f
    end

  end
end


# Load patches at startup and reload them on each prepare
SendIssueReplyEmail.load_patches
Rails.configuration.to_prepare { SendIssueReplyEmail.load_patches }

# Load hooks
Dir[SendIssueReplyEmail.root.join('app/hooks/*_hook.rb')].each {|f| require_dependency f }
