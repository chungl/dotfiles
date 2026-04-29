# Byte Math - utils for converting storage sizes, etc - requires bcal
function normalize_byte_unit() {
  # M -> MB, Mi -> MiB
  if [[ "${1: -1}" =~ [bB] ]]; then
    echo "$1"
  else
    local first="${1:0:1}"
    [[ "$first" =~ [A-Z] ]] && echo "${1}B" || echo "${1}b"
  fi
}
# bcalb 30 Gi -> 32212254720
function bcalb() {
  local comment_sep=""
  while getopts "c:" opt; do
    case $opt in
      c) comment_sep=$OPTARG ;;
    esac
  done
  shift $((OPTIND - 1))
  local input_unit=$(normalize_byte_unit $2)
  local result=$(bcal -m $1 $input_unit | awk '{print $1}')
  [[ -n $comment_sep ]] && echo "$result $comment_sep $1 $input_unit in Bytes" || echo "$result"
}
# bcalgrep 30 Gi K -> 32212255
function bcalgrep() {
  local output_unit=$(normalize_byte_unit $3)
  bcal $1 $(normalize_byte_unit $2) | grep -i "^\s*[0-9e.+-]* $output_unit\s*$" | awk '{printf "%.0f\n", $1}'
}

