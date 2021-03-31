mruby_version = '3.0.0'
exclude_headers = ['debug.h', 'boxing_no.h', 'boxing_nan.h', 'boxing_word.h', 'opcode.h', 'ops.h']

task default: 'build_mruby'

desc 'Clean the project build files'
task :clean do
  puts ">>>>>>> clean task"
#  FileUtils.remove_dir 'ios/MRuby.framework', true
  FileUtils.remove_dir 'mruby/build', true
  FileUtils.remove_dir 'Headers', true
  FileUtils.remove_dir 'Modules', true
  FileUtils.rm 'mruby-umbrella.h' if File.exist? 'mruby-umbrella.h'
end

desc 'Generate headers'
task :generate_headers do
  puts ">>>>>>> generate headers"
  FileUtils.remove_dir 'Headers', true
  FileUtils.cp_r 'mruby/include/.', './Headers'
  Dir.chdir('Headers') do 
    FileUtils.cp_r 'mruby/.', '.'
    FileUtils.remove_dir 'mruby', true

    Dir.glob('*.h') do |header_file|
      content = File.read(header_file).gsub('<mruby.h>', '<mruby/mruby.h>')
      File.open(header_file, "w") { |f| f.puts content}
      # content = File.open(header_file).read
      # content = content.gsub!(/\<mruby\/(.+)\>/,'"\1"')
      File.open(header_file, 'w') do |file|
        file.puts(content)
      end
    end
  end
end

desc 'Generate modulemap'
task :generate_modulemap do
  puts ">>>>>>> generate modulemap"
  # generate umbrella header
  File.open "mruby-umbrella.h", "w" do |file|
    file.puts '#import <Foundation/Foundation.h>'
    file.puts '#import "mruby.h"'
    Dir.chdir "Headers" do 
      Dir["**/*.h"].each do |f|
        next if exclude_headers.include?(f)
        next if f == 'mruby.h'
        file.puts "#import \"#{f}\""
      end
    end
    file.puts 'FOUNDATION_EXPORT double MRubyVersionNumber;'
    file.puts 'FOUNDATION_EXPORT const unsigned char MRubyVersionString[];'
  end

  #generate modulemap
  Dir.mkdir "Modules"
  File.open "Modules/module.modulemap", "w" do |file|
    file.puts 'framework module MRuby {'
    file.puts 'umbrella header "mruby-umbrella.h"'
    exclude_headers.each {|header| file.puts "exclude header \"#{header}\""}
    file.puts 'export *'
    file.puts 'module * { export * }'
    file.puts '}'
  end

end

desc 'Build MRuby for iOS support module'
task :build_mruby => [:clean, :generate_headers, :generate_modulemap] do
  puts ">>>>>>> build_mruby task"
  Dir.chdir('mruby') do
    ENV['MRUBY_CONFIG'] = '../build_config.rb'
    system 'rake'

    Dir.chdir('build') do
      FileUtils.mkdir_p 'ios-universal'
      `lipo armv7/lib/libmruby.a arm64/lib/libmruby.a arm64e/lib/libmruby.a x86_64/lib/libmruby.a i386/lib/libmruby.a -create -output ios-universal/libmruby.a`
    end
  end

  FileUtils.mkdir_p 'ios/MRuby.framework/Headers'
  #FileUtils.cp_r 'mruby/include/.', 'ios/MRuby.framework/Headers'
  FileUtils.cp 'mruby/build/armv7/include/mruby/presym/id.h', 'Headers/presym'
  FileUtils.cp 'mruby/build/armv7/include/mruby/presym/table.h', 'Headers/presym'
  FileUtils.cp_r 'Headers/.', 'ios/MRuby.framework/Headers'
  FileUtils.cp 'Info.plist', 'ios/MRuby.framework'
  FileUtils.cp 'mruby/build/ios-universal/libmruby.a', 'ios/MRuby.framework/MRuby'
  FileUtils.cp_r 'Modules/.', 'ios/MRuby.framework/Modules'
  FileUtils.cp 'mruby-umbrella.h', 'ios/MRuby.framework/Headers'
  puts "sucess!!!"
end

desc 'Set MRuby submodule to latest release'
task :mruby_latest do
  system 'git submodule update --remote && '\
         'cd mruby && '\
         "git checkout tags/#{mruby_version}"
end

desc 'Set MRuby submodule to master branch'
task :mruby_master do
  system 'git submodule update --remote && '\
         'cd mruby && '\
         'git checkout master && '\
         'git pull --rebase'
end
