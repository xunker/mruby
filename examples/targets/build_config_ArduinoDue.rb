MRuby::Build.new do |conf|

  # Gets set by the VS command prompts.
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end

  enable_debug

  # include the default GEMs
  conf.gembox 'default'

end

# Cross Compiling configuration for Arduino Due
# http://arduino.cc/en/Main/ArduinoBoardDue
#
# Requires Arduino IDE >= 1.5
MRuby::CrossBuild.new("ArduinoDue") do |conf|
  toolchain :gcc

  # Mac OS X, Arduino IDE <= 1.5.6
  # ARDUINO_PATH = '/Applications/Arduino.app/Contents/Resources/Java'
  # Mac OS X, Arduino IDE >= 1.5.7
  ARDUINO_PATH = '/Applications/Arduino.app/Contents/Java'
  # GNU Linux
  # ARDUINO_PATH = '/opt/arduino'
   # Arduino IDE <= 1.5.6
  # BIN_PATH = "#{ARDUINO_PATH}/hardware/tools/g++_arm_none_eabi/bin"
  # Arduino IDE >= 1.5.7
  # BIN_PATH = "#{ARDUINO_PATH}/hardware/tools/gcc-arm-none-eabi-4.8.3-2014q1/bin"
  # Arduino IDE >= 1.6.x
  BIN_PATH = "/Users/mnielsen/Library/Arduino15/packages/arduino/tools/arm-none-eabi-gcc/4.8.3-2014q1/bin"
  # SAM_PATH = "#{ARDUINO_PATH}/hardware/arduino/sam"
  SAM_PATH = "/Users/mnielsen/Library/Arduino15/packages/arduino/hardware/sam/1.6.11"
  # TARGET_PATH = "#{SAM_PATH}/variants/arduino_due_x"
  TARGET_PATH = "#{SAM_PATH}/variants/arduino_due_x"

  conf.cc do |cc|
    cc.command = "#{BIN_PATH}/arm-none-eabi-gcc"
    cc.include_paths << ["#{SAM_PATH}/system/libsam", "#{SAM_PATH}/system/CMSIS/CMSIS/Include/",
                        "#{SAM_PATH}/system/CMSIS/Device/ATMEL/",
                        "#{SAM_PATH}/cores/arduino", "#{SAM_PATH}/libraries","#{TARGET_PATH}"]
    cc.flags = %w(-g -Os -w -ffunction-sections -fdata-sections -nostdlib --param max-inline-insns-single=500
                -Dprintf=iprintf -mcpu=cortex-m3 -DF_CPU=84000000L -DARDUINO=156 -DARDUINO_SAM_DUE -DARDUINO_ARCH_SAM
                -D__SAM3X8E__ -mthumb -DUSB_PID=0x003e -DUSB_VID=0x2341 -DUSBCON -DUSB_MANUFACTURER="Unknown" -DUSB_PRODUCT="Arduino Due")
    cc.compile_options = "%{flags} -o %{outfile} -c %{infile}"

    #configuration for low memory environment
    cc.defines << %w(MRB_HEAP_PAGE_SIZE=4) # cc.defines << %w(MRB_HEAP_PAGE_SIZE=64)
    cc.defines << %w(MRB_USE_IV_SEGLIST)
    cc.defines << %w(KHASH_DEFAULT_SIZE=4) # cc.defines << %w(KHASH_DEFAULT_SIZE=8)
    cc.defines << %w(MRB_STR_BUF_MIN_SIZE=20) # turning this to 1 reduced allocated size by 99 bytes, but may have side-effects
    cc.defines << %w(MRB_GC_STRESS)
    # cc.defines << %w(MRB_DISABLE_STDIO) #if you dont need stdio.
    # cc.defines << %w(POOL_PAGE_SIZE=1000) #effective only for use with mruby-eval

    # cc.defines << %w(MRB_GC_FIXED_ARENA) # used with MRB_GC_ARENA_SIZE
    # cc.defines << %w(MRB_GC_ARENA_SIZE=50) # default 100, may save 100 bytes of allocated memory
    # cc.defines << %w(MRB_INT16)
    # cc.defines << %w(MRB_USE_FLOAT) # Use single-precision float instead of double. Saves memory, but crashes arduino.
    # cc.defines << %w(MRB_STACK_MAX=0x800) # Max Stack to 2048, does not effect allocated size
    # cc.defines << %w(MRB_STACK_GROWTH=8) # default 128, does not effect allocated size
  end

  conf.cxx do |cxx|
    cxx.command = conf.cc.command.dup
    cxx.include_paths = conf.cc.include_paths.dup
    cxx.flags = conf.cc.flags.dup
    cxx.flags << %w(-fno-rtti -fno-exceptions)
    cxx.defines = conf.cc.defines.dup
    cxx.compile_options = conf.cc.compile_options.dup
  end

  conf.archiver do |archiver|
    archiver.command = "#{BIN_PATH}/arm-none-eabi-ar"
    archiver.archive_options = 'rcs %{outfile} %{objs}'
  end

  #no executables
  conf.bins = []

  #do not build executable test
  conf.build_mrbtest_lib_only

  #disable C++ exception
  # conf.disable_cxx_exception

  #gems from core
  # conf.gem :core => "mruby-print"
  # conf.gem :core => "mruby-math"
  # conf.gem :core => "mruby-enum-ext"
  # conf.gem :core => "mruby-compiler"

  #light-weight regular expression
  # conf.gem :github => "masamitsu-murase/mruby-hs-regexp", :branch => "master"

  conf.gembox 'arduino_due'

end
