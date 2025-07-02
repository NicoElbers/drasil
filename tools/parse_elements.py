import argparse
import json
from bs4 import BeautifulSoup

def parse_html_spec(input_file, output_file):
    """
    Parses the HTML specification to extract information about HTML elements
    and saves it to a JSON file. Errors out on unexpected or missing data.
    Handles multiple element names in a single row (e.g., h1, h2...).
    Correctly handles "per MATHML" and "per SVG" attributes, and allows for empty attribute lists.
    """
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            soup = BeautifulSoup(f, 'html5lib') 
    except FileNotFoundError:
        raise FileNotFoundError(f"Error: Input file '{input_file}' not found.")
    except Exception as e:
        raise IOError(f"Error reading or parsing input file: {e}")

    elements_data = []

    # Find the "List of elements" table
    elements_table = None
    for caption in soup.find_all('caption'):
        if "List of elements" in caption.get_text():
            elements_table = caption.find_parent('table')
            break

    if not elements_table:
        raise ValueError("Error: Could not find the 'List of elements' table in the HTML spec. The structure might have changed.")

    tbody = elements_table.find('tbody')
    if not tbody:
        raise ValueError("Error: Could not find <tbody> within the elements table.")

    rows = tbody.find_all('tr')
    if not rows:
        raise ValueError("Error: No table rows found in the elements table.")

    for i, row in enumerate(rows):
        columns = row.find_all(['th', 'td'])
        
        # We expect at least 7 columns based on the spec snippet
        if len(columns) < 7:
            raise ValueError(f"Error: Row {i+1} has fewer than 7 columns ({len(columns)} found). Expected element data is missing.")

        # --- Parse Element Name(s) (1st column: <th>) ---
        current_row_element_names = []
        
        # Try to find <code> tags, whether direct or nested in <span>
        found_code_tags = columns[0].find_all('code')
        if found_code_tags:
            for tag in found_code_tags:
                name = tag.get_text(strip=True)
                if name:
                    current_row_element_names.append(name)
        else:
            # Fallback for plain text elements if no code tags were found (e.g., "autonomous custom elements")
            plain_text_name = columns[0].get_text(strip=True)
            if plain_text_name:
                # Handle cases like "h1, h2..." if they weren't in <code> tags
                split_names = [n.strip() for n in plain_text_name.split(',') if n.strip()]
                current_row_element_names.extend(split_names)

        if not current_row_element_names:
            raise ValueError(f"Error: Element name(s) not found or empty in the first column of row {i+1}.")

        # Exclude "autonomous custom elements"
        # This check is done after initial parsing of names for a row
        if "autonomous custom elements" in current_row_element_names:
            current_row_element_names.remove("autonomous custom elements")
        
        if not current_row_element_names: # If removing special elements left the list empty
            continue # Skip this row entirely as it doesn't represent a standard element

        # --- Parse Description (2nd column: <td>) ---
        description = columns[1].get_text().strip()
        if not description:
            raise ValueError(f"Error: Description not found or empty for element(s) '{', '.join(current_row_element_names)}' in row {i+1}.")

        # --- Parse Attributes (6th column: <td>) ---
        attributes_list = []
        raw_attributes_text = columns[5].get_text(strip=True)
        
        # Check for "per MATHML" or "per SVG" first
        if "per MATHML" in raw_attributes_text:
            attributes_list.append("per MATHML")
        elif "per SVG" in raw_attributes_text:
            attributes_list.append("per SVG")
        else:
            for code_tag in columns[5].find_all('code'):
                attr_name = code_tag.get_text(strip=True)
                if attr_name:
                    attributes_list.append(attr_name)
            
            if "globals" in raw_attributes_text.lower() and "globals" not in attributes_list:
                attributes_list.insert(0, "globals")
            
            if raw_attributes_text.lower() == "no attributes" and not attributes_list:
                pass 
            
            if not attributes_list and raw_attributes_text.lower() == "transparent":
                pass

        # --- Parse Interface (7th column: <td>) ---
        interface_tag = columns[6].find('code')
        if not interface_tag:
            interface_text = columns[6].get_text(strip=True)
            if interface_text:
                interface = interface_text
            else:
                raise ValueError(f"Error: Interface (<code> tag or plain text) not found in the seventh column for element(s) '{', '.join(current_row_element_names)}' in row {i+1}.")
        else:
            interface = interface_tag.get_text(strip=True)
            if not interface:
                raise ValueError(f"Error: Interface name is empty for element(s) '{', '.join(current_row_element_names)}' in row {i+1}.")

        # --- Add entries for each element name found in this row ---
        for name in current_row_element_names:
            elements_data.append({
                "name": name,
                "description": description,
                "attributes": attributes_list,
                "interface": interface
            })

    try:
        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(elements_data, f, indent=2, ensure_ascii=False)
        print(f"Successfully parsed {len(elements_data)} elements and saved to '{output_file}'.")
    except Exception as e:
        raise IOError(f"Error writing to output file '{output_file}': {e}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Parse the HTML specification to extract element information.")
    parser.add_argument("input_file", help="Path to the HTML spec source file (e.g., whatwg/html/index.html).")
    parser.add_argument("output_file", help="Path to the output JSON file.")
    
    args = parser.parse_args()

    try:
        parse_html_spec(args.input_file, args.output_file)
    except (FileNotFoundError, IOError, ValueError) as e:
        print(f"Script failed: {e}")
        exit(1)
