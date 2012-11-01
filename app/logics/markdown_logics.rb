class MarkdownLogics
  # Renders specified markdown into html.
  # Source code will be highlighted.
  def self.render(text)
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
      pre.replace code_doc.css(".code > pre").children.to_html
    end
    @content = doc.css("body").inner_html
  end
end