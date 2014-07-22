#!/bin/bash

CVM_DEBUG=${CVM_DEBUG-0}
CVM_VERSION="0.1.0"
CVM_PREFIX=${CVM_PREFIX-/usr/local}
CVM_MIRROR=${CVM_MIRROR-http://registry.npmjs.org}

# Log
# --------------------------------------------------------------------

#
# Print debug info
cvm_debug() {
  if [[ "$CVM_DEBUG" != "0" ]]; then
    printf "     \x1B[35m[debug]\x1B[0m : \x1B[90m$1\x1B[0m\n"
  fi
}

#
# Log <type> <msg>
cvm_log() {
  local label=$1
  shift
  printf "  \x1B[36m%10s\x1B[0m :" $label
  printf " \x1B[90m$@\x1B[0m\n"
}

#
# Exit with the given <msg ...>
cvm_error() {
  printf "\n  \x1B[31mError: $@\x1B[0m\n\n"
}

#
# Strip path which starts with `$2` from `$1`
cvm_strip_path() {
                     # removes leading `$2`, and in the middle
                                        # removes ending `$2`
  echo "$1" | sed -e "s#$2[^:]*:##g" -e "s#:$2[^:]*##g" -e "s#^$2##g"
}

#
# Prepend `$2` to the beginning of `$1`
cvm_prepend_path() {
  if [ -z "$1" ]; then
    echo "$2"
  else
    echo "$2:$1"
  fi
}

#
# Exports PATH
cvm_export_path() {
  cvm_debug "export PATH=$1"
  export PATH="$1"
}

#
# Switch to version `$1`
cvm-use() {
  if [[ "$#" -eq 0 ]]; then
    printf "\n  \x1B[1mUsage:\x1B[0m\n"
    echo
    echo "    cvm-use <version>      Use cortex@<version> for current process"
    echo "    cvm-debug              Turn on debug mode for cvm-use and cvm"
    echo "    cvm-debug off          Turn off debug mode"
    echo
    return
  fi

  local version=${1#v}
  local versions="$CVM_PREFIX/cvm/versions"
  local dir="$versions/$version"

  if [[ "$1" = "default" ]]; then
    cvm_export_path `cvm_strip_path "$PATH" "$versions"`
    cvm_log "activate" "default" 
    return
  fi
  
  cvm_debug "$dir"
  cvm install "$version"
  if [[ $? -ne 0 ]]; then
    return 1
  fi

  printf "\033[1A\033[2K"

  path=`cvm_strip_path "$PATH" "$versions"`
  cvm_export_path `cvm_prepend_path "$path" "$dir/.bin"`
  cvm_log "activate" "$version" 
}

cvm-debug() {
  if [[ $1 != "off" ]]; then
    export CVM_DEBUG=1
    cvm_debug "cvm debug on"
  else
    cvm_debug "cvm debug off"
    export CVM_DEBUG=0
  fi
}
