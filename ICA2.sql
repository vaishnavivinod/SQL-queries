-- 1. Table: Airbnb_search_details
    -- Find the average number of beds in each neighborhood that has at least 3 beds in total.
    SELECT neighbourhood, AVG(beds) AS avg_beds
    FROM airbnb_search_details
    WHERE neighbourhood IS NOT NULL
    GROUP BY neighbourhood
    HAVING SUM(beds) >= 3;
 

    -- Find the average accommodates-to-beds ratio for shared rooms in each city.
        -- Sort your results by listing cities with the highest ratios first.
    SELECT city, AVG(accommodates / beds) AS average_ratio
    FROM airbnb_search_details
    WHERE room_type = 'Shared room'
    GROUP BY city
    ORDER BY average_ratio DESC;

    -- Find the average number of bathrooms and bedrooms for each city’s property types. Output the result along with the city name and the property type. Airbnb_search_details
    SELECT city
    , property_type
    , AVG(bedrooms) AS avg_bedrooms
    , AVG(bathrooms) AS avg_bathrooms
    FROM airbnb_search_details
    GROUP BY city, property_type;
-- 2. Table: google_adwords_earnings
    -- Find the total AdWords earnings for each business type.
    -- Output the business types along with the total earnings.
    SELECT business_type, SUM(adwords_earnings) AS total_earnings
    FROM google_adwords_earnings
    GROUP BY business_type;

-- 3. Tables: google_gmail_emails, google_gmail_labels
    -- How many times did each email label occur for each user?
    SELECT to_user, label, COUNT(*) AS label_count
    FROM google_gmail_emails
    JOIN google_gmail_labels ON google_gmail_emails.id = google_gmail_labels.email_id
    GROUP BY to_user, label
    ORDER BY to_user;

-- 4. Tables: facebook_reactions, facebook_posts
    -- Find all posts which were reacted to with a heart
    SELECT fp.post_id, fp.post_text
    FROM facebook_posts fp
    JOIN facebook_reactions fr ON fp.post_id = fr.post_id
    WHERE fr.reaction = 'heart';

-- 5. Tables: airbnb_reviews, airbnb_guests
    -- Each host reviews multiple guests. What is the average age of guests reviewed by each host?
    SELECT ar.from_user AS host_id
    , AVG(ag.age) AS average_guest_age
    FROM airbnb_reviews ar
    JOIN airbnb_guests ag ON ar.to_user = ag.guest_id
    GROUP BY ar.from_user;

-- 6. Tables: airbnb_guests, airbnb_hosts
    -- Match hosts and guests such that they are both of same gender and same nationality.
    SELECT ah.host_id
    , ag.guest_id
    , ag.nationality
    , ag.gender
    FROM airbnb_hosts ah
    JOIN airbnb_guests ag ON ah.gender = ag.gender AND ah.nationality = ag.nationality;

-- 7. Tables: airbnb_apartments, airbnb_hosts
    -- Make a breakdown showing the total number of available
        -- apartments per host nation (does not have to be equal to apartment location nation).
    SELECT ah.nationality AS host_nationality,
    COUNT(aa.apartment_id) AS total_available_apartments
    FROM airbnb_hosts ah
    JOIN airbnb_apartments aa ON ah.host_id = aa.host_id
    GROUP BY ah.nationality;

-- 8. Tables: customers, orders
    -- Find the details of each customer regardless of whether the customer made an order.
    -- Output the customer's first name, last name, and the city along with the order details.
    -- You may have duplicate rows in your results due to a customer ordering several of the same items.
    -- Sort records based on the customer's first name and the order details in ascending order.
    SELECT c.first_name
    , c.last_name
    , c.city
    , o.order_date
    , o.order_details
    , o.order_quantity
    , o.order_cost
    FROM customers c
    LEFT JOIN orders o ON c.id = o.cust_id
    ORDER BY c.first_name ASC, o.order_details ASC;

-- 9. Tables: customers, orders
    -- Find the number of customers without an order
    SELECT COUNT(*) AS customers_without_order
    FROM customers 
    LEFT JOIN orders ON customers.id = orders.cust_id
    WHERE orders.cust_id IS NULL;

-- 10. Tables:  facebook_europe_energy_consumption, facebook_na_energy_consumption,    facebook_asia_energy_consumption
    -- Find the cumulative total consumption of energy for facebook's
    -- data servers in all 3 continents.  You will need to add the
    -- three columns together to get a total energy consumption column.
    -- To do that, in the SELECT clause do col1 + col2+ col3.
    -- ROUND(number, decimal places) function to round decimals
    SELECT facebook_europe_energy_consumption.date,
       ROUND(facebook_europe_energy_consumption.consumption 
           + facebook_na_energy_consumption.consumption 
           + facebook_asia_energy_consumption.consumption, 2) AS total_energy_consumption
    FROM facebook_europe_energy_consumption
    JOIN facebook_na_energy_consumption ON facebook_europe_energy_consumption.date = facebook_na_energy_consumption.date
    JOIN facebook_asia_energy_consumption ON facebook_europe_energy_consumption.date = facebook_asia_energy_consumption.date;

