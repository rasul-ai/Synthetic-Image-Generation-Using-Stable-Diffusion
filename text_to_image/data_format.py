import os
import json

image_folder = './image_folder'

# Output .jsonl file
output_file = './metadata.jsonl'

image_files = [f for f in os.listdir(image_folder) if f.lower().endswith(('.jpg', '.jpeg', '.png'))]

# Creating .jsonl file with null descriptions
with open(output_file, 'w') as jsonl_file:
    for img_file in image_files:
        json_line = {"file_name": img_file, "text": ""}
        jsonl_file.write(json.dumps(json_line) + '\n')

print(f"Created {output_file} with {len(image_files)} entries.")