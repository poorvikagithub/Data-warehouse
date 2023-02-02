with callRecordings as (
    SELECT _id,phone,url,item_object FROM (SELECT _id,phone,url, arr.position,arr.item_object FROM callrecordings,
	jsonb_array_elements(extraDetail) with ordinality arr(item_object, position)) as a
),

inter_callRecordings as (
	select callRecordings._id as _id,
	       callRecordings.phone,
	       callRecordings.url,
           callRecordings.item_object->'userId' as userId,
           callRecordings.item_object->'duration' as duration,
           callRecordings.item_object->'callType' as callType,
           callRecordings.item_object->'campaignName' as campaignName,
           callRecordings.item_object->'dispositionCode' as dispositionCode,
           callRecordings.item_object->'systemDisposition' as systemDisposition,
    from callRecordings
),

final as (
    select _id,
           trim('"' from phone::text) as phone,
    	   trim('"' from url::text) as url,
    	   trim('"' from duration::text) as duration,
    	   trim('"' from callType::text) as callType,
    	   trim('"' from campaignName::text) as campaignName,
    	   trim('"' from dispositionCode::text) as dispositionCode,
    	   trim('"' from systemDisposition::text) as systemDisposition
    from inter_callRecordings
)

select * from final