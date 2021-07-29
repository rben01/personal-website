class MyPygmentsAdapter < (Asciidoctor::SyntaxHighlighter.for 'pygments')
	register_for :pygments

	def docinfo? location
		true
	end

	def docinfo location, doc, opts
		slash = opts[:self_closing_tag_slash]
		%(<link rel="stylesheet" href="/styles/syntax-theme.css"#{slash}>)
	end
  end
