import os
import re

def process_file(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading {filepath}: {e}")
        return

    original_content = content

    content = re.sub(r'height:\s*([0-9]+(?:\.[0-9]+)?)(?!\w|\.)', r'height: \1.h', content)
    content = re.sub(r'width:\s*([0-9]+(?:\.[0-9]+)?)(?!\w|\.)', r'width: \1.w', content)
    content = re.sub(r'fontSize:\s*([0-9]+(?:\.[0-9]+)?)(?!\w|\.)', r'fontSize: \1.sp', content)
    content = re.sub(r'radius:\s*([0-9]+(?:\.[0-9]+)?)(?!\w|\.)', r'radius: \1.r', content)

    if '.h' in content or '.w' in content or '.sp' in content or '.r' in content:
        if 'package:flutter_screenutil/flutter_screenutil.dart' not in content:
            imports = re.findall(r'^import\s+.*?$', content, re.MULTILINE)
            if imports:
                last_import = imports[-1]
                content = content.replace(last_import, last_import + "\nimport 'package:flutter_screenutil/flutter_screenutil.dart';")

    if content != original_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated {filepath}")

files = [
    r"c:\Users\HP\Desktop\projects\Multi-Vendor-E-Commerce\lib\app\auth_cycle\views\login_screen.dart",
    r"c:\Users\HP\Desktop\projects\Multi-Vendor-E-Commerce\lib\app\user_stories\product_cycle\views\product_details_page.dart",
    r"c:\Users\HP\Desktop\projects\Multi-Vendor-E-Commerce\lib\app\user_stories\profile_cycle\widget\profile_address_card.dart",
    r"c:\Users\HP\Desktop\projects\Multi-Vendor-E-Commerce\lib\app\user_stories\explore_cycle\views\categories_screen.dart",
    r"c:\Users\HP\Desktop\projects\Multi-Vendor-E-Commerce\lib\app\user_stories\cart_cycle\widget\cart_total.dart",
]

for file in files:
    process_file(file)
