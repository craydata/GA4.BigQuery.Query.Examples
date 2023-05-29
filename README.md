
# GA4 BigQuery Queries
This repository contains example queries for querying data in Google BigQuery using the GA4 (Google Analytics 4) schema. The queries are categorized based on different dimensions and metrics available in the GA4 schema.

## Items Dimensions & Metrics (GA4)
This query retrieves various dimensions and metrics related to items in the GA4 schema. The dimensions include item id, item name, item brand, item variant, item category, and more. The metrics include price in USD, price, quantity, item revenue in USD, item revenue, item refund in USD, item refund, and more. The data is fetched from the ga4_obfuscated_sample_ecommerce.events_20201130 table.

## Ecommerce Dimensions & Metrics (GA4)
This query retrieves dimensions and metrics related to ecommerce transactions in the GA4 schema. The dimensions include the transaction id, and the metrics include total item quantity, purchase revenue in USD, purchase revenue, refund value in USD, refund value, shipping value in USD, shipping value, tax value in USD, tax value, and unique items. The data is fetched from the ga4_obfuscated_sample_ecommerce.events_20201130 table and filtered to include only 'purchase' events.

## Events Dimensions & Metrics (GA4)
This query retrieves dimensions and metrics related to events in the GA4 schema. The dimensions include the event date, event timestamp, event name, event key, event string value, event int value, event float value, event double value, event previous timestamp, event value in USD, event bundle sequence id, event server timestamp offset, and event dimensions hostname. The data is fetched from the ga4_obfuscated_sample_ecommerce.events_20201130 table and filtered to include only 'page_view' events.

## Page Dimensions & Metrics (GA4)
This query retrieves dimensions and metrics related to page views in the GA4 schema. The dimensions include user type and count of sessions, and the metrics include the number of users, new users, percentage of new sessions, number of sessions per user, and hits. The data is fetched from the google_analytics_sample.ga_sessions_20160801 table.

## Date and Time Dimensions & Metrics (GA4)
This query retrieves dimensions related to date and time in the GA4 schema. The dimensions include event date, event timestamp, event previous timestamp, event server timestamp offset, user first touch timestamp, and user set timestamp micros. The data is fetched from the ga4bigquery.analytics_250794857.events_* table within a specified date range.

## Session Dimensions & Metrics (GA4)
This query retrieves dimensions and metrics related to sessions in the GA4 schema. (No example query provided.)

## Geo Location Dimensions & Metrics (GA4)
This query retrieves dimensions related to geo location in the GA4 schema. The dimensions include geo continent, geo sub-continent, geo country, geo region, geo city, and geo metro. The data is fetched from the ga4bigquery.analytics_250794857.events_* table within a specified date range.

## Device, App, Web, Stream, and Platform Dimensions & Metrics (GA4)
This query retrieves dimensions and metrics related to device, app, web, stream, and platform in the GA4 schema. The dimensions include device category, device mobile brand name, device mobile model name, device mobile marketing name, device mobile OS hardware model, device operating system, device operating system version, device vendor id, device advertising id, device language, device is limited ad tracking, device time zone offset seconds, device browser, device browser version, device web info browser, device web info browser version, device web info hostname, app info id, app info
