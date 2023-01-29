## GA4_BigQuery_Query_Examples
## GA4_BigQuery_Query_Examples
## Items dimensions & metrics (GA4)

```
select
    -- item id (dimension | the id of the item)
    items.item_id,
    -- item name (dimension | the name of the item)
    items.item_name,
    -- item brand (dimension | the brand of the item)
    items.item_brand,
    -- item variant (dimension | the variant of the item)
    items.item_variant,
    -- item category (dimension | the category of the item)
    items.item_category,
    -- item category 2 (dimension | the sub category of the item)
    items.item_category2,
    -- item category 3 (dimension | the sub category of the item)
    items.item_category3,
    -- item category 4 (dimension | the sub category of the item)
    items.item_category4,
    -- item category 5 (dimension | the sub category of the item)
    items.item_category5,
    -- price in usd (metric | the price of the item, in usd with standard unit)
    items.price_in_usd,
    -- price (metric | the price of the item in local currency)
    items.price,
    -- quantity (metric | the quantity of the item)
    items.quantity,
    -- item revenue in usd (metric | the revenue of this item, calculated as price_in_usd * quantity
    -- it is populated for purchase events only, in usd with standard unit)
    items.item_revenue_in_usd,
    -- item revenue (metric | the revenue of this item, calculated as price * quantity
    -- it is populated for purchase events only, in local currency with standard unit)
    items.item_revenue,
    -- item refund in usd (metric | the refund value of this item, calculated as price_in_usd * quantity
    -- it is populated for refund events only, in usd with standard unit)
    items.item_refund_in_usd,
    -- item refund (metric | the refund value of this item, calculated as price_in_usd * quantity
    -- it is populated for refund events only, in local currency with standard unit)
    items.item_refund,
    -- coupon (dimension | coupon code applied to this item)
    items.coupon,
    -- affiliation (dimension | a product affiliation to designate a supplying company
    -- or brick and mortar store location)
    items.affiliation,
    -- location id (dimension | the location associated with the item)
    items.location_id,
    -- item list id (dimension | the id of the list in which the item was presented to the user)
    items.item_list_id,
    -- item list name (dimension | the name of the list in which the item was presented to the user)
    items.item_list_name,
    -- item list index (dimension | the position of the item in a list)
    items.item_list_index,
    -- promotion id (dimension | the id of a product promotion)
    items.promotion_id,
    -- promotion name (dimension | the name of a product promotion)
    items.promotion_name,
    -- creative name (dimension | the name of a creative used in a promotional spot)
    items.creative_name,
    -- creative slot (dimension | the name of a creative slot)
    items.creative_slot
from
     `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20201130`,
    unnest(items) as items
```

## Ecommerce dimensions & metrics (GA4)

## This example query contains all following Google Analytics dimensions and metrics. 

```
select
    -- transaction id (dimension | the transaction id of the ecommerce transaction)
    ecommerce.transaction_id,
    -- total item quantity (metric | total number of items in this event, which is the sum of items.quantity)
    sum(ecommerce.total_item_quantity) as total_item_quantity,
    -- purchase revenue in usd (metric | purchase revenue of this event, represented in usd with standard unit,
    -- populated for purchase event only)
    sum(ecommerce.purchase_revenue_in_usd) as purchase_revenue_in_usd,
    -- purchase revenue (metric | purchase revenue of this event, represented in local currency with standard unit,
    -- populated for purchase event only)
    sum(ecommerce.purchase_revenue) as purchase_revenue,
    -- refund value in usd (metric | the amount of refund in this event, represented in usd with standard unit,
    -- populated for refund event only)
    sum(ecommerce.refund_value_in_usd) as refund_value_in_usd,
    -- refund value (metric | the amount of refund in this event, represented in local currency with standard unit,
    -- populated for refund event only)
    sum(ecommerce.refund_value) as refund_value,
    -- shipping value in usd (metric | the shipping cost in this event, represented in usd with standard unit)
    sum(ecommerce.shipping_value_in_usd) as shipping_value_in_usd,
    -- shipping value (metric | the shipping cost in this event, represented in local currency)
    sum(ecommerce.shipping_value) as shipping_value,
    -- tax value in usd (metric | the tax value in this event, represented in usd with standard unit)
    sum(ecommerce.tax_value_in_usd) as tax_value_in_usd,
    -- tax value (metric | the tax value in this event, represented in local currency with standard unit)
    sum(ecommerce.tax_value) as tax_value,
    -- unique items (metric | the number of unique items in this event, based on item_id, item_name, and item_brand)
    sum(ecommerce.unique_items) as unique_items
from
     `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20201130`
where
   event_name = 'purchase'
group by
    transaction_id
```

# Events dimensions & metrics (GA4)

```
select
    -- event_date (dimension | the date on which the event was logged)
    parse_date('%Y%m%d',event_date) as event_date,
    -- event_timestamp (dimension | the time (in microseconds, utc) at which
    -- the event was logged on the client)
    timestamp_micros(event_timestamp) as event_timestamp,
    -- event_name (dimension | the name of the event)
    event_name,
    -- event_key (dimension | the event parameter's key | change key to select another parameter)
    (select key from unnest(event_params) where key = 'page_location') as event_key,
    -- event_string_value (dimension | the string value of the event parameter | change key to select another parameter)
    (select value.string_value from unnest(event_params) where key = 'page_location') as event_string_value,
    -- event_int_value (metric | the integer value of the event parameter | change key to select another parameter)
    (select value.int_value from unnest(event_params) where key = 'ga_session_id') as event_int_value,
    -- event_float_value (metric | the float value of the event parameter | change key to select another parameter)
    (select value.float_value from unnest(event_params) where key = 'page_location') as event_float_value,
    -- event_double_value (metric | the double value of the event parameter | change key to select another parameter)
    (select value.double_value from unnest(event_params) where key = 'page_location') as event_double_value,
    -- event_previous_timestamp (dimension | the time (in microseconds, utc) at which
    -- the event was previously logged on the client)
    timestamp_micros(event_previous_timestamp) as event_previous_timestamp,
    -- event_value_in_usd (metric | the currency-converted value (in usd) of the event's "value" parameter)
    event_value_in_usd,
    -- event_bundle_sequence_id (dimension | the sequential id of the bundle in which these events were uploaded)
    event_bundle_sequence_id,
    -- event_server_timestamp_offset (dimension | timestamp offset between collection time and upload time in micros)
    event_server_timestamp_offset,
    -- event_dimensions.hostname (dimension | hostname)
    event_dimensions.hostname
from
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20201130`
where
    event_name = 'page_view'
    ```

```
# Page dimensions & metrics (GA4)

```
select
  -- user type (dimension)
  case when totals.newvisits = 1 then 'New visitor' else 'Returning visitor' end as user_type,
  -- count of sessions (dimension)
  visitnumber as count_of_sessions,
  -- users (metric)
  count(distinct fullvisitorid) as users,
  -- new users (metric)
  count(distinct(case when totals.newvisits = 1 then fullvisitorid else null end)) as new_users,
  -- % new sessions (metric)
  count(distinct(case when totals.newvisits = 1 then fullvisitorid else null end)) / count(distinct concat(fullvisitorid, cast(visitstarttime as string))) as percentage_new_sessions,
  -- number of sessions per user (metric)
  count(distinct concat(fullvisitorid, cast(visitstarttime as string))) / count(distinct fullvisitorid) as number_of_sessions_per_user,
  -- hits (metric)
  sum((select totals.hits from unnest(hits) group by totals.hits)) as hits
from
  `bigquery-public-data.google_analytics_sample.ga_sessions_20160801`
group by
  user_type,
  count_of_sessions
order by
  count_of_sessions

```

# Date and time dimensions & metrics (GA4)

```
select
    -- dimension | the date on which the event was logged (YYYYMMDD format in the registered timezone of your app
    event_date,
    -- dimension | the time (in microseconds, UTC) at which the event was logged on the client
    event_timestamp,
    -- dimension | the time (in microseconds, UTC) at which the event was previously logged on the client.
    event_previous_timestamp,
    -- dimension | timestamp offset between collection time and upload time in micros
    event_server_timestamp_offset,
    -- dimension | the time (in microseconds) at which the user first opened the app or visited the site
    user_first_touch_timestamp,
    -- dimension | the time (in microseconds) at which the user property was last set
    (select value.set_timestamp_micros from unnest(user_properties) where key = '<insert key>') as user_set_timestamp_micros

from
    `ga4bigquery.analytics_250794857.events_*`
where
    -- define static and/or dynamic start and end date
    _table_suffix between '20220901'
    and format_date('%Y%m%d',date_sub(current_date(), interval 1 day))
```

# Session dimensions & metrics (GA4)

```

```

# Geo location dimensions & metrics (GA4)

```
select
    -- geo.continent (dimension | the continent from which events were reported, based on ip address)
    geo.continent,
    -- geo.sub_continent (dimension | the subcontinent from which events were reported, based on ip address)
    geo.sub_continent,
    -- geo.country (dimension | the country from which events were reported, based on ip address)
    geo.country,
     -- geo.region (dimension | the region from which events were reported, based on ip address)
    geo.region,
    -- geo.city (dimension | the city from which events were reported, based on ip address)
    geo.city,
    -- geo.metro (dimension | the metro from which events were reported, based on ip address)
     geo.metro
from
    `ga4bigquery.analytics_250794857.events_*`
where
    -- define static and/or dynamic start and end date
    _table_suffix between '20220901'
    and format_date('%Y%m%d',date_sub(current_date(), interval 1 day))
```

# Device, app, web, stream and platform dimensions & metrics (GA4)

```
select
    -- device.category (dimension | the device category (mobile, tablet, desktop))
    device.category as device_category,
    -- device.mobile_brand_name (dimension | the device brand name)
    device.mobile_brand_name,
    -- device.mobile_model_name (dimension | the device model name)
    device.mobile_model_name,
    -- device.mobile_marketing_name (dimension | the device marketing name)
    device.mobile_marketing_name,
    -- device.mobile_os_hardware_model (dimension | the device model information retrieved directly from the operating system)
    device.mobile_os_hardware_model,
    -- device.operating_system (dimension | the operating system of the device)
    device.operating_system,
    -- device.operating_system_version (dimension | the os version)
    device.operating_system_version,
    -- device.vendor_id (dimension | idfv (present only if idfa is not collected))
    device.vendor_id,
    -- device.advertising_id (dimension | advertising id/idfa)
    device.advertising_id,
    -- device.language (dimension | the os language)
    device.language,
    -- device.is_limited_ad_tracking (dimension | the device's limit ad tracking setting)
    device.is_limited_ad_tracking,
    -- device.time_zone_offset_seconds (dimension | the offset from gmt in seconds)
    device.time_zone_offset_seconds,
    -- device.browser (dimension | the browser in which the user viewed content)
    device.browser,
    -- device.browser_version (dimension | the version of the browser in which the user viewed content)
    device.browser_version,
    -- device.web_info.browser (dimension | the browser in which the user viewed content)
    device.web_info.browser as web_browser,
    -- device.web_info.browser_version (dimension | the version of the browser in which the user viewed content)
    device.web_info.browser_version as web_browser_version,
    -- device.web_info.hostname (dimension | the hostname associated with the logged event)
    device.web_info.hostname,
    -- app_info.id (dimension | the package name or bundle id of the app)
    app_info.id,
    -- app_info.version (dimension | the app's versionname (android) or short bundle version)
    app_info.version,
    -- app_info.install_store (dimension | the store that installed the app)
    app_info.install_store,
    -- app_info.firebase_app_id (dimension | the firebase app id associated with the app)
    app_info.firebase_app_id,
    -- app_info.install_source (dimension | the source that installed the app)
    app_info.install_source,
    -- stream_id (dimension | the numeric id of the stream)
    stream_id,
    -- platform (dimension | web or app platform)
    platform
from
    `ga4bigquery.analytics_250794857.events_*`
where
    -- define static and/or dynamic start and end date
    _table_suffix between '20220901'
    and format_date('%Y%m%d',date_sub(current_date(), interval 1 day))
```

# User dimensions & metrics (GA4)


```
select
    -- user_id (dimension | the user id set via the setUserId api)
    user_id,
    -- user_pseudo_id (dimension | the pseudonymous id (e.g., app instance id) for the user)
    user_pseudo_id,
    -- user_first_touch_timestamp (dimension | the time (in microseconds) at which the user first opened the app/website)
    timestamp_micros(user_first_touch_timestamp) as user_first_touch_timestamp,
    -- user_properties.key (dimension | the name of the user property | replace <insert key> with a parameter key or delete where clause to select all)
    (select key from unnest(user_properties) where key = '<insert key>') as user_properties_key,
    -- user_properties.value.string_value (dimension | the string value of the user property | replace <insert key> with a parameter key or delete where clause to select all)
    (select value.string_value from unnest(user_properties) where key = '<insert key>') as user_string_value,
    -- user_properties.value.int_value (metric | the integer value of the user property | replace <insert key> with a parameter key or delete where clause to select all)
    (select value.int_value from unnest(user_properties) where key = '<insert key>') as user_int_value,
    -- user_properties.value.float_value (metric | the float value of the user property | replace <insert key> with a parameter key or delete where clause to select all)
    (select value.float_value from unnest(user_properties) where key = '<insert key>') as user_float_value,
    -- user_properties.value.double_value (metric | the double value of the user property | replace <insert key> with a parameter key or delete where clause to select all)
    (select value.double_value from unnest(user_properties) where key = '<insert key>') as user_double_value,
    -- user_properties.value.set_timestamp_micros (dimension | the time (in microseconds) at which the user property was last set | replace <insert key> with a parameter key or delete where clause to select all)
    timestamp_micros((select value.set_timestamp_micros from unnest(user_properties) where key = '<insert key>')) as user_set_timestamp_micros,
    -- user_ltv.revenue (metric | the lifetime value (revenue) of the user)
    user_ltv.revenue as user_ltv_revenue,
    -- user_ltv.currency (dimension | the lifetime value (currency) of the user)
    user_ltv.currency as user_ltv_currency
from
    `ga4bigquery.analytics_250794857.events_*`
where
    -- define static and/or dynamic start and end date
    _table_suffix between '20201101'
    and format_date('%Y%m%d',date_sub(current_date(), interval 1 day))

```

# User dimensions & metrics (GA4)


```
select
    -- user_id (dimension | the user id set via the setUserId api)
    user_id,
    -- user_pseudo_id (dimension | the pseudonymous id (e.g., app instance id) for the user)
    user_pseudo_id,
    -- user_first_touch_timestamp (dimension | the time (in microseconds) at which the user first opened the app/website)
    timestamp_micros(user_first_touch_timestamp) as user_first_touch_timestamp,
    -- user_properties.key (dimension | the name of the user property | replace <insert key> with a parameter key or delete where clause to select all)
    (select key from unnest(user_properties) where key = '<insert key>') as user_properties_key,
    -- user_properties.value.string_value (dimension | the string value of the user property | replace <insert key> with a parameter key or delete where clause to select all)
    (select value.string_value from unnest(user_properties) where key = '<insert key>') as user_string_value,
    -- user_properties.value.int_value (metric | the integer value of the user property | replace <insert key> with a parameter key or delete where clause to select all)
    (select value.int_value from unnest(user_properties) where key = '<insert key>') as user_int_value,
    -- user_properties.value.float_value (metric | the float value of the user property | replace <insert key> with a parameter key or delete where clause to select all)
    (select value.float_value from unnest(user_properties) where key = '<insert key>') as user_float_value,
    -- user_properties.value.double_value (metric | the double value of the user property | replace <insert key> with a parameter key or delete where clause to select all)
    (select value.double_value from unnest(user_properties) where key = '<insert key>') as user_double_value,
    -- user_properties.value.set_timestamp_micros (dimension | the time (in microseconds) at which the user property was last set | replace <insert key> with a parameter key or delete where clause to select all)
    timestamp_micros((select value.set_timestamp_micros from unnest(user_properties) where key = '<insert key>')) as user_set_timestamp_micros,
    -- user_ltv.revenue (metric | the lifetime value (revenue) of the user)
    user_ltv.revenue as user_ltv_revenue,
    -- user_ltv.currency (dimension | the lifetime value (currency) of the user)
    user_ltv.currency as user_ltv_currency
from
    -- change this to your google analytics 4 export location in bigquery
    `ga4bigquery.analytics_250794857.events_*`
where
    -- define static and/or dynamic start and end date
    _table_suffix between '20201101'
    and format_date('%Y%m%d',date_sub(current_date(), interval 1 day))

```

#

```

```

#

```

```
