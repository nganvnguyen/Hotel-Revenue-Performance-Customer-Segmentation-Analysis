/* Question 1: Why do Last-Minute (0-7 days) or Medium-Window (8-30 days) has fewer cancellations than Early-window booking (>30 days)? */

WITH customer_group_cancellations AS (
SELECT bucket,
		booking_status, deposit_type,
		(CASE WHEN booking_status = 'Cancelled' THEN 1 ELSE 0 END) as cancellations
FROM fresh-waters-483503-j3.hotel.hotel_bookings_cleaned
)
SELECT bucket,
		deposit_type,
		COUNT(*) as total_booking,
		SUM(cancellations) as total_cancellations,
		ROUND(
			SUM(cancellations) * 100.0 / 
			NULLIF(COUNT(*),0),2) as cancellation_rate
FROM customer_group_cancellations
GROUP BY bucket, deposit_type
ORDER BY bucket, deposit_type;
------------------------------------------

