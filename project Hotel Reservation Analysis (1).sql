use project;

select * from [dbo].[Hotel Reservation Dataset (1)]
--1. What is the total number of reservations in the dataset?
select count(room_type_reserved) as Total_number_of_resevation
from [dbo].[Hotel Reservation Dataset (1)];








---2. Which meal plan is the most popular among guests?
SELECT type_of_meal_plan, COUNT(type_of_meal_plan) AS total_reservations
FROM [dbo].[Hotel Reservation Dataset (1)]
GROUP BY type_of_meal_plan;






------3. What is the average price per room for reservations involving children?
SELECT AVG(avg_price_per_room) AS avg_price_per_room_with_children
FROM [dbo].[Hotel Reservation Dataset (1)]
WHERE no_of_children > 0;



-----4. How many reservations were made for the year 20XX (replace XX with the desired year)?
SELECT COUNT(*) AS total_reservations_for_2018
FROM [dbo].[Hotel Reservation Dataset (1)]
WHERE YEAR(arrival_date) = 2018;


----5. What is the most commonly booked room type?
SELECT room_type_reserved, COUNT(*) AS reservation_count
FROM [dbo].[Hotel Reservation Dataset (1)]
GROUP BY room_type_reserved
ORDER BY reservation_count;


----6. How many reservations fall on a weekend (no_of_weekend_nights > 0)?
select no_of_weekend_nights, count(*) as weekend_reservations
FROM [dbo].[Hotel Reservation Dataset (1)]
GROUP BY no_of_weekend_nights
ORDER BY no_of_weekend_nights
---7. What is the highest and lowest lead time for reservations?
SELECT 
    MAX(lead_time) AS highest_lead_time,
    MIN(lead_time) AS lowest_lead_time
FROM [dbo].[Hotel Reservation Dataset (1)]
WHERE lead_time IS NOT NULL;


-----8. What is the most common market segment type for reservations?
select market_segment_type, count(*) FROM [dbo].[Hotel Reservation Dataset (1)]
group by market_segment_type
order by market_segment_type desc;

----9. How many reservations have a booking status of "Confirmed"?
select booking_status, count(*) FROM [dbo].[Hotel Reservation Dataset (1)]
group by booking_status
order by booking_status ;




----10. What is the total number of adults and children across all reservations?
select sum(no_of_adults) + sum(no_of_children) as total_people 
FROM [dbo].[Hotel Reservation Dataset (1)]

-----11. What is the average number of weekend nights for reservations 
--involving children?
SELECT AVG(no_of_weekend_nights) AS avg_weekend_nights_with_children
    FROM  [dbo].[Hotel Reservation Dataset (1)]
    WHERE no_of_children > 0
    GROUP BY no_of_adults, no_of_children



----12. How many reservations were made in each month of the year?

SELECT 
      YEAR(arrival_date) AS reservation_year,
    MONTH(arrival_date) AS reservation_month,
    COUNT(*) AS num_reservations
FROM  [dbo].[Hotel Reservation Dataset (1)]
GROUP BY 
  YEAR(arrival_date), MONTH(arrival_date)
  ORDER BY 
    reservation_year, reservation_month;


---13. What is the average number of nights (both weekend and weekday) 
---spent by guests for each room type?
SELECT 
    room_type_reserved AS room_type,
    AVG(no_of_weekend_nights) AS avg_weekend_nights,
    AVG(no_of_week_nights) AS avg_weekday_nights
FROM [dbo].[Hotel Reservation Dataset (1)] 
GROUP BY 
    room_type_reserved;






---14. For reservations involving children, what is the most common room type, 
---and what is the average price for that room type?
WITH ChildrenReservations AS (
    SELECT 
        room_type_reserved,
        AVG(avg_price_per_room) AS avg_price_per_room,
        COUNT(*) AS num_reservations FROM [dbo].[Hotel Reservation Dataset (1)] 
    WHERE no_of_children > 0
    GROUP BY room_type_reserved)
SELECT TOP 1
    room_type_reserved AS most_common_room_type_for_children,
    avg_price_per_room AS avg_price_for_most_common_room_type
FROM  ChildrenReservations
ORDER BY  num_reservations DESC;

--15. Find the market segment type that generates the highest average price per room.
SELECT 
    market_segment_type,
    AVG(avg_price_per_room) AS avg_price_per_room
FROM 
    [dbo].[Hotel Reservation Dataset (1)] 
GROUP BY 
    market_segment_type
ORDER BY 
    avg_price_per_room DESC;