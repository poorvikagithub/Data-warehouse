with products as (

	select _id, customerId, mobileNo, item_object from (SELECT _id, customerId, mobileNo, arr.position,arr.item_object FROM related_products,
	jsonb_array_elements(products) with ordinality arr(item_object, position)) awith products as (

	select _id, customerId, mobileNo, item_object from (SELECT _id, customerId, mobileNo, arr.position,arr.item_object FROM related_products,
	jsonb_array_elements(products) with ordinality arr(item_object, position)) as a

),





inter_products as (
		
	select products._id as _id,
	   products.customerId,
	   products.mobileNo,
           products.item_object->'image' as image,
           products.item_object->'color' as color,
           products.item_object->'storage' as storage,
           products.item_object->'item_code' as item_code,
           products.item_object->'option_value' as option_value,
           products.item_object->'name' as name,
           products.item_object->'manufacturer' as manufacturer,
           products.item_object->'model' as model,
           products.item_object->'price' as price,
           products.item_object->'price_formatted' as price_formatted,
           products.item_object->'special' as special,	   
           products.item_object->'special_formatted' as special_formatted,
           products.item_object->'availability_stock' as availability_stock,
           products.item_object->'quantity' as quantity,
           products.item_object->'bfl' as bfl,	
           products.item_object->'slug' as slug,
           products.item_object->'productId' as productId,
           products.item_object->'itemCode' as itemCode,
           products.item_object->'addedBy' as addedBy,
           products.item_object->'addedOn'->'date' as addedOn
    from products

),

final as (

    select _id,
    	   trim('"' from customerId::text) as customerId,
    	   trim('"' from mobileNo::text) as mobileNo,
    	   trim('"' from image::text) as image,
    	   trim('"' from color::text) as color,
    	   trim('"' from storage::text) as storage,
    	   trim('"' from item_code::text) as item_code,
    	   trim('"' from option_value::text) as option_value,
    	   trim('"' from name::text) as name,
    	   trim('"' from manufacturer::text) as manufacturer,
    	   trim('"' from model::text) as model,
    	   price::numeric as price,
    	   trim('"' from price_formatted::text) as price_formatted,
    	   special::numeric as special,
    	   trim('"' from special_formatted::text) as special_formatted,
    	   trim('"' from availability_stock::text) as availability_stock,
    	   trim('"' from quantity::text) as quantity,
    	   bfl::boolean as bfl,
    	   trim('"' from slug::text) as slug,
    	   productId::integer as productId,
    	   trim('"' from itemCode::text) as itemCode,
    	   trim('"' from addedBy::text) as addedBy,
           addedOn::text::timestamp as addedOn
    from inter_products
)

select * from final
