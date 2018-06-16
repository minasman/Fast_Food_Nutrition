# Specifications for the CLI Assessment

Specs:
- [x] Have a CLI for interfacing with the application
- [x] Pull data from an external source
  The gem uses Open-uri and Nokogiri to open http://nutrition-charts.com and scrape restaurants, restaurant categories, category items and finally the nutrition information for those items. On the site, the restaurant names are scraped from the homepage along with a link to the url containing the information for the restaurant. Once the user selects a restaurant, the link is scraped to category, item and nutrition information.
- [x] Implement both list and detail views
  The user is first presented with a list view of restaurants. Based on the users choice, the user is then presented with a list of categories from the restaurant chosen. Next the user is presented with a list of items from withen the category chosen. Finally, a detailed view of the nutrition information for the item is presented to the user.
