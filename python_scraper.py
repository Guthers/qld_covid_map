from typing import Dict, List
import requests
from bs4 import BeautifulSoup

def scrape(request):
    # Set CORS headers for the preflight request
    if request.method == 'OPTIONS':
        # Allows GET requests from any origin with the Content-Type
        # header and caches preflight response for an 3600s
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Max-Age': '3600'
        }

        return ('', 204, headers)

    # Set CORS headers for the main request
    headers = {
        'Access-Control-Allow-Origin': '*'
    }

    URL = "https://www.qld.gov.au/health/conditions/health-alerts/coronavirus-covid-19/current-status/contact-tracing"
    page = requests.get(URL)
    soup = BeautifulSoup(page.content, "html.parser")

    data: List[Dict] = []
    for result in soup.find('table').find("tbody").find_all("tr"):
        d = {}
        for k in result.attrs:
            d[str(k)] = str(result.attrs[k])
        data.append(d)

    return ({"exposures": data}, 200, headers)
