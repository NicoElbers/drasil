import sys
from bs4 import BeautifulSoup
import re
import json

def get_text_or_none(tag):
    """Helper to safely get text from a tag, returning None if tag is None or empty."""
    if tag and hasattr(tag, 'get_text'):
        text = tag.get_text(strip=True)
        return text if text else None
    return None

def get_code_text_or_none(parent_tag):
    """Helper to safely get text from a <code> tag within a parent."""
    if parent_tag:
        code_tag = parent_tag.find('code') # Find the first code tag directly within the parent
        return get_text_or_none(code_tag)
    return None

def parse_general_events(soup):
    """
    Parses the 'List of events' (general) table.
    Now correctly handles event names that are `<code><a>...</a></code>` and multiple <tbody> elements.
    """
    events_data = []
    h3_events = soup.find('h3', class_='no-num', string='Events')
    if h3_events:
        table = None
        p_tag = h3_events.find_next_sibling('p', string=lambda text: text and 'The following table lists events fired by this document' in text)
        if p_tag:
            table = p_tag.find_next_sibling('table')
            
        if not table or not (table.caption and table.caption.text.strip() == 'List of events'):
            for sibling in h3_events.find_next_siblings():
                if sibling.name == 'table' and sibling.caption and sibling.caption.text.strip() == 'List of events':
                    table = sibling
                    break

        if table and table.caption and table.caption.text.strip() == 'List of events':
            print("Parsing 'List of events' (general) table...")
            # Find all tbody elements within the table
            tbodies = table.find_all('tbody')
            if tbodies:
                for tbody in tbodies: # Iterate through each tbody
                    for row in tbody.find_all('tr'):
                        cols = row.find_all('td')
                        if len(cols) >= 2: # Need at least name and interface
                            event_name = get_code_text_or_none(cols[0]) 
                            interface_name = get_code_text_or_none(cols[1]) # This column is directly the Interface
                            
                            if event_name: # Ensure event name is found
                                events_data.append({
                                    "name": event_name,
                                    "interface": interface_name
                                })
                if not events_data:
                    print("Warning: 'List of events' (general) table found but no event rows parsed.")
            else:
                print("Warning: No tbody elements found in 'List of events' (general) table.")
        else:
            print("Warning: 'List of events' (general) table not found even with robust search.")
    else:
        print("Warning: 'Events' (h3.no-num) heading not found, cannot locate general events table.")
    return events_data

def parse_media_events(soup):
    """
    Parses the 'Events summary' (media elements) table.
    Now correctly handles event names that are `<code><a>...</a></code>` and multiple <tbody> elements.
    """
    events_data = []
    h5_media_events = soup.find('h5', id='mediaevents')
    if h5_media_events:
        table = h5_media_events.find_next_sibling('table')
        if table and table.thead:
            print("Parsing 'Events summary' (media elements) table...")
            # Find all tbody elements within the table
            tbodies = table.find_all('tbody')
            if tbodies:
                for tbody in tbodies: # Iterate through each tbody
                    for row in tbody.find_all('tr'):
                        cols = row.find_all('td')
                        
                        if len(cols) >= 2: # Need at least name and interface
                            event_name = get_code_text_or_none(cols[0]) 
                            interface_name = get_code_text_or_none(cols[1]) # This column is directly the Interface
                            
                            if event_name: # Ensure event name is found
                                events_data.append({
                                    "name": event_name.lower(),
                                    "interface": interface_name
                                })
            else:
                print("Warning: No tbody elements found in 'Events summary' (media elements) table.")
        else:
            print("Warning: 'Events summary' (media elements) table not found after its identifying heading.")
    else:
        print("Warning: Identifying heading for 'Events summary' (media elements) table not found.")
    return events_data

def parse_drag_and_drop_events(soup):
    """
    Parses the 'Events summary' (drag-and-drop events) table.
    Only keeps 'name'.
    Now correctly handles event names that are `<code><a>...</a></code>` and multiple <tbody> elements.
    """
    events_data = []
    h4_dnd_events = soup.find('h4', id='dndevents')
    if h4_dnd_events:
        table = h4_dnd_events.find_next_sibling('table')
        if table and table.thead:
            print("Parsing 'Events summary' (drag-and-drop events) table...")
            # Find all tbody elements within the table
            tbodies = table.find_all('tbody')
            if tbodies:
                for tbody in tbodies: # Iterate through each tbody
                    for row in tbody.find_all('tr'):
                        cols = row.find_all('td')
                        if len(cols) >= 1: # Only need the first column for the name
                            event_name = get_code_text_or_none(cols[0]) 
                            if event_name: # Ensure event name is found
                                events_data.append({
                                    "name": event_name.lower()
                                })
            else:
                print("Warning: No tbody elements found in 'Events summary' (drag-and-drop events) table.")
        else:
            print("Warning: 'Events summary' (drag-and-drop events) table not found after its identifying heading.")
    else:
        print("Warning: Identifying heading for 'Events summary' (drag-and-drop events) table not found.")
    return events_data

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script_name.py <input_html_file_path> <output_json_file_path>")
        sys.exit(1)

    input_file_path = sys.argv[1]
    output_file_path = sys.argv[2]

    try:
        with open(input_file_path, 'r', encoding='utf-8') as f:
            html_content = f.read()
    except FileNotFoundError:
        print(f"Error: Input file not found at '{input_file_path}'")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading input file: {e}")
        sys.exit(1)

    print(f"Parsing HTML spec from: {input_file_path}")
    soup = BeautifulSoup(html_content, 'html5lib')

    # Collect data from each table into separate lists
    general_events = parse_general_events(soup)
    media_events = parse_media_events(soup)
    drag_and_drop_events = parse_drag_and_drop_events(soup)

    # Combine into a single dictionary
    all_parsed_data = {
        "general_events": sorted(general_events, key=lambda x: x.get('name', '')),
        "media_events": sorted(media_events, key=lambda x: x.get('name', '')),
        "drag_and_drop_events": sorted(drag_and_drop_events, key=lambda x: x.get('name', '')),
    }
    
    total_events = sum(len(v) for v in all_parsed_data.values())

    try:
        with open(output_file_path, 'w', encoding='utf-8') as f:
            json.dump(all_parsed_data, f, indent=2)
        print(f"\nSuccessfully extracted data for {total_events} events across categories to: {output_file_path}")
    except Exception as e:
        print(f"Error writing to output file: {e}")
        sys.exit(1)
