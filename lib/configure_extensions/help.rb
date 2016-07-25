module ConfigureExtensions
  class HelpCommand
    def self.help
      puts "configure_extensions <mode> <project> <app_target> <extensions...>"
      puts
      puts "Add and remove app extensions from Xcode build"
      puts
      puts "mode"
      puts "   add    - enables passed app extension targets"
      puts "   remove - disables extensions from being built and embedded in the app"
      puts
      puts "project"
      puts "   path to the Xcode project file"
      puts
      puts "app_target"
      puts "   name of the main (app) target in which extensions are to be enabled/disabled"
      puts
      puts "extensions"
      puts "   names of app extension targets to be enabled/disabled"
      puts
      puts "EXAMPLES"
      puts
      puts "configure_extensions add MyApp.xcodeproj MyApp NotificationsUI Share"
      puts "configure_extensions remove Foo.xcodeproj Foo-iOS Share"
      puts
    end
  end
end
