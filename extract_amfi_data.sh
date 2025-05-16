#!/bin/bash

# URL of the AMFI NAV data
URL="https://www.amfiindia.com/spages/NAVAll.txt"

# Output file name
TSV_FILE="scheme_assets.tsv"
JSON_FILE="scheme_assets.json"

# Fetch the data and process it
echo -e "Scheme Name\tAsset Value (Crores)" > "$TSV_FILE"

curl -s "$URL" | awk -F ';' '
    # Skip lines that dont have 10 fields
    NF == 10 {
        scheme_name = $4
        asset_value_cr = $10
        
        # Clean up the asset value (remove commas and convert to number)
        gsub(/,/, "", asset_value_cr)
        
        # Only print if asset value is a positive number
        if (asset_value_cr ~ /^[0-9]+(\.[0-9]+)?$/) {
            printf "%s\t%.2f\n", scheme_name, asset_value_cr
        }
    }
' >> "$TSV_FILE"

echo "Data saved to $TSV_FILE"

# Optional: Create JSON version
echo "[" > "$JSON_FILE"
tail -n +2 "$TSV_FILE" | awk -F '\t' '
    NR > 1 { printf ",\n" }
    {
        printf "  {\n    \"scheme_name\": \"%s\",\n    \"asset_value_cr\": %s\n  }", $1, $2
    }
' >> "$JSON_FILE"
echo -e "\n]" >> "$JSON_FILE"

echo "JSON version saved to $JSON_FILE"
