from typing import Dict, List, Optional, Tuple
import requests
from bs4 import BeautifulSoup
from google.cloud import firestore
db = firestore.Client()

# Set CORS headers for the preflight request
def handle_option():
    # Allows GET requests from any origin with the Content-Type
    # header and caches preflight response for an 3600s
    headers = {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Max-Age': '3600'
    }
    return ('', 204, headers)

def scrape_sites_data() -> List[Dict]:
    URL = "https://www.qld.gov.au/health/conditions/health-alerts/coronavirus-covid-19/current-status/contact-tracing"
    page = requests.get(URL)
    soup = BeautifulSoup(page.content, "html.parser")

    data: List[Dict] = []
    for result in soup.find('table').find("tbody").find_all("tr"):
        d = {}
        for k in result.attrs:
            d[str(k)] = str(result.attrs[k])
        data.append(d)
    return data

ACCESS_KEY = ""
# doc_ref.set({'name': 'Hello'})
def get_geospacial_data_from_api(location: str, suburb: str) -> Optional[Tuple]:
    geoapi_url = "http://api.positionstack.com/v1/forward?" + \
        f"access_key=ACCESS_KEY&" + \
        f"query={location}&" + \
        f"region={suburb}&" + \
        "country=AU&" + \
        "region_code=QLD"

    response = requests.get(geoapi_url)
    if response.status_code != 200:
        return None

    r = response.json()
    if r is None or \
            "data" not in r or \
            len(r["data"]) == 0:
        return None

    if not isinstance(r["data"][0], dict) or \
            "longitude" not in r["data"][0] or \
            "latitude" not in r["data"][0]:
        return None

    return (r["data"][0]["longitude"], r["data"][0]["latitude"])


def get_geospacial_data_from_firestore(location: str, suburb: str) -> Optional[Tuple]:
    ref = db.collection(u'exposure_sites').document(suburb).collection(u'locations').document(location)
    doc = ref.get()
    if doc.exists:
        doc = doc.to_dict()
        return (doc["lng"], doc["lat"])
    return None

def put_geospacial_data_from_firestore(lng: Optional[float], lat: Optional[float], location: str, suburb: str) -> Optional[Tuple]:
    ref = db.collection(u'exposure_sites').document(suburb).collection(u'locations').document(location)
    ref.set({
        'lat': lat,
        'lng': lng
    })

def augment_data_with_geospacial(inital_data: List[Dict]) -> List[Dict]:
    result = []
    for data in inital_data:
        location = data["data-location"]
        suburb = data["data-suburb"]

        lng: Optional[float] = None
        lat: Optional[float] = None
        firestore_response = get_geospacial_data_from_firestore(location, suburb)
        if firestore_response is None:
            api_response = get_geospacial_data_from_api(location, suburb)
            if api_response is not None:
                lng, lat = api_response
            # Add to firestore - even if not existing, to not overload api
            put_geospacial_data_from_firestore(lng, lat, location, suburb)
        else:
            lng, lat = firestore_response

        if lng is not None and lat is not None:
            data["data-lng"] = lng
            data["data-lat"] = lat
        result.append(data)
    return result

def scrape(request):
    if request.method == 'OPTIONS':
        return handle_option()

    # Set CORS headers for the main request
    data: List[Dict] = scrape_sites_data()
    data = augment_data_with_geospacial(data)

    return ({"exposures": data}, 200, {'Access-Control-Allow-Origin': '*'})
