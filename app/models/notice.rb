class Notice < ActiveRecord::Base
  enum notice_type: {
    general: 'general',
    covid19: 'covid19'
  }
end
