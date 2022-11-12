#!/bin/bash

rm xx_account.csv

while read -r line; do
    IFS=',' read -ra CELLS <<< "$line"
    # echo "Original line: $line"
    for i in "${!CELLS[@]}"; do
        if [[ $i -eq 2 ]]; then
            IFS=' ' read firstname lastname <<< "${CELLS[$i]}"
            firstname=$(echo $firstname | awk '{print toupper(substr($0,0,1))tolower(substr($0,2))}')
            lastname=$(echo $lastname | awk '{print toupper(substr($0,0,1))tolower(substr($0,2))}')
            clean_name="$firstname $lastname"
            first_letter_first_name=$(echo $firstname | awk '{print tolower(substr($0,0,1))}')
            last_name_lower=$(echo $lastname | awk '{print tolower(substr($0,0))}')
            email="$first_letter_first_name$last_name_lower@abc.com"
            IFS=','
        fi
    done

    IFS=' '
    echo "TITLE: ${CELLS[3]}"
    new_line="${CELLS[0]}, ${CELLS[1]}, $clean_name, ${CELLS[3]}, $email, ${CELLS[5]}"
    # echo $new_line
    echo $new_line >> "xx_account.csv"
done < <(tail -n +2 $1)

# echo "$host, `date`, checkout,$Time_checkout" >> log.csv
