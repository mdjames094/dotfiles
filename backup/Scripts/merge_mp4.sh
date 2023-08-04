#!/bin/bash

#if [[ $# -eq 0 ]] 
#  then
#    echo 'syntax: merge_mp4.sh <folder>'
#    exit 1
#  else
#    cd ${1}
#    current_dir=$(pwd)
#    echo -e "\nMerging video files from ${current_dir}"
#fi

set -euo pipefail
IFS=$'\n\t'

## Script to merge all mp4 videos in current directory (recursively 2 levels)
## And update chapter marks to retain the folder/filename

## Script for merging videos

temp_dir=$(mktemp -d)
function finish {
  rc=$?
  if [[ $rc != 0 ]]; then
  	echo
  	echo "FAILED!"
  fi
  echo -n "Cleaning up "
  rm -rf "${temp_dir}"
  echo "..........[ DONE ]"
  exit $rc
}
trap finish EXIT

current_dir=$(pwd)
bname=$(basename ${current_dir})
final_mp4=${bname}.mp4
input_list=${temp_dir}/${bname}-input_list.txt
file_list=${temp_dir}/${bname}-file_list
meta_file=${temp_dir}/${bname}-metadata.txt

#Hopefully this will work for either BSD or GNU sed
extended_match="-r"
echo "" | sed ${extended_match} 's|foo|bar|' 2>/dev/null || extended_match="-E"

if [ -e "${final_mp4}" ]; then
    echo "${final_mp4} already exists, please remove it."
    exit 1
fi

echo -n "Generating file lists "
find . -maxdepth 2 -type f | egrep "\.(mp4|mkv)$" |
    sed -e 's|^./||' |
    tee "${file_list}" | 
    awk "{printf \"file '${current_dir}/%s'\n\", \$0}" > "${input_list}"
echo "..........[ DONE ]"  

## chapter marks
#Do this first so we fail early
#TODO: Test (‘=’, ‘;’, ‘#’, ‘\’) are escaped
ts=0
echo -n "Generating chapter marks "
ffmpeg -i "$(head -1 "${file_list}")" -f ffmetadata "${meta_file}" -v quiet
cat "${file_list}" | while read file
do
    ds=$(ffprobe -v quiet -of csv=p=0 -show_entries format=duration "${file}")
    # echo "$ds"
    escaped_title=$(echo ${file} | sed ${extended_match} -e 's|([=;#\])|\\\1|g' -e 's|.[Mm][Pp]4$||' )
    echo "[CHAPTER]" >> "${meta_file}"
    echo "TIMEBASE=1/1" >> "${meta_file}"
    echo "START=${ts}" >> "${meta_file}"
    ts=$(awk "BEGIN {print ${ts}+${ds}; exit}")
    echo "END=${ts}" >> "${meta_file}"
    echo "TITLE=${escaped_title}" >> "${meta_file}"
done
echo "..........[ DONE ]"

echo -n "Merging the files "
ffmpeg -f concat -safe 0 -i "${input_list}" -i "${meta_file}" -map_metadata 1 -codec copy "${final_mp4}" -v quiet
echo "..........[ DONE ]"

echo "Job Completed."

