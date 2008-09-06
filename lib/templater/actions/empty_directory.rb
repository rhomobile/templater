module Templater
  module Actions
    class EmptyDirectory < Action

      def initialize(generator, name, destination, options={})
        self.generator = generator
        self.name = name
        self.destination = destination
        self.options = options
      end

      # Returns the contents of the source file as a String
      #
      # === Returns
      # String:: The source file.
      def render
        ::File.read(source)
      end

      # Checks if the destination file already exists.
      #
      # === Returns
      # Boolean:: true if the file exists, false otherwise.
      def exists?
        ::File.exists?(destination)
      end
  
      # For empty directory this is in fact alias for exists? method.
      # 
      # === Returns
      # Boolean:: true if it is identical, false otherwise.
      def identical?
        exists?
      end
  
      # Renders the template and copies it to the destination.
      def invoke!
        @generator.send(@options[:before], self) if @options[:before]
        ::FileUtils.mkdir_p(destination)
        @generator.send(@options[:after], self) if @options[:after]
      end
    
      # removes the destination file
      def revoke!
        ::FileUtils.rm_rf(::File.expand_path(destination))
      end

    end # EmptyDirectory
  end # Actions
end # Templater
