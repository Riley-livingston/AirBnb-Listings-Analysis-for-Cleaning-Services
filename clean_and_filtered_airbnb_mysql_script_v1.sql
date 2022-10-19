SELECT host_id,
	   host_name,
	   host_url,
	   host_total_listings_count,
	   COUNT(DISTINCT comments) as dirty_review_count,
	   CAST(review_scores_cleanliness AS FLOAT) AS review_scores_cleanliness_clean,
	   CAST(review_scores_rating AS FLOAT) AS review_scores_rating_clean
FROM reviews r
INNER JOIN listings l 
ON l.id = r.listing_id
WHERE r.comments  LIKE  '%dirt%'
	OR r.comments LIKE  '%unclean%'
	OR r.comments LIKE  '%dust%' 
	OR r.comments LIKE  '%mess%' 
    OR r.comments LIKE  '%filth%' 
	OR r.comments LIKE  '%grimy%' 
    OR r.comments LIKE  '%stain%'
	OR r.comments LIKE  '%unkempt%' 
	OR r.comments LIKE  '%stink%' 
	OR r.comments LIKE  '%smell%' 
	OR r.comments LIKE  '%unsanitary%'
	OR r.comments LIKE  '%foul%'
	OR r.comments LIKE  '%nasty%'
	OR r.comments LIKE  '%disgust%'
	OR r.comments LIKE  '%odor%'
AND LENGTH(review_scores_rating) <= 4
AND review_scores_rating LIKE '%.%'
AND LENGTH(review_Scores_cleanliness) <= 4
AND review_scores_cleanliness LIKE '%.%'
GROUP BY host_id, host_url, host_name
ORDER BY dirty_review_count DESC