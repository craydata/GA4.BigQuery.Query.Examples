## GA4_BigQuery_Query_Examples
GA4_BigQuery_Query_Examples

# Dynamic date range
In this example we select period today-30 days to yesterday.

```
SELECT
  *
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE
  _table_suffix BETWEEN FORMAT_DATE('%Y%m%d',DATE_SUB(CURRENT_DATE(), INTERVAL 30 DAY))
  AND FORMAT_DATE('%Y%m%d',DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY))
```

## User
This example query contains all following Google Analytics dimensions and metrics. 

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

# Session: dimensions & metrics

```
select
  -- sessions (metric)
  count(distinct concat(fullvisitorid, cast(visitstarttime as string))) as sessions,
  -- bounces (metric)
  count(distinct case when totals.bounces = 1 then concat(fullvisitorid, cast(visitstarttime as string)) else null end) as bounces,
  -- bounce rate (metric)
  count(distinct case when totals.bounces = 1 then concat(fullvisitorid, cast(visitstarttime as string)) else null end) / count(distinct concat(fullvisitorid, cast(visitstarttime as string))) as bounce_rate,
  -- average session duration (metric)
  sum(totals.timeonsite) / count(distinct concat(fullvisitorid, cast(visitstarttime as string))) as average_session_duration
from
  `bigquery-public-data.google_analytics_sample.ga_sessions_20160801`
where
  totals.visits = 1
```
# Date and time: dimensions & metrics


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

# Traffic sources: dimensions & metrics


```
select
  -- referral path (dimension)
  trafficsource.referralpath as referral_path,
  -- full referrer (dimension)
  concat(trafficsource.source,trafficsource.referralpath) as full_referrer,
  -- default channel grouping
  channelgrouping as default_channel_grouping,
  -- campaign (dimension)
  trafficsource.campaign as campaign,
  -- source (dimension)
  trafficsource.source as source,
  -- medium (dimension)
  trafficsource.medium as medium,
  -- source / medium (dimension)
  concat(trafficsource.source," / ",trafficsource.medium) as source_medium,
  -- keyword (dimension)
  trafficsource.keyword as keyword,
  -- ad content (dimension)
  trafficsource.adcontent as ad_content,
  -- social network (dimension)
  (select social.socialnetwork from unnest(hits) group by social.socialnetwork) as social_network,
  -- social source (dimension)
  (select social.hassocialsourcereferral from unnest(hits) group by social.hassocialsourcereferral) as social_source,
  -- campaign code (dimension)
  trafficsource.campaigncode as campaign_code
from
  `bigquery-public-data.google_analytics_sample.ga_sessions_20160801`
where
  totals.visits = 1
```

# Geo network: dimensions & metrics


```
select
  -- continent (dimension)
  geonetwork.continent as continent,
  -- sub continent (dimension)
  geonetwork.subcontinent as sub_continent,
  -- country (dimension)
  geonetwork.country as country,
  -- region (dimension)
  geonetwork.region as region,
  -- metro (dimension)
  geonetwork.metro as metro,
  -- city (dimension)
  geonetwork.city as city,
  -- latitude (dimension)
  geonetwork.latitude as latitude,
  -- longitude (dimension)
  geonetwork.longitude as longitude,
  -- network domain (dimension)
  geonetwork.networkdomain as network_domain,
  -- service provider (dimension)
  geonetwork.networklocation as service_provider,
  -- city id (dimension)
  geonetwork.cityid as city_id
from
  `bigquery-public-data.google_analytics_sample.ga_sessions_20160801`
where
  totals.visits = 1
```

# Platform and device: dimensions & metrics

```
select
  -- browser (dimension)
  device.browser as browser,
  -- browser version (dimension)
  device.browserversion as browser_version,
  -- operating system (dimension)
  device.operatingsystem as operating_system,
  -- operating system version (dimension)
  device.operatingsystemversion as operating_system_version,
  -- mobile device branding (dimension)
  device.mobiledevicebranding as mobile_device_branding,
  -- mobile device model (dimension)
  device.mobiledevicemodel as mobile_device_model,
  -- mobile input selector (dimension)
  device.mobileinputselector as mobile_input_selector,
  -- mobile device info (dimension)
  device.mobiledeviceinfo as mobile_device_info,
  -- mobile device marketing name (dimension)
  device.mobiledevicemarketingname as mobile_device_marketing_name,
  -- device category (dimension)
  device.devicecategory as device_category,
  -- browser size (dimension)
  device.browsersize as browser_size,
  -- data source (dimension)
  (select datasource from unnest(hits) group by datasource) as data_source
from
  `bigquery-public-data.google_analytics_sample.ga_sessions_20160801`
where
  totals.visits = 1

```

# Page Tracking


```
select
  hostname,
  page,
  previous_page,
  page_path_level_1,
  page_path_level_2,
  page_path_level_3,
  page_path_level_4,
  page_title,
  landing_page,
  second_page,
  exit_page,
  -- entrances (metric)
  countif(isentrance = true) as entrances,
  -- pageviews (metric)
  count(*) as pageviews,
  -- pages per session (metric)
  count(*) / count(distinct concat(fullvisitorid, cast(visitstarttime as string))) as pages_per_session,
  -- exits (metric)
  countif(isexit = true) as exits,
  -- exit rate (metric)
  countif(isexit = true) / count(*) as exit_rate
from (
  select
    -- hostname (dimension)
    hits.page.hostname as hostname,
    -- page (dimension)
    hits.page.pagepath as page,
    -- previous page (dimension)
    lag(hits.page.pagepath, 1) over (partition by fullvisitorid, visitstarttime order by hits.hitnumber asc) as previous_page,
    -- page path level 1 (dimension)
    hits.page.pagepathlevel1 as page_path_level_1,
    -- page path level 2 (dimension)
    nullif(hits.page.pagepathlevel2,'') as page_path_level_2,
    -- page path level 3 (dimension)
    nullif(hits.page.pagepathlevel3,'') as page_path_level_3,
    -- page path level 4 (dimension)
    nullif(hits.page.pagepathlevel4,'') as page_path_level_4,
    -- page title (dimension)
    hits.page.pagetitle as page_title,
    -- landing page (dimension)
    case when hits.isentrance = true then hits.page.pagepath else null end as landing_page,
    -- second page (dimension)
    case when hits.isentrance = true then (lead(hits.page.pagepath, 1) over (partition by fullvisitorid, visitstarttime order by hits.hitnumber asc)) else null end as second_page,
    -- exit page (dimension)
    case when hits.isexit = true then hits.page.pagepath else null end as exit_page,
    hits.isentrance,
    fullvisitorid,
    visitstarttime,
    hits.isexit
  from
    `bigquery-public-data.google_analytics_sample.ga_sessions_20160801`,
    unnest(hits) as hits
  where
    totals.visits = 1
    and hits.type = 'PAGE')
group by
  hostname,
  page,
  previous_page,
  page_path_level_1,
  page_path_level_2,
  page_path_level_3,
  page_path_level_4,
  page_title,
  landing_page,
  second_page,
  exit_page
order by
  pageviews desc
```

#

```

```

#

```

```

#

```

```

#

```

```
