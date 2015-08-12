# This is not the best example of "Single responsibility principle", is it?
module GitSemforcer
  # Class for modifying and detecting semver
  class Semver
    def initialize
      @semver = `git status -z .semver`.strip
    end

    def enforce
      if    none?     then semver_init
      elsif added?    # Nothing to do
      elsif modified? then ask_add_changes
      else  ask_increment
      end
    end

    # #
    # Get user input
    def ask_add_changes
      puts ".semver was modified. Add the file to the commit?\n[y|n]"
      add_to_git if gets.chomp =~ /^y$/i
    end

    def ask_increment
      puts "How big of an increment is this?\n[#{inc_opts.join('|')}]"
      inc = gets.chomp
      inc_opts.include?(inc) ? semver_inc(inc) : exit(0)
    end

    # #
    # Check status of semver file
    def none?
      !File.exist?(".semver")
    end

    def added?
      @semver =~ /(M|A)  .semver/
    end

    def modified?
      @semver =~ /(M|A) .semver/
    end

    private

      # #
      # Valid increment options
      def inc_opts
        %w(patch minor major none)
      end

      # #
      # Command line operations
      def add_to_git
        system("git add .semver")
      end

      def semver_init
        puts "Creating a new .semver file"
        system("semver init")
      end

      def semver_inc(inc)
        system("semver inc #{inc}")
        add_to_git
      end
  end
end
