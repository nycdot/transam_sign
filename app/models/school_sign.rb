class SchoolSign < Sign

  # Callbacks
  after_initialize :set_defaults

  # set the default scope
  default_scope where(:asset_type_id => AssetType.find_by_class_name(self.name).id)

  # search scope
  #scope :search_query, lambda {|organization, search_text| {:conditions => [Asset.get_search_query_string(get_searchable_fields), {:organization_id => organization.id, :search => search_text }]}}

  protected

  # Set resonable defaults for a new regulatory sign
  def set_defaults
    super
    self.asset_type_id ||= AssetType.find_by_class_name(self.name).id
  end

end
