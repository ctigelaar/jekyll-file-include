# Title: File Include
# Author: Christiaan Tigelaar <christiaan@sitemind.nl>
# Description: Custom plugin to include files outside the Jekyll document root
# See: http://wolfslittlestore.be/2013/10/rendering-markdown-in-jekyll/
#
# Syntax:
#
#   {% file_include file.ext %}
#
# Note:
# This module includes file from the working directory where _config.yml lives
# 

module Jekyll
  
  class FileIncludeTag < Liquid::Tag
    
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end

    require "kramdown"
    
    def render(context)
      tmpl = File.read(File.join(Dir.pwd, @text))
      site = context.registers[:site]
      tmpl = (Liquid::Template.parse tmpl).render site.site_payload
      html = Kramdown::Document.new(tmpl).to_html
    end

  end

end

Liquid::Template.register_tag('file_include', Jekyll::FileIncludeTag)