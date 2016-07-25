module ConfigureExtensions
  class ConfigureCommand
    # If you want to use this as a standalone script without the Gem,
    # run `sudo gem install xcodeproj` to install the required dependency
    # copy the contents of the method below, and configure the four argument
    # variables before everything else
    def self.configure mode, project_file, app_target_name, extension_names
      require 'xcodeproj'

      # Find project and app target

      xc = Xcodeproj::Project.open(project_file)
      app_target = xc.targets.find { |t| t.name == app_target_name }

      # Find app extensions' target objects

      extension_targets = extension_names.map do |ext|
        target = xc.targets.find { |t| t.name == ext }
        abort "Couldn't find a '#{ext}' target in '#{project_name}'" if target.nil?
        abort "'#{ext}' doesn't seem to be an application extension target" unless target.product_type.include? 'app-extension'
        target
      end

      # Find .appex product files

      extension_products = extension_targets.map { |target| target.product_reference }

      # Add or remove dependency on extension targets

      extension_targets.each do |target|
        dependency = app_target.dependency_for_target(target)

        if mode == :add
          if dependency
            puts "[WARN] App already has dependency on #{target.name}"
          else
            app_target.add_dependency(target)
          end
        else
          if dependency
            app_target.dependencies.delete(dependency)
          else
            puts "[WARN] Couldn't find dependency on #{target.name}"
          end
        end
      end

      # Add or remove .appex copy jobs

      embed_extensions_phase = app_target.copy_files_build_phases.find do |copy_phase|
        copy_phase.symbol_dst_subfolder_spec == :plug_ins
      end

      abort "Couldn't find 'Embed App Extensions' phase" if embed_extensions_phase.nil?

      extension_products.each do |appex|
        appex_included = embed_extensions_phase.files_references.include? appex

        if mode == :add
          if appex_included
            puts "[WARN] App already embeds #{appex.display_name}"
          else
            build_file = embed_extensions_phase.add_file_reference(appex)
            build_file.settings = { "ATTRIBUTES" => ['RemoveHeadersOnCopy'] }
          end
        else
          if appex_included
            embed_extensions_phase.remove_file_reference(appex)
          else
            puts "[WARN] App doesn't seem to embed #{appex.display_name}"
          end
        end
      end

      # Save changes

      xc.save()

      puts "Done"
    end
  end
end
