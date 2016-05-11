require 'json'
require 'active_support'
require 'active_support/core_ext'
require 'rack'
require 'pry'

class AttributeExtractor
  attr_reader :page, :klass
  REJECT_ARGS = %w(utf8 _method authenticity_token commit).freeze
  LINK_REGEX = /\[([^\]]+)\]\(([^)]+)\)/
  ATTACHMENT_HOST = 'tiy-learn-content.s3.amazonaws.com'.freeze

  def initialize(page, klass, attributes = {})
    @page = page
    @attributes = attributes.merge("type" => klass)
    @klass = klass.downcase
  end

  def extract
    @attributes.merge!(extract_react)
    @attributes.merge!(extract_inputs)
    @attributes.merge!(extract_selects)
    @attributes.merge!(extract_textareas)
    @attributes = @attributes.except(*REJECT_ARGS)
    @attributes = unrailsify
    klass_args  = @attributes.delete(klass)
    @attributes = klass_args.merge(@attributes)
    extract_attachments
    { klass => @attributes }
  end

  private

  def unrailsify
    qs_array = @attributes.map { |k, v| "#{k}=#{CGI.escape(v || '')}" }
    Rack::Utils.parse_nested_query(qs_array.join('&'))
  end

  def extract_attachments
    return nil unless @attributes['body']
    @attributes['attachments'] =  @attributes['body'].to_s.scan(LINK_REGEX).select do |name, link|
      begin
        ATTACHMENT_HOST == URI.parse(link.strip.gsub("\"", "")).host
      rescue
        puts "Possible Bad Link: #{name} | #{link}"
      end
    end
  end

  def extract_inputs
    page.search('input').map { |i| [i.attr('name'), i.attr('value').to_s.strip] }.to_h
  end

  def extract_selects
    page.search('select').map { |i| [i.attr('name'), i.search('option[@selected="selected"]').first&.attr('value').to_s.strip] }.to_h
  end

  def extract_react
    page.search('[data-react-class="ContentEditor"]').map do |el|
      data = JSON.parse(el.attr('data-react-props'))
      [data['name'], data['initialValue'].strip]
    end.to_h
  end

  def extract_textareas
    page.search('textarea').map { |i| [i.attr('name'), i.text.strip] }.to_h
  end
end
