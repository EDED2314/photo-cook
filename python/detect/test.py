import os
import requests

with open("test/DSC_3519.JPG", "rb") as payload:
    files = {'data': ('sample_plan.xml', payload, 'text/xml')}

    req = requests.post(url='http://abc123.com/index.php/plan/', files=files)