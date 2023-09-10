#!/bin/bash

# Define the folder path
folder_path="/run/media/krishnaraj/VBoxes/Courses/[1] Statistics and Probability for Data Science/Statistics and Probability for Data Science"

# Initialize total duration variable
total_duration=0

# Function to calculate duration of MP4 files recursively
calculate_duration() {
    local folder="$1"
    for file in "$folder"/*; do
        if [ -d "$file" ]; then
            calculate_duration "$file"
        elif [ -f "$file" ] && [[ "$file" == *.mp4 ]]; then
            duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$file")
            total_duration=$(awk "BEGIN {print $total_duration + $duration}")
        fi
    done
}

# Call the function with the folder path
calculate_duration "$folder_path"

# Print the total duration
echo "Total duration of the data science course: $total_duration seconds"

# You can convert total_duration to hours, minutes, and seconds if needed
