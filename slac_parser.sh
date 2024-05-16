#!/bin/bash

# Script: slac_parser.sh
# Description: This script runs a SLAC analysis and moves all output files
#              in the current directory to its corresponding folder, named 'SLAC'.

#			  _
#			><_>

# MIT License

# Copyright (c) 2024 João Bilro (joaobilro)

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Usage message
usage() {
    echo "Usage: $0"
    echo "Description: Run and Organize SLAC analyses."
    echo "This script runs a SLAC analysis and organises all the newly created output files by"
    echo "creating a new folder named 'SLAC' in the gene's folder, and moving them inside it."
    echo "Example: $0"
    exit 1
}

# Function to process folders
process_folders() {
    gene_name=$1

    for folder in */; do
        if [ -d "$folder" ]; then
            if [[ "$folder" == *"$gene_name"* ]]; then
            	echo "Processing folder $folder..."
            	echo "Changing to folder $folder..."
            	cd "$folder" || { echo "Cannot access $folder... Exiting."; exit 1; }  # Entering the directory
                echo "Currently in $(pwd)"

            	echo "Files in directory:"
           	    ls -1

            	echo "Checking for .fasta files..."
            	for file in *; do
                    if [[ "$file" == *.fasta ]]; then
                    	echo "Found .fasta file: $file"
                    	echo "Running SLAC for $file..."
                    	hyphy slac --alignment $file --tree {insert tree file path here} \
                    	--code Universal --branches All --samples 100 --pvalue 0.1 || { echo "Error processing file: $file"; exit 1; }
                    	
                    	#Move newly created *SLAC.json file to SLAC subdirectory
                    	mkdir -p SLAC
                    	mv *SLAC.json SLAC/ || { echo "Could not move output file to the specified folder. Exiting."; exit 1; }
                    fi
            	done

                echo "Finished processing files in $folder"
                cd .. || { echo "Cannot return to the parent directory"; exit 1; }  # Go back to the parent directory
            fi  
        fi
    done
}

# Prompt user to select a gene folder
read -p "Enter the gene to start processing from: " gene_name

if [ -z "$gene_name" ]; then
    echo "A valid gene was not provided. Exiting."
    exit 1
fi
echo -e "\n\n"

# Ask for the mode of operation
read -p "Press ENTER for Manual, Type AUTO for Automatic: " mode

if [[ -z "$mode" ]]; then
    echo "Manual mode selected."
    process_folders "$gene_name"
elif [[ "$mode" == "AUTO" ]]; then
    echo "Automatic mode selected."
    start_processing=false
    for folder in */; do
        if [ -d "$folder" ]; then
            if [[ "$folder" == *"$gene_name"* ]]; then
                start_processing=true
            fi

            if [ "$start_processing" = true ]; then
                process_folders "$folder"
            fi
        fi
    done
else
    echo "Invalid input. Exiting."
    exit 1
fi

echo "Script completed successfully!"

