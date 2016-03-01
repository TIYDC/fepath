class Path
  include ActiveModel::Dirty
  define_attribute_methods :id, :title, :cohort_id, :topic, :description, :type

end
