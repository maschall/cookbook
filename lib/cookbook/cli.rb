module Cookbook
  class CLI
    include Subcommands
    def initialize(argv)
      @argv = argv
      @options = OpenStruct.new
    end
    
    def run
      parse_command_line_options
      # DO THE REST
    end
    
    private
    
    def parse_command_line_options
      global_options do |opts|
        opts.banner = 'Usage: cookbook [-v | --version] <command> [<args>]'
        opts.on('-v', '--version', 'Display the version and exit') do
          puts "Version: #{Cookbook::VERSION}"
          exit
        end
        add_help_option
      end
      
      command :library do |opts|
        opts.banner = "Usage: library <options>"
        opts.on('-a', '--add', 'Add a cookbook library') do |library|
          @options.action = :library_add
          @options.action_args = library
        end
      end
      
      begin
        opt_parse(@argv)
      rescue OptionParser::InvalidOption => e
        puts e
      end
    end
  end
end