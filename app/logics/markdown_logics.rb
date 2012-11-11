class MarkdownLogics
  # Renders specified markdown into html.
  # Source code will be highlighted.
  def self.render(text)
    # process markdown
    renderer = Redcarpet::Render::HTML.new(
      :filter_html => true)
    markdown = Redcarpet::Markdown.new(renderer,
      :autolink => false, :space_after_headers => true,
      :fenced_code_blocks => true)
    content = markdown.render(text)

    # syntax highlight
    doc = Nokogiri::HTML(content)
    doc.search("pre > code[class]").each do |pre|
      code     = CodeRay.scan(pre.text.rstrip, pre[:class]).div
      code_doc = Nokogiri::HTML(code)
      pre.replace code_doc.css(".code > pre").children.to_html
    end
    content = doc.css("body").inner_html

    content = content.gsub(/\[@image:(\S+)\]/) { |m| "<center><img src='/images/#{$1}'/></center>" }
    content = content.gsub(/\[@link:(\S+)\|(.+)\]/) { |m| "<a href='http://#{$1}'>#{$2}</a>" }
    content = content.gsub(/\[@article:(\S+)\|(.+)\]/) { |m| "<a href='/articles/#{$1}'>#{$2}</a>" }
    content = content.gsub(/\[@project:(\S+)\|(.+)\]/) { |m| "<a href='/projects/#{$1}'>#{$2}</a>" }
    content = content.gsub(/\[@github:(\S+)\|(.+)\]/) { |m| "<a href='http://www.github.com/#{$1}'>#{$2}</a>" }
    content = content.gsub(/\[@youtube:(\S+)\]/) { |m| "<center><iframe width='853' height='480' src='http://www.youtube.com/embed/#{$1}?rel=0' frameborder='0' allowfullscreen></iframe></center>" }

    content
  end
end