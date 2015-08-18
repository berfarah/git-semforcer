# This is not the best example of "Single responsibility principle", is it?
module GitSemverCop
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
      puts "How big of an increment is this? (semver: M.m.p)\n"\
           "[n] none (default)\n[p] patch\n[m] minor\n[M] Major"
      inc = gets.chomp
      val = %w(none patch minor Major).find { |v| v =~ /^#{inc[0]}/ }
      val == "none" ? exit(0) : semver_inc(val)
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
