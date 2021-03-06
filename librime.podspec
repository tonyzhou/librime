Pod::Spec.new do |s|
  s.name         =  'librime'
  s.version      =  (require 'bbsp/smart_version'; BBSP::smart_version)
  s.license      =  ' BSD License'
  s.summary      =  'Rime Input Method Engine, the core library'
  s.homepage     =  'https://github.com/rime/librime.git'
  s.authors      =  'The Rime Authors'
  s.source       = { :git => 'https://github.com/rime/librime.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.prepare_command = <<-CMD
    (cd thirdparty/src/glog/ && sh autogen.sh && sh configure)
    cp -f thirdparty/src/leveldb/util/logging.cc thirdparty/src/leveldb/util/leveldb_logging.cc
    cp -f src/rime/algo/utilities.cc src/rime/algo/rime_utilities.cc
  CMD

  s.requires_arc = true
  s.libraries = 'c++'
  s.public_header_files = 'src/*.h'
  s.preserve_path = [
    'src',
    'thirdparty/include',
    'thirdparty/src/leveldb/db',
    'thirdparty/src/leveldb/port',
    'thirdparty/src/leveldb/table',
    'thirdparty/src/leveldb/util',
    'thirdparty/src/marisa-trie/lib',
    'thirdparty/src/marisa-trie/include',
    'thirdparty/src/glog/src'
  ]
  s.source_files = [
    'src/**/*.{h,c,cc,hpp,cpp,cxx}',
    'thirdparty/include/**/*.{h,c,cc,hpp,cpp,cxx}',
    'thirdparty/src/leveldb/db/*.{cc}',
    'thirdparty/src/leveldb/port/*.{cc}',
    'thirdparty/src/leveldb/table/*.{cc}',
    'thirdparty/src/leveldb/util/*.{cc}',
    'thirdparty/src/leveldb/include/leveldb/*.h',
    'thirdparty/src/marisa-trie/include/**/*.{h,c,cc,hpp,cpp,cxx}',
    'thirdparty/src/marisa-trie/lib/**/*.{h,c,cc,hpp,cpp,cxx}',
    'thirdparty/src/opencc/src/*.{hpp,cpp,h,c,cc}',
    'thirdparty/src/opencc/deps/darts-clone/**/*.{hpp,cpp,h,c,cc}',
    'thirdparty/src/opencc/deps/rapidjson-0.11/**/*.{hpp,cpp,h,c,cc}',
    'thirdparty/src/opencc/deps/tclap-1.2.1/**/*.{hpp,cpp,h,c,cc}',
    'thirdparty/src/yaml-cpp/src/**/*.{h,c,cc,hpp,cpp}',
    'thirdparty/src/yaml-cpp/include/**/*.{h,c,cc,hpp,cpp}',
    'thirdparty/src/glog/src/glog/*.h',
    'thirdparty/src/glog/src/demangle.cc',
    'thirdparty/src/glog/src/logging.cc',
    'thirdparty/src/glog/src/raw_logging.cc',
    'thirdparty/src/glog/src/signalhandler.cc',
    'thirdparty/src/glog/src/symbolize.cc',
    'thirdparty/src/glog/src/utilities.cc',
    'thirdparty/src/glog/src/vlog_is_on.cc'
  ]
  s.exclude_files = [
    'src/rime/algo/utilities.cc',
    'thirdparty/include/msvc/*.{h,c,cc,hpp,cpp,cxx}',
    'thirdparty/src/leveldb/**/*_test.cc',
    'thirdparty/src/leveldb/**/*_bench.cc',
    'thirdparty/src/leveldb/port/win',
    'thirdparty/src/opencc/src/*Test.{hpp,cpp}',
    'thirdparty/src/leveldb/util/env_windows*',
    'thirdparty/src/leveldb/db/leveldbutil.cc',
    'thirdparty/src/leveldb/util/logging.cc',
    'thirdparty/src/glog/src/windows/**/*'
  ]

  s.header_mappings_dir = 'src/'
  s.prefix_header_contents = '#define RIME_VERSION "1.3.0"', '#define RIME_EXTRA_MODULES', '#define RIME_ENABLE_LOGGING'
  s.pod_target_xcconfig = {
    'USE_HEADERMAP' => 'NO',
    'CC'  => 'clang',
    'CXX' => 'clang++',
    'HEADER_SEARCH_PATHS' => [
      '"' + File.dirname(__FILE__) + '/src' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/include/' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/leveldb/' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/leveldb/include/' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/marisa-trie/include/' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/opencc/deps/darts-clone' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/opencc/deps/rapidjson-0.11' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/opencc/deps/tclap-1.2.1' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/marisa-trie/lib/' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/opencc/src/' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/yaml-cpp/include/' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/yaml-cpp/src/' + '"',
      '"' + File.dirname(__FILE__) + '/thirdparty/src/glog/src/' + '"'
    ].join(' '),
    'OTHER_LDFLAGS' => '-lc++',
    'GCC_PREPROCESSOR_DEFINITIONS' => 'OS_MACOSX LEVELDB_PLATFORM_POSIX LEVELDB_IS_BIG_ENDIAN=0'
  }
  s.dependency 'boost'
end
