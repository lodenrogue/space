#! /bin/bash

# Print out how much storage space is used and percent available

get_disk_info() {
    df -h | grep "$1" -m 1
}

get_size() {
    get_disk_info "$1" | cut -d " " -f 3
}

get_space_available() {
    get_disk_info "$1" | cut -d " " -f 8
}

get_space_used() {
    get_disk_info "$1" | cut -d " " -f 6
}

calculate_percent_free() {
    avail_value=${1%?}
    size_value=${2%?}
    echo "scale=2; ($avail_value / $size_value) * 100" | bc
}

drive_name="nvme0n1p2"

used=$(get_space_used "$drive_name")
available=$(get_space_available "$drive_name")
size=$(get_size "$drive_name")

percent_free=$(calculate_percent_free "$available" "$size")

echo "Storage: $used / $size. $percent_free% free"
