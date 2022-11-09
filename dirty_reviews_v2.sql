SELECT host_id, -- uniquely identifies each host--
	   host_name, --Name of the person or organization who owns the Airbnb listing
	   listing_id,  --uniquely identifies each listing
	   listing_url, --provides a link to a specific listings webpage
	   30 - availability_30 AS booked_out_of_30, --days booked in the next 30 days from September 7th 2022
	   60 - availability_60 AS booked_out_of_60, --days booked in the next 60 days from September 7th 2022
	   90 - availability_90 AS booked_out_of_90, --days booked in the next 90 days from September 7th 2022
	   365 - availability_365 AS booked_out_of_365, --days booked in the next 365 days from Septemeber 7th 2022
	   CAST(review_scores_rating AS FLOAT) AS review_scores_rating_clean, --Review score rating casted as a float data type to correct any invalid data 
	   CASE WHEN instant_bookable == "f" THEN 0 --when instant bookability without a host approval is false its coded as 0
	   	    WHEN instant_bookable == "t" THEN 1 ELSE NULL END AS instant_bookable_clean, -- when instant bookability is true its coded as 1
	   CAST(REPLACE(Price, '$', '') AS UNSIGNED) AS price_clean, --the dollar sign is removed from price so it can be used with operators and in aggregation
	   CAST(bedrooms AS INT) AS bedrooms_clean, --the number of bedrooms a listing has is converted into an integer data type to correct invalid data
	   room_type,
	   property_type,
	   CASE WHEN host_has_profile_pic == 't' THEN 1 -- when the host of a lsiting has a profile picture the column is coded as a 1
	        WHEN host_has_profile_pic == 'f' THEN 0 -- when the host doesnt have a profile picture its coded as a 0
	        ELSE NULL END AS host_has_profile_pic_clean, --when the column has neither a 'f' or 'f' value, its coded as null
	   CASE WHEN  host_identity_verified =='t' THEN 1 --when the host is verified on airbnb, the column is coded as a 1
	       WHEN  host_identity_verified =='f' THEN 0 --0 if not verified
	       ELSE NULL END AS host_identity_verified_clean, --if neither f nor t are true then null is returned for that row
	   neighbourhood_cleansed,
	   neighbourhood_group_cleansed,
	   CAST(host_total_listings_count AS INT) AS host_total_listings_count_clean, --host_total_listing count is cast as an integar so the variable can be used in aggregation--
	   CAST(number_of_reviews AS INT) AS number_of_reviews_clean , --number_of_reviews is casted as an integer so the variable can be used in aggregation--
	   COUNT(DISTINCT comments) AS dirty_review_count --distinct rows from the comment column in the review table are counted as a dirty review if the variable meets the conditions in the where clause
FROM reviews r
INNER JOIN listings l -- An inner Join is made on the primary key, id, in the listing table and the foreign key , listing_id, in the reviews table returning the columns where there is a match
ON l.id = r.listing_id
WHERE (r.comments LIKE '%dirt%' 
	OR r.comments LIKE '%unclean%' 
	OR r.comments LIKE '%dust%'
	OR r.comments LIKE '%mess%'
        OR r.comments LIKE '%filth%'
	OR r.comments LIKE '%grimy%'
        OR r.comments LIKE '%stain%'
	OR r.comments LIKE '%unkempt%'
	OR r.comments LIKE '%stink%'
	OR r.comments LIKE '%smell%' 
	OR r.comments LIKE '%unsanitary%' 
	OR r.comments LIKE '%foul%'
	OR r.comments LIKE '%nasty%'
	OR r.comments LIKE '%disgust%'
	OR r.comments LIKE '%odor%'
	OR r.comments LIKE '%roach%'
	OR r.comments LIKE '%bug%'
	OR r.comments LIKE '%rancid%'
	OR r.comments LIKE '%stench%'
	OR r.comments LIKE '%nasty%' 
	OR r.comments LIKE '%spoil%'
	OR r.comments LIKE '%disarray%'
	OR r.comments LIKE '%contaminate%'
	OR r.comments LIKE '%bawdy%'
	OR r.comments LIKE '%gross%'
	OR r.comments LIKE '%untidy%'
	OR r.comments LIKE '%sloppy%'
	OR r.comments LIKE '%disheveled%'
	OR r.comments LIKE '%unwashed%'
	OR r.comments LIKE '%unhygienic%'
	OR r.comments LIKE '%smoke%'
	OR r.comments LIKE '%soil%'
	OR r.comments LIKE '%unswept%'
	OR r.comments LIKE '%icky%'
	OR r.comments LIKE '%grubby%'
	OR r.comments LIKE '%raunchy%'
	OR r.comments LIKE '%smudge%'
	OR r.comments LIKE '%grease%'
	OR r.comments LIKE '%crum%'
	OR r.comments LIKE '%blotch%'	
	OR r.comments LIKE '%musty%'
	OR r.comments LIKE '%sticky%'
	OR r.comments LIKE '%fecal%'
	OR r.comments LIKE '%urine%'
	OR r.comments LIKE '%poo%'
	OR r.comments LIKE '%droppings%'
	OR r.comments LIKE '%disarray%'
	OR r.comments LIKE '%spotted%'
	OR r.comments LIKE '%crud%'
	OR r.comments LIKE '%unswept%'
	OR r.comments LIKE '%untidy%'
        OR r.comments LIKE '%unwashed%'
        OR r.comments LIKE '%unsightly%'
        OR r.comments LIKE '%yuck%')
AND booked_out_of_365 < 365  --listings with 365/365 days booked are exluded frm the analysis as they are extremely likely to be unavailable rather than fully booked for an entire year 
AND booked_out_of_365 > 0 --listings with 0/365 days booked are exlcuded for the same reason as above
AND price_clean > 2 --a handful of listings have a price of $2 and $1 per night. We excluded these from the query becasue they represent listings which are not taking bookings
GROUP BY listing_url, listing_id  --the query is grouped by unique listings so each row represents a unique 
ORDER BY 21 DESC, host_id -- the query is ordered by the count of distinct dirty reviews by listing and host id so we can gain immediate insight in who to contact for cleaning services
