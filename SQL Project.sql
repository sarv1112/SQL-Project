/*
My parner and I want ro come by each of the stores in person and meet the managers.
Please send over the managers names at each store, with the full addresses
of each property (street address,district,city and country please).
*/

Select 
staff.first_name AS manager_first_name,
staff.last_name AS manager_last_name,
address.address,
address.district,
city.city,
country.country

From store
Left join staff ON store.manager_staff_id = staff.staff_id
Left join address ON store.address_id = address.address_id
Left join city ON address.city_id= city.city_id
Left join country ON city.country_id= country.country_id

;

/*
2. I would like to get a better understanding of all the inventory that would come along with the business.
 Please pull together a list of each inventory item you have stocked, including the store_id number,
 the inventory_id, the name of the film's rating, its rental rate and replacement cost. 
 
*/

Select 
inventory.store_id,
inventory.inventory_id,
film.title,
film.rating,
film.rental_rate,
film.replacement_cost
From inventory
Left join film
On inventory.film_id =film.film_id

;

/* 
3. From the sam elist of films you just pulled, please roll that data up and provide a summary level overview of your inventory.
We would like to know how many inventory items you have with each rating at each store. 
*/

Select 
inventory.store_id,
film.rating,
Count(inventory_id) AS inventory_items
From inventory
Left join film
ON inventory.film_id = film.film_id
Group By 
inventory.store_id,
film.rating

;

/*
4. we would like to undestand how much your customers are spending with you, and also to know
who your most valuable customers are. Please pull together a list of customer names, their total lifetime rental,
and the sum of the payments you have collected from them. It would be great to see this ordered
on total lifetime value, with most valuable customers at the top of the list. 
*/

Select 
customer.first_name,
customer.last_name,
count(rental.rental_id) As total_rental,
SUM(payment.amount) As total_payment_amount

From customer
Left Join rental ON customer.customer_id = rental.customer_id
Left join payment On rental.rental_id = payment.rental_id

Group by
customer.first_name,
customer.last_name

Order by 
Sum(payment.amount) Desc
;

/*
My partner and I would like to know your board of advisors and current investorys
Could you please provide a list of advisor and investory names in one table?
Could you please note wheather they are an investory or an advisor, and for the investors,
it would be goof to include company they work with. 
*/

Select 
'investor' As type,
first_name,
last_name,
company_name
From investor

Union 


Select 
'advisor' As type,
first_name,
last_name,
Null
From advisor ;

/*
We are interested in how well you have covered the most-awarded actors.
of all the actors with three type of awards, for what % of them do we carry a film?
and how about for actors with two types of awards? Same questions.
Finally, how about actors with jsut one awards?
*/
 
Select
Case
When actor_award.awards = 'Emmy, Oscar, Tony' THEN '3 awards'
When actor_award.awards IN ('Emmy, Oscar', 'Emmy, Tony' ,'Oscar, Tony') Then '2 awards'
ELSE '1 award'
End as number_of_awards,
AVG(Case WHEN actor_award.actor_id IS Null THEN 0 Else 1 End) AS pct_w_one_film

From actor_award
Group BY 
Case
When actor_award.awards = 'Emmy, Oscar, Tony' THEN '3 awards'
When actor_award.awards IN ('Emmy, Oscar', 'Emmy, Tony' ,'Oscar, Tony') Then '2 awards'
ELSE '1 award'
End




