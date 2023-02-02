with mailcredentials as (
    SELECT _id,mailId,password,mailUserName,popMailHost,popMailPort,smtpMailHost,smtpMailPort,status,item_object FROM (SELECT _id,mailId,password,mailUserName,popMailHost,popMailPort,smtpMailHost,smtpMailPort,status, arr.position,arr.item_object FROM mailcredentials,
	jsonb_array_elements(transactions) with ordinality arr(item_object, position)) as a
),

inter_mailcredentials as (
	select mailcredentials._id,
	       mailcredentials.mailId,
	       mailcredentials.password,
           mailcredentials.mailUserName,
           mailcredentials.popMailHost,
           mailcredentials.popMailPort,
           mailcredentials.smtpMailHost,
           mailcredentials.smtpMailPort,
           mailcredentials.status,
           mailcredentials.item_object->'actionBy'->'name' as name,
           mailcredentials.item_object->'actionBy'->'empId' as empId,
           mailcredentials.item_object->'actionBy'->'branch' as branch,
           mailcredentials.item_object->'actionBy'->'branchCode' as branchCode,
           mailcredentials.item_object->'actionBy'->'date' as actionDate
    from mailcredentials
),

final as (
    select _id,
           trim('"' from mailId::text) as mailId,
    	   trim('"' from password::text) as password,
    	   trim('"' from mailUserName::text) as mailUserName,
    	   trim('"' from popMailHost::text) as popMailHost,
    	   trim('"' from popMailPort::text) as popMailPort,
    	   trim('"' from smtpMailHost::text) as smtpMailHost
           trim('"' from smtpMailPort::text) as smtpMailPort
           status::boolean as status,
           trim('"' from name::text) as name,
           trim('"' from empId::text) as empId,
           trim('"' from branch::text) as branch,
           trim('"' from branchCode::text) as branchCode,
           actionDate::text::timestamp as actionDate
    from inter_mailcredentials
)

select * from final