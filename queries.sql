-- Multi-Table Query Practice

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.
select
	productname, categoryname
from product as p
join category as c
on p.categoryid = c.id

-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.
select
    o.id as orderId, companyname
from 'order' as o
join shipper as s
on o.shipvia = s.id
where o.orderdate < '2012-08-09'

-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.
select
    productname, o.quantity
from orderdetail as o
join product as p
on o.productid = p.id
where o.orderid = 10251
order by productname

-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.
select
    o.id as OrderId, c.companyname as CustomerCompany, lastname as employeeLastName
from 'order' as o
join customer as c
on o.customerid = c.id
join employee as e
on o.EmployeeId = e.id

-- Stretch

-- Find the number of shipments by each shipper.
select
	count(orderid) as shipmentsPerShipper, s.shippername
from orders as o
join shippers as s
on o.shipperid = s.shipperid
group by o.shipperid

-- Find the top 5 best performing employees measured in number of orders.
select
	count(orderid) as orderPerEmployee, (firstname || ' ' || lastname) as employee
from orders as o
join employees as e
on o.employeeid = e.employeeid
group by o.employeeid
order by orderPerEmployee DESC
limit 5

-- Find the top 5 best performing employees measured in revenue.
select
	(firstname || ' ' || lastname) as employee, sum(price * quantity) as revenue
from orderdetails as o
join products as p
on p.productid = o.productid
join orders
on o.orderid = orders.orderid
join employees as e
on orders.employeeid = e.employeeid
group by employee
order by revenue desc
limit 5

-- Find the category that brings in the least revenue.
select
	categoryname, sum(price * quantity) as revenue
from orderdetails as o
join products as p
on o.productid = p.productid
join categories as c
on c.categoryid = p.categoryid
group by categoryname
order by revenue asc

-- Find the customer country with the most orders.
select
	count(orderid) as ordersPerCountry, country
from orders as o
join customers as c
on c.customerid = o.customerid
group by country
order by ordersPerCountry desc

-- Find the shipper that moves the most cheese measured in units.
select
	shippername, sum(quantity * unit) as units
from orderdetails as o
join products as p
on p.productid = o.productid
join orders
on o.orderid = orders.orderid
join shippers as s
on s.shipperid = orders.shipperid
where p.categoryid = 5
group by shippername
order by units desc