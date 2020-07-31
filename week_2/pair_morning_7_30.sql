--n pgAdmin, select the productpurchases database and open the Query Tool.

    --Write a query that joins the purchase_items and product tables. 
	--The query should return the purchase ID, title, quantity, 
	--and price fields for all returned laptop computers.
	
   -- Write a query that joins all 4 tables in the database
   --and returns all MP3 Player purchase line items that are in pending status 
   --and were ordered from the state of Florida (FL) by email address Derek.Knittel@gmail.com. 
   --The query should return the purchase ID, the order status, the customer name, the state, 
   --the product name, the order quantity, the order price, and the customer email.


SELECT purchase_id, title, quantity, pr.price
FROM purchase_items AS pi
	JOIN products AS pr
ON pi.product_id = pr.id
WHERE pr.title = 'Laptop Computer' AND pi.state = 'Returned';


SELECT DISTINCT
	pi.purchase_id
	,pi.state
	,pu.name
	,pu.state
	,pr.title
	,pi.quantity
	,pi.price
	,u.email
FROM purchase_items AS pi
	 JOIN products AS pr
ON pi.product_id = pr.id
	 JOIN purchases AS pu
ON pi.purchase_id = pu.id
	 JOIN users AS u
ON pu.user_id = u.id
WHERE pr.title = 'MP3 Player' AND u.email = 'Derek.Knittel@gmail.com' AND pi.state = 'Pending' AND pu.state = 'FL';


SELECT 
	pr.title,
	pi.state
FROM purchase_items AS pi
	JOIN products AS pr
ON pi.product_id =  pr.id
WHERE pr.title = 'MP3 Player' AND pi.state = 'Pending';


	

SELECT * FROM purchase_items LIMIT 10;