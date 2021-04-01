CC = `xcrun -find clang`.strip

def sdk_path(device); `xcrun --sdk #{device} --show-sdk-path`.strip end
IOS_FLAGS = %W(-Os -arch armv7 -arch arm64 -arch arm64e -fembed-bitcode -isysroot #{sdk_path 'iphoneos'})
IOSSIM_FLAGS = %W(-Os -arch i386 -arch x86_64 -fembed-bitcode -isysroot #{sdk_path 'iphonesimulator'})

MRuby::Build.new do |conf|
  toolchain :clang
  conf.gembox 'default'
end

MRuby::CrossBuild.new('ios') do |conf|
  conf.gembox 'default'

  conf.cc do |cc|
    cc.command = CC
    cc.flags = IOS_FLAGS
  end

  conf.linker do |linker|
    linker.command = CC
    linker.flags = IOS_FLAGS
  end
end

MRuby::CrossBuild.new('ios-simulator') do |conf|
  conf.gembox 'default'

  conf.cc do |cc|
    cc.command = CC
    cc.flags = IOSSIM_FLAGS
  end

  conf.linker do |linker|
    linker.command = CC
    linker.flags = IOSSIM_FLAGS
  end
end
