#!/usr/bin/env python
# from https://gist.github.com/GabLeRoux/d6b2c2f7a69ebcd8430ea59c9bcc62c0
import json
import sys

try:
    dotenv = sys.argv[1]
except IndexError as e:
    dotenv = '.env'

with open(dotenv, 'r') as f:
    content = f.readlines()

# removes whitespace chars like '\n' at the end of each line
#.content = [x.strip().split('=') for x in content if '=' in x]
content = [x.strip().split('=', 1) for x in content if '=' in x]
print(json.dumps(dict(content)))