CC = `xcrun -find clang`.strip

def sdk_path(device); `xcrun --sdk #{device} --show-sdk-path`.strip end

IOS_ARCHS = %W(armv7 arm64 arm64e)
IOSSIM_ARCHS = %W(i386 x86_64)

MRuby::Build.new do |conf|
  toolchain :clang
  conf.gembox 'default'
end

IOS_ARCHS.each do |arch|
  flags = %W(-Os -fembed-bitcode -isysroot #{sdk_path 'iphoneos'})
  flags << "-arch"
  flags << arch
  MRuby::CrossBuild.new(arch) do |conf|
    conf.gembox 'default'

    conf.cc do |cc|
      cc.command = CC
      cc.flags = flags
    end
  
    conf.linker do |linker|
      linker.command = CC
      linker.flags = flags
    end
  end
  
end

IOSSIM_ARCHS.each do |arch|
  flags = %W(-Os -fembed-bitcode -isysroot #{sdk_path 'iphonesimulator'})
  flags << "-arch"
  flags << arch
  MRuby::CrossBuild.new(arch) do |conf|
    conf.gembox 'default'
    
    conf.cc do |cc|
      cc.command = CC
      cc.flags = flags
    end
  
    conf.linker do |linker|
      linker.command = CC
      linker.flags = flags
    end
  end

end





