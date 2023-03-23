CREATE TABLE fact_sales (
	sales_id bigserial NOT NULL,
	transation_number integer NOT NULL UNIQUE,
	product_id bigint NOT NULL,
	date_id bigint NOT NULL,
	customer_id bigint NOT NULL,
	supplier_id bigint NOT NULL,
	sales_amount money NOT NULL,
	discount_amount money NOT NULL,
	CONSTRAINT pk_fact_sales
	PRIMARY KEY (sales_id)
);

CREATE TABLE dim_order(
	order_id integer NOT NULL UNIQUE,
	order_code varchar(20) NOT NULL,
	order_status varchar(20) NOT NULL,
	CONSTRAINT pk_dim_order
	PRIMARY KEY (order_id)
);

CREATE TABLE dim_product (
	product_id bigserial NOT NULL,
	product_stock_id integer NOT NULL,
	product_code varchar(12) NOT NULL,
	product_name varchar(100) NOT NULL,
	product_category varchar(50) NOT NULL,
	product_description text,
	unit_price_without_vat money NOT NULL,
	unit_price_with_vat money GENERATED ALWAYS AS ( unit_price_without_vat * 1.21 ) STORED,
	vat_amount money GENERATED ALWAYS AS ( unit_price_without_vat * 21 / 100 ) STORED,
	currency varchar(3),
	discounted boolean NOT NULL,
	discount_rate smallint,
	CONSTRAINT pk_dim_product
	PRIMARY KEY (product_id)
);

CREATE TABLE dim_product_stock (
	products_stock_id integer NOT NULL UNIQUE,
	units_is_stock integer NOT NULL,
	units_on_order integer NOT NULL,
	units_shipped integer NOT NULL,
	shippment_date date,
	reorder_level integer,
	CONSTRAINT pk_dim_product_stock
	PRIMARY KEY (products_stock_id)
);

CREATE TABLE dim_date (
	date_id bigserial NOT NULL,
	date timestamp with time zone NOT NULL,
	calendar_year smallint NOT NULL,
	fiscal_year smallint NOT NULL,
	CONSTRAINT pk_dim_date
	PRIMARY KEY (date_id)
);

CREATE TABLE dim_customer (
	customer_id bigserial NOT NULL,
	company_name varchar(120),
	customer_type varchar(20) NOT NULL,
	contact_full_name varchar(120) NOT NULL,
	contact_title varchar(8) NOT NULL,
	customer_address varchar(50) NOT NULL,
	city varchar(20) NOT NULL,
	region varchar(20) NOT NULL,
	country varchar(20) NOT NULL,
	country_code varchar(2) NOT NULL,
	phone varchar(20) NOT NULL,
	contract_signed boolean NOT NULL,
	CONSTRAINT pk_dim_customer
	PRIMARY KEY (customer_id)
);


CREATE TABLE dim_supplier (
supplier_id bigserial NOT NULL,
supplier_type varchar(20) NOT NULL,
contact_full_name varchar(120) NOT NULL,
contact_title varchar(8) NOT NULL,
supplier_address varchar(50) NOT NULL,
city varchar(20) NOT NULL,
region varchar(20) NOT NULL,
country varchar(20) NOT NULL,
country_code varchar(2) NOT NULL,
phone varchar(20) NOT NULL,
CONSTRAINT pk_dim_supplier
PRIMARY KEY (supplier_id)
);