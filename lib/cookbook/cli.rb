module Cookbook
  class CLI
    def initialize(argv)
      @argv = argv
    end
    
    def run
      parse_command_line_options
    end
    
    private
    
    def parse_command_line_options
      begin
        global_options.parse!(@argv)
      rescue OptionParser::InvalidOption => e
        puts e
        global_options.parse!(['-h'])
      end
    end
    
    def global_options
      OptionParser.new do |opts|
        opts.banner = 'Usage: cookbook [-v | --version] [-h | --help]'
        
        opts.on('-v', '--version', 'Display the version and exit') do
          puts "Version: #{VERSION}"
          exit
        end
        
        opts.on('-h', '--help', 'Display this help message') do
          puts opts
          exit
        end
        
        opts.on('-l', '--list', 'List the avaialable Cookbooks') do
          Library.new.cookbooks.each do |book|
            book.print
            puts
          end
        end
        
        opts.on('-u', '--update', 'Update all the cookbooks') do
          Library.new().update_library
          exit
        end
      end
    end
  end
end