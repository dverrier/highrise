module Highrise
  class Subject < Base
    def notes
      Note.find_all_across_pages(:from => "/#{self.class.collection_name}/#{id}/notes.xml")
    end

    def add_note(attrs={})
      attrs[:subject_id] = self.id
      attrs[:subject_type] = self.label
      Note.create attrs
    end
    
    def add_task(attrs={})
      attrs[:subject_id] = self.id
      attrs[:subject_type] = self.label
      Task.create attrs
    end

    def emails
      Email.find_all_across_pages(:from => "/#{self.class.collection_name}/#{id}/emails.xml")
    end

    def upcoming_tasks
      Task.find(:all, :from => "/#{self.class.collection_name}/#{id}/tasks.xml")
    end
    
    def label
      self.class.name.split('::').last
    end
    
    def custom_fields
      @custom_fields ||= CustomFields.new(self)
    end

    # unless we clear subject_datas, deleted custom fields will remain
    def reload
      attributes.delete :subject_datas
      super
    end
    class CustomFields
      def initialize owner
        @owner = owner
      end
      
      # note that when the model is saved, the SubjectData fields are not updated with IDs
      # so in order to delete a custom field it is necessary to first reload the model
      def []= name, value
        value = value.to_s
        if existing = find_subject_data(name)
          if value.empty? && existing.attributes[:id]
            # this is how values are deleted in highrise
            existing.id = -existing.id
            value = nil
          elsif !value.empty? && existing.attributes[:id] && existing.attributes[:id] < 0
            # if we marked it for deletion, and it now has a value, unmark it
            existing.id = -existing.id
          end
          existing.value = value
        else
          raise "unknown custom field #{name}" unless subject_field_id(name)
          if not @owner.attributes[:subject_datas]
            @owner.subject_datas = []
          end
          @owner.subject_datas << SubjectData.new(
                                    :subject_field_label => name, 
                                    :value => value,
                                    :subject_field_id => subject_field_id(name)
                                  )
        end
      end
      
      def [] name
        val = find_subject_data(name)
        val && val.value
      end

      def to_hash
        (@owner.attributes[:subject_datas] || []).inject({}){|acc, el| 
          acc[el.subject_field_label] = el.value
          acc
        }
      end
      alias :to_h :to_hash

      def inspect
        "<#{self.class.name} #{to_hash.inspect}>"
      end

      private
      def find_subject_data name
        return nil unless @owner.attributes[:subject_datas]
        @owner.subject_datas.detect {|sd| sd.subject_field_label == name }
      end
      def subject_field_id name
        # use user set cache if present
        return Highrise::Base.subject_field_ids[name] if Highrise::Base.subject_field_ids[name]
        @@sfids ||= Highrise::SubjectField.all.inject({}){|h,k| h[k.label] = k.id; h}
        @@sfids[name]
      end
    end
  end
end
