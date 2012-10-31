class ArticleDefinition
  attr_reader :id
  attr_reader :title
  attr_reader :content
  attr_reader :tags
  attr_reader :date
  attr_reader :published

  # initializes new instance of te article
  # definition using specified data
  def initialize(definition)
  	delimiter_pos = definition.index("\r\n\r\n")
  	metadata = definition[0..delimiter_pos]
  	content  = definition[delimiter_pos..-1]

  	# process the definition
  	process_metadata(metadata)
  	process_content(content)
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

  def process_content(text)
    # process markdown
    renderer = Redcarpet::Render::HTML.new(
    	:filter_html => true)
    markdown = Redcarpet::Markdown.new(renderer,
    	:autolink => true, :space_after_headers => true,
    	:fenced_code_blocks => true)
    @content = markdown.render(text)

    # syntax highlight
    doc = Nokogiri::HTML(@content)
    doc.search("pre > code[class]").each do |pre|
      code     = CodeRay.scan(pre.text.rstrip, pre[:class]).div
      code_doc = Nokogiri::HTML(code)
      pre.replace code_doc.css(".code").to_html
    end
    @content = doc.to_s
  end

  def process_tag(tag, value)
  	@id = value if tag == "id"
  	@title = value if tag == "title"
  	@tags = value.split(",").map{ |tag| tag.strip } if tag == "tags"
  	@date = value if tag == "date"
  	@published = value if tag == "published"
  end
end
