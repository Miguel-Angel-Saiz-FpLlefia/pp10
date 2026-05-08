import json
import re

with open('database.sql', 'r', encoding='utf-8') as f:
    sql = f.read()

# We want to add module_slug to the questions table
sql = sql.replace("correct_answer_index INT NOT NULL,", "correct_answer_index INT NOT NULL,\n    module_slug VARCHAR(50) DEFAULT 'general',")
sql = sql.replace("correct_answer_index, xp_reward)", "correct_answer_index, xp_reward, module_slug)")

# For the inserts, we'll assign 'liquid', 'inventory', 'checkout', 'settings', 'os2' based on keywords, 
# or just assign them generally. To make it simple, let's just use regex to add , 'general' to the end of each INSERT value set.
sql = re.sub(r'(\d+)\);', r"\1, 'general');", sql)

with open('database_modified.sql', 'w', encoding='utf-8') as f:
    f.write(sql)
print("Modified DB successfully")
