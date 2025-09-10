#!/bin/bash

read_variables() {
  index=0
  while read -a array ; do
    if [[ "$array" == "" ]] ; then
      continue
    fi

    if [[ $array == '#' ]] ; then
      continue
    fi

    k=${array[0]}
    v=${array[1]}
    variable_keys[$index]=$k
    variable_values[$index]=$v
    index=$(( $index + 1 ))
  done < $1
}

# Args: key
get_value() {
  index=0
  key=$1

  while [[ $index -lt ${#variable_keys[@]} ]] ; do
    if [ $key == ${variable_keys[$index]} ] ; then
      echo ${variable_values[$index]}
      return
    else
      index=$(( $index + 1 ))
    fi
  done
  echo "Did not find ${key} in the list of keys"
  exit 1
}

get_index() {
  index=0
  key=$1

  while [[ $index -lt ${#variable_keys[@]} ]] ; do
    if [ $key == ${variable_keys[$index]} ] ; then
      echo $index
      return
    else
      index=$(( $index + 1 ))
    fi
  done
  echo "Did not find ${key} in the list of keys"
  >&2 echo "Did not find ${key} in the list of keys"
  exit 1
}

write_dynamic_variables() {
  epoch_time=`date "+%s"`
  iat_index=$(get_index __IAT__)
  variable_values[$iat_index]=$epoch_time

  future_time=$(( $epoch_time + 15*60 ))
  exp_index=$(get_index __EXP__)
  variable_values[$exp_index]=$future_time

  unique_id=`uuidgen`
  jti_index=$(get_index __JTI__)
  variable_values[$jti_index]=$unique_id
}

determine_aud() {
  v=$(get_value __AUD__)
  echo $v
}

determine_exp() {
  v=$(get_value __EXP__)
  echo $v
}

determine_iat() {
  v=$(get_value __IAT__)
  echo $v
}

determine_iss() {
  v=$(get_value __ISS__)
  echo $v
}

determine_sub() {
  v=$(get_value __SUB__)
  echo $v
}

determine_jti() {
  v=$(get_value __JTI__)
  echo $v
}

#  "aud": "AUD",
#  "iat": "999000888",
#  "iss": "ISS",
#  "jti": "JTI",


# Main starts here
# Args:
#       Input patient JWT json file
#       Input variable file
#       Output file

set -e

patient_json="$1"
jwt_variables="$2"
output_file="$3"

declare -a variable_keys
declare -a variable_values

mkdir -p `dirname $output_file`
read_variables "$jwt_variables"
write_dynamic_variables

  aud=$(determine_aud)
  exp=$(determine_exp)
  iat=$(determine_iat)
  iss=$(determine_iss)
  sub=$(determine_sub)
  jti=$(determine_jti)

  cat "$patient_json" | sed	\
    -e "s/__AUD__/$aud/"	\
    -e "s/__EXP__/$exp/"	\
    -e "s/__IAT__/$iat/"	\
    -e "s@__ISS__@$iss@"	\
    -e "s/__SUB__/$sub/"	\
    -e "s/__JTI__/$jti/" > "$output_file"

