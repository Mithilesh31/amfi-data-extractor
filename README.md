# amfi-data-extractor
Shell script to extract Scheme Name and Asset Value from AMFI India NAV data.
# AMFI NAV Data Extractor

A shell script to extract **Scheme Name** and **Asset Value** from [AMFI India's NAV data](https://www.amfiindia.com/spages/NAVAll.txt) and save it in TSV and JSON formats.

## Features
- Fetches live data from AMFI India
- Extracts Scheme Name and Asset Value (in Crores)
- Generates both TSV (for spreadsheets) and JSON (for apps)
- Lightweight with no dependencies

## Usage
```bash
# Make the script executable
chmod +x extract_amfi_data.sh

# Run the script
./extract_amfi_data.sh
