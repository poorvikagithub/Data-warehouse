with serviceStatus as (

	select _id,service,customerId, mobile,email,branchName,imei,smsLink,item_object from (SELECT _id,service,customerId, mobile,email,branchName,imei,smsLink, arr.position,arr.item_object FROM  service-status-histories,
	jsonb_array_elemwith serviceStatus as (

	select _id,service,customerId, mobile,email,branchName,imei,smsLink,item_object from (SELECT _id,service,customerId, mobile,email,branchName,imei,smsLink, arr.position,arr.item_object FROM  service-status-histories,
	jsonb_array_elements(serviceStatus) with ordinality arr(item_object, position)) as a 
),


inter_serviceStatus as (
		
	select serviceStatus._id as _id,
    serviceStatus.service,
    serviceStatus.customerId,
	serviceStatus.mobile,
    serviceStatus.email,
    serviceStatus.branchName,
    serviceStatus.imei,
    serviceStatus.smsLink,
           serviceStatus.item_object->'actionBy'->'name' as name,
           serviceStatus.item_object->'actionBy'->'empId' as empId,
           serviceStatus.item_object->'actionBy'->'branch' as branch,
           serviceStatus.item_object->'actionBy'->'branchCode' as branchCode,
           serviceStatus.item_object->'actionBy'->'date' as actionDate
    from serviceStatus

),
final as (

    select _id,
    	   trim('"' from service::text) as service,
    	   trim('"' from customerId::text) as customerId,
    	   trim('"' from mobile::text) as mobile,
    	   trim('"' from email::text) as email,
    	   trim('"' from branchName::text) as branchName,
    	   trim('"' from imei::text) as imei,
            trim('"' from smsLink::text) as smsLink,
             trim('"' from name::text) as name,
    	   trim('"' from empId::text) as empId,
    	   trim('"' from branch::text) as branch,
           trim('"' from branchCode::text) as branchCode,
           actionDate::text::timestamp as actionDate
    from inter_serviceStatus
)

select * from final