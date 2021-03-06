require 'nokogiri/xml/parse_options'
require 'nokogiri/xml/sax'
require 'nokogiri/xml/fragment_handler'
require 'nokogiri/xml/node'
require 'nokogiri/xml/namespace'
require 'nokogiri/xml/attr'
require 'nokogiri/xml/dtd'
require 'nokogiri/xml/cdata'
require 'nokogiri/xml/document'
require 'nokogiri/xml/document_fragment'
require 'nokogiri/xml/processing_instruction'
require 'nokogiri/xml/node_set'
require 'nokogiri/xml/syntax_error'
require 'nokogiri/xml/xpath'
require 'nokogiri/xml/xpath_context'
require 'nokogiri/xml/builder'
require 'nokogiri/xml/reader'
require 'nokogiri/xml/notation'
require 'nokogiri/xml/entity_declaration'
require 'nokogiri/xml/schema'
require 'nokogiri/xml/relax_ng'

module Nokogiri
  class << self
    ###
    # Parse an XML file.  +thing+ may be a String, or any object that
    # responds to _read_ and _close_ such as an IO, or StringIO.
    # +url+ is resource where this document is located.  +encoding+ is the
    # encoding that should be used when processing the document. +options+
    # is a number that sets options in the parser, such as
    # Nokogiri::XML::PARSE_RECOVER.  See the constants in
    # Nokogiri::XML.
    def XML thing, url = nil, encoding = nil, options = 1, &block
      Nokogiri::XML.parse(thing, url, encoding, options, &block)
    end
  end

  module XML
    class << self
      ###
      # Parse an XML document using the Nokogiri::XML::Reader API.  See
      # Nokogiri::XML::Reader for mor information
      def Reader string_or_io, url = nil, encoding = nil, options = 0

        options = Nokogiri::XML::ParseOptions.new(options) if Fixnum === options
        # Give the options to the user
        yield options if block_given?

        if string_or_io.respond_to? :read
          return Reader.from_io(string_or_io, url, encoding, options.to_i)
        end
        Reader.from_memory(string_or_io, url, encoding, options.to_i)
      end

      ###
      # Parse an XML document.  See Nokogiri.XML.
      def parse string_or_io, url = nil, encoding = nil, options = 2145, &block

        options = Nokogiri::XML::ParseOptions.new(options) if Fixnum === options
        # Give the options to the user
        yield options if block_given?

        if string_or_io.respond_to?(:read)
          url ||= string_or_io.respond_to?(:path) ? string_or_io.path : nil
          return Document.read_io(string_or_io, url, encoding, options.to_i)
        end

        # read_memory pukes on empty docs
        return Document.new if string_or_io.nil? or string_or_io.empty?

        Document.read_memory(string_or_io, url, encoding, options.to_i)
      end

      ###
      # Sets whether or not entities should be substituted.
      def substitute_entities=(value = true)
        Document.substitute_entities = value
      end

      ###
      # Sets whether or not external subsets should be loaded
      def load_external_subsets=(value = true)
        Document.load_external_subsets = value
      end
    end
  end
end
