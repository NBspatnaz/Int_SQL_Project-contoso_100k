CREATE TABLE "currencyexchange" (
  "date" date NOT NULL,
  "fromcurrency" varchar(10) NOT NULL,
  "tocurrency" varchar(10) NOT NULL,
  "exchange" doubleprecision
);

CREATE TABLE "customer" (
  "customerkey" int NOT NULL,
  "geoareakey" int,
  "startdt" date,
  "enddt" date,
  "continent" varchar(50),
  "gender" varchar(10),
  "title" varchar(20),
  "givenname" varchar(50),
  "middleinitial" varchar(5),
  "surname" varchar(50),
  "streetaddress" varchar(100),
  "city" varchar(50),
  "state" varchar(50),
  "statefull" varchar(100),
  "zipcode" varchar(20),
  "country" varchar(50),
  "countryfull" varchar(100),
  "birthday" date,
  "age" int,
  "occupation" varchar(100),
  "company" varchar(100),
  "vehicle" varchar(100),
  "latitude" doubleprecision,
  "longitude" doubleprecision
);

CREATE TABLE "date" (
  "date" date NOT NULL,
  "datekey" int,
  "year" int,
  "yearquarter" varchar(20),
  "yearquarternumber" int,
  "quarter" varchar(10),
  "yearmonth" varchar(20),
  "yearmonthshort" varchar(20),
  "yearmonthnumber" int,
  "month" varchar(20),
  "monthshort" varchar(10),
  "monthnumber" int,
  "dayofweek" varchar(20),
  "dayofweekshort" varchar(10),
  "dayofweeknumber" int,
  "workingday" int,
  "workingdaynumber" int
);

CREATE TABLE "product" (
  "productkey" int NOT NULL,
  "productcode" int,
  "productname" varchar(100),
  "manufacturer" varchar(100),
  "brand" varchar(50),
  "color" varchar(30),
  "weightunit" varchar(10),
  "weight" doubleprecision,
  "cost" doubleprecision,
  "price" doubleprecision,
  "categorykey" int,
  "categoryname" varchar(50),
  "subcategorykey" int,
  "subcategoryname" varchar(50)
);

CREATE TABLE "sales" (
  "orderkey" int NOT NULL,
  "linenumber" int NOT NULL,
  "orderdate" date,
  "deliverydate" date,
  "customerkey" int,
  "storekey" int,
  "productkey" int,
  "quantity" int,
  "unitprice" doubleprecision,
  "netprice" doubleprecision,
  "unitcost" doubleprecision,
  "currencycode" varchar(10),
  "exchangerate" doubleprecision
);

CREATE TABLE "store" (
  "storekey" int NOT NULL,
  "storecode" int,
  "geoareakey" int,
  "countrycode" varchar(10),
  "countryname" varchar(50),
  "state" varchar(50),
  "opendate" date,
  "closedate" date,
  "description" varchar(100),
  "squaremeters" doubleprecision,
  "status" varchar(20)
);

CREATE TABLE "cohort_analysis_view" (
  "customer_key" int,
  "full_name" varchar,
  "gender" varchar,
  "age" int,
  "cohort_year" int,
  "first_order" date,
  "orderdate" date,
  "total_revenue" numeric
);

CREATE TABLE "ltv_customer" (
  "customer_key" int,
  "total_LTV" numeric
);

CREATE TABLE "customer_segmentation" (
  "categories" varchar,
  "total_LTV" numeric
);

CREATE TABLE "retention_output" (
  "cohort_year" int,
  "customer_status" varchar,
  "num_customer" int,
  "retention_percentage" numeric
);

CREATE TABLE "cohort_analysis" (
  "cohort_year" int,
  "total_net_revenue" numeric,
  "total_customer" int,
  "customer_revenue" numeric
);

ALTER TABLE "cohort_analysis_view" ADD FOREIGN KEY ("customer_key") REFERENCES "customer" ("customerkey");

ALTER TABLE "cohort_analysis_view" ADD FOREIGN KEY ("orderdate") REFERENCES "sales" ("orderdate");

ALTER TABLE "ltv_customer" ADD FOREIGN KEY ("customer_key") REFERENCES "cohort_analysis_view" ("customer_key");

ALTER TABLE "ltv_customer" ADD FOREIGN KEY ("total_LTV") REFERENCES "customer_segmentation" ("total_LTV");

ALTER TABLE "retention_output" ADD FOREIGN KEY ("cohort_year") REFERENCES "cohort_analysis_view" ("cohort_year");

ALTER TABLE "cohort_analysis" ADD FOREIGN KEY ("cohort_year") REFERENCES "cohort_analysis_view" ("cohort_year");
