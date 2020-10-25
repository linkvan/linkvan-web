module ApplicationHelper
    def lastUpdate
        @notice = Notice.covid19.where(published: true).last.updated_at.strftime("%b %-d, %Y")
      end
end
