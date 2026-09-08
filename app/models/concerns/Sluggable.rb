module Sluggable
    extend ActiveSupport::Concern
    included do
        before_validation :generate_slug
    end
    class_methods do
        def find_by_slug!(slug)
            self.find_by!(slug:slug)
        end
    end
    def generate_slug
        self.slug = self.name.parameterize
    end
end