module EventAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      edit do
        configure :competition
      end
    end
  end
end
