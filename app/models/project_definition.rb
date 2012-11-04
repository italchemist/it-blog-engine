class ProjectDefinition
  attr_reader :id
  attr_reader :name
  attr_reader :date
  attr_reader :published

  # initializes new instance of te article
  # definition using specified definition
  def initialize(definition)
    process_metadata(definition)
  end

  private

  def process_metadata(metadata)
    tags = metadata.split("\r\n")
    tags.each{ |tag| process_metadata_tag(tag) }
  end

  def process_metadata_tag(tag)
    delimiter_pos = tag.index(":")
    tag_name  = tag[0..delimiter_pos-1].strip
    tag_value = tag[delimiter_pos+1..-1].strip
    process_tag(tag_name, tag_value)
  end

  def process_tag(tag, value)
    @id = value if tag == "id"
    @name = value if tag == "name"
    @date = value if tag == "date"
    @published = value if tag == "published"
  end
end
