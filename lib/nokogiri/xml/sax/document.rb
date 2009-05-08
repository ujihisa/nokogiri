module Nokogiri
  module XML
    ###
    # SAX Parsers are event driven parsers.  Nokogiri provides two different
    # event based parsers when dealing with XML.  If you want to do SAX style
    # parsing using HTML, check out Nokogiri::HTML::SAX.
    #
    # The basic way a SAX style parser works is by creating a parser,
    # telling the parser about the events we're interested in, then giving
    # the parser some XML to process.  The parser will notify you when
    # it encounters events your said you would like to know about.
    #
    # To register for events, you simply subclass Nokogiri::XML::SAX::Document,
    # and implement the methods for which you would like notification.
    #
    # For example, if I want to be notified when a document ends, and when an
    # element starts, I would write a class like this:
    #
    #   class MyDocument < Nokogiri::XML::SAX::Document
    #     def end_document
    #       puts "the document has ended"
    #     end
    #
    #     def start_element name, attributes = []
    #       puts "#{name} started"
    #     end
    #   end
    #
    # Then I would instantiate a SAX parser with this document, and feed the
    # parser some XML
    #
    #   # Create a new parser
    #   parser = Nokogiri::XML::SAX::Parser.new(MyDocument.new)
    #
    #   # Feed the parser some XML
    #   parser.parse(File.read(ARGV[0], 'rb'))
    #
    # Now my document handler will be called when each node starts, and when
    # then document ends.  To see what kinds of events are available, take
    # a look at Nokogiri::XML::SAX::Document.
    #
    # Two SAX parsers for XML are available, a parser that reads from a string
    # or IO object as it feels necessary, and a parser that lets you spoon
    # feed it XML.  If you want to let Nokogiri deal with reading your XML,
    # use the Nokogiri::XML::SAX::Parser.  If you want to have fine grain
    # control over the XML input, use the Nokogiri::XML::SAX::PushParser.
    module SAX
      ###
      # This class is used for registering types of events you are interested
      # in handling.  All of the methods on this class are available as
      # possible events while parsing an XML document.  To register for any
      # particular event, just subclass this class and implement the methods
      # you are interested in knowing about.
      #
      # To only be notified about start and end element events, write a class
      # like this:
      #
      #   class MyDocument < Nokogiri::XML::SAX::Document
      #     def start_element name, attrs = []
      #       puts "#{name} started!"
      #     end
      #
      #     def end_element name
      #       puts "#{name} ended"
      #     end
      #   end
      #
      # You can use this event handler for any SAX style parser included with
      # Nokogiri.  See Nokogiri::XML::SAX, and Nokogiri::HTML::SAX.
      class Document
        ###
        # Called when document starts parsing
        def start_document
        end

        ###
        # Called when document ends parsing
        def end_document
        end

        ###
        # Called at the beginning of an element
        # +name+ is the name of the tag with +attrs+ as attributes
        def start_element name, attrs = []
        end

        ###
        # Called at the end of an element
        # +name+ is the tag name
        def end_element name
        end

        ###
        # Characters read between a tag
        # +string+ contains the character data
        def characters string
        end

        ###
        # Called when comments are encountered
        # +string+ contains the comment data
        def comment string
        end

        ###
        # Called on document warnings
        # +string+ contains the warning
        def warning string
        end

        ###
        # Called on document errors
        # +string+ contains the error
        def error string
        end

        ###
        # Called when cdata blocks are found
        # +string+ contains the cdata content
        def cdata_block string
        end

        ###
        # Called when an entity declaration is encountered.
        # +name+ is the entity name
        # +type+ is the entity type
        # +public_id+ is the public ID of the entity
        # +system_id+ is the system ID of the entity
        # +content+ is the entyti value (without processing)
        def entity_declaration name, type, public_id, system_id, content
        end

        ###
        # Called when a notation declaration is encountered.
        # +name+ is the name of the notation
        # +public_id+ is the public ID of the entity
        # +system_id+ is the system ID of the entity
        def notation_declaration name, public_id, system_id
        end

        ###
        # Called when an attribute declaration is parsed
        # +element_name+ is the name of the element
        # +attribute_name+ is the name of the attribute declared
        # +type+ is the type of attribute
        # +default_type+ is the default value type for the attribute
        # +default_value+ is the default value for the attribute
        # +value_set+ is a list of possible values (may be empty)
        def attribute_declaration element_name, attribute_name, type, default_type, default_value, value_set
        end

        ###
        # Called when parsing an internal subset declaration
        # +name+ is the root element name
        # +external_id+ is the external id
        # +system_id+ is the system id, filename or URL
        def internal_subset name, external_id, system_id
        end
      end
    end
  end
end
