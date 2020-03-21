class SetTypeOnAllNotices < ActiveRecord::Migration
  def change
    Notice.transaction do
      Notice.all.update_all(notice_type: :general)
    end
  end
end
