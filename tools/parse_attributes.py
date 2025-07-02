import sys
import json
from bs4 import BeautifulSoup

def parse_html_attributes(input_file, output_file):
    """
    Parses HTML attributes from the WHATWG HTML spec, consolidates duplicates,
    and outputs them as JSON with a single 'details' array.

    Args:
        input_file (str): Path to the input HTML file.
        output_file (str): Path to the output JSON file.
    """
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            html_content = f.read()
    except FileNotFoundError:
        print(f"Error: Input file '{input_file}' not found.")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading input file: {e}")
        sys.exit(1)

    soup = BeautifulSoup(html_content, 'html5lib')

    # Step 1: Generate the initial list of parsed attributes
    # attribute_elements will always be a list, even for "global"
    raw_attributes_data = []

    attributes_table = soup.find('table', id='attributes-1')

    if not attributes_table:
        print("Error: Could not find the attributes table with id 'attributes-1'.")
        sys.exit(1)

    tbody = attributes_table.find('tbody')
    if not tbody:
        print("Error: Could not find tbody within the attributes table.")
        sys.exit(1)

    rows = tbody.find_all('tr')

    for row in rows:
        cells = row.find_all(['th', 'td'])

        if len(cells) >= 3:
            attribute_name_cell = cells[0]
            attribute_elements_cell = cells[1]
            attribute_description_cell = cells[2]

            attribute_name = attribute_name_cell.get_text(strip=True)
            attribute_description = attribute_description_cell.get_text(strip=False).strip()
            raw_attribute_elements_text = attribute_elements_cell.get_text() 

            if raw_attribute_elements_text.strip().lower() == "html elements":
                attribute_elements_processed = ["global"]
            else:
                split_elements = raw_attribute_elements_text.replace(';', ',').split(',')
                attribute_elements_processed = [
                    el.strip() for el in split_elements if el.strip()
                ]
            
            raw_attributes_data.append({
                "attribute_name": attribute_name,
                "attribute_elements": attribute_elements_processed,
                "attribute_description": attribute_description
            })
        else: 
            print(f"Warning: Insufficient columns: {row}")
            sys.exit(1)

    # Step 2: Post-processing to consolidate duplicates into a single 'details' array
    consolidated_attributes = {} # Stores unique attribute_name -> {..., details: set()}

    for attr_entry in raw_attributes_data:
        name = attr_entry["attribute_name"]
        elements = attr_entry["attribute_elements"] 
        description = attr_entry["attribute_description"]

        if name not in consolidated_attributes:
            consolidated_attributes[name] = {
                "attribute_name": name,
                "details_set": set() 
            }
        
        # Sort the elements list and convert to a tuple to make it hashable for the set
        elements_tuple = tuple(sorted(elements))
        
        # Add the unique combination of (elements, description) to the set
        consolidated_attributes[name]["details_set"].add((elements_tuple, description))

    # Convert the consolidated data into the final desired list format
    final_output_data = []
    for name, data in consolidated_attributes.items():
        details_list_for_attr = []
        for elements_tuple, description in data["details_set"]:
            details_list_for_attr.append({
                "elements": list(elements_tuple), 
                "description": description
            })
        
        # Sort the details list for consistent output (e.g., by the first element and then description)
        details_list_for_attr.sort(key=lambda x: (x["elements"][0] if x["elements"] else '', x["description"]))

        final_output_data.append({
            "attribute_name": name,
            "details": details_list_for_attr
        })
    
    # Sort the top-level list by attribute_name for overall consistent output
    final_output_data.sort(key=lambda x: x["attribute_name"])

    # Step 3: Write the consolidated JSON data
    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(final_output_data, f, indent=2, ensure_ascii=False)
        print(f"Successfully parsed and consolidated {len(final_output_data)} unique attributes and saved to '{output_file}'.")
    except Exception as e:
        print(f"Error writing to output file '{output_file}': {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <input_html_file> <output_json_file>")
        sys.exit(1)

    input_html_file = sys.argv[1]
    output_json_file = sys.argv[2]

    parse_html_attributes(input_html_file, output_json_file)
