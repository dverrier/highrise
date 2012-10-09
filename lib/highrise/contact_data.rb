module Highrise
  class ContactData < Base
    def add_data name, attrs
      res = find_or_create_resource_for(name)
      plural = name.to_s.pluralize
      attributes[plural] ||= []
      attributes[plural] << res.new(attrs)
    end
  end
end

