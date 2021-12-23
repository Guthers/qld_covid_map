# 0.0.1
Initial Deployment including:
- Google cloud function to scrape data
- Deployment with firebase
- Table displaying exposure sites
# 0.0.2
Adds mapping functionality:
- Improves the cloud function to (optionally) include longitude and latitude on each exposure
- Adds Firestore for longitude and latitude so to not overload third party api
- Adds map of QLD tab
    - And tries to make it pretty and useful
- Adds this changelog
- Disables scrolling the index.html so that the scrolling on the map will work as expected