Table "currencyexchange" {
  "date"              date   [primary key]
  "fromcurrency"      varchar(10) [not null]
  "tocurrency"        varchar(10) [not null]
  "exchange"          doubleprecision
}

Table "customer" {
  "customerkey"       int    [primary key]
  "geoareakey"        int
  "startdt"           date
  "enddt"             date
  "continent"         varchar(50)
  "gender"            varchar(10)
  "title"             varchar(20)
  "givenname"         varchar(50)
  "middleinitial"     varchar(5)
  "surname"           varchar(50)
  "streetaddress"     varchar(100)
  "city"              varchar(50)
  "state"             varchar(50)
  "statefull"         varchar(100)
  "zipcode"           varchar(20)
  "country"           varchar(50)
  "countryfull"       varchar(100)
  "birthday"          date
  "age"               int
  "occupation"        varchar(100)
  "company"           varchar(100)
  "vehicle"           varchar(100)
  "latitude"          doubleprecision
  "longitude"         doubleprecision
}

Table "date" {
  "date"              date   [primary key]   // ← this is the column name
  "datekey"           int
  "year"              int
  "yearquarter"       varchar(20)
  "yearquarternumber" int
  "quarter"           varchar(10)
  "yearmonth"         varchar(20)
  "yearmonthshort"    varchar(20)
  "yearmonthnumber"   int
  "month"             varchar(20)
  "monthshort"        varchar(10)
  "monthnumber"       int
  "dayofweek"         varchar(20)
  "dayofweekshort"    varchar(10)
  "dayofweeknumber"   int
  "workingday"        int
  "workingdaynumber"  int
}

Table "product" {
  "productkey"        int    [primary key]
  "productcode"       int
  "productname"       varchar(100)
  "manufacturer"      varchar(100)
  "brand"             varchar(50)
  "color"             varchar(30)
  "weightunit"        varchar(10)
  "weight"            doubleprecision
  "cost"              doubleprecision
  "price"             doubleprecision
  "categorykey"       int
  "categoryname"      varchar(50)
  "subcategorykey"    int
  "subcategoryname"   varchar(50)
}

Table "sales" {
  "orderkey"          int    [primary key]
  "linenumber"        int    [primary key]
  "orderdate"         date
  "deliverydate"      date
  "customerkey"       int
  "storekey"          int
  "productkey"        int
  "quantity"          int
  "unitprice"         doubleprecision
  "netprice"          doubleprecision
  "unitcost"          doubleprecision
  "currencycode"      varchar(10)
  "exchangerate"      doubleprecision
}

Table "store" {
  "storekey"          int    [primary key]
  "storecode"         int
  "geoareakey"        int
  "countrycode"       varchar(10)
  "countryname"       varchar(50)
  "state"             varchar(50)
  "opendate"          date
  "closedate"         date
  "description"       varchar(100)
  "squaremeters"      doubleprecision
  "status"            varchar(20)
}

Table cohort_analysis_view {
  customer_key        int 
  full_name           varchar
  gender              varchar
  age                 int
  cohort_year         int
  first_order         date
  orderdate           date
  total_revenue       numeric
}

Table ltv_customer {
  customer_key        int
  total_LTV           numeric
}

Table customer_segmentation {

  categories          varchar
  total_LTV           numeric
}

Table retention_output {
  cohort_year         int 
  customer_status     varchar
  num_customer        int
  retention_percentage numeric
}

Table cohort_analysis {          
  cohort_year        int
  total_net_revenue  numeric
  total_customer     int
  customer_revenue   numeric
}

Table customer_npv {
  customer_tier      varchar 
  num_customer       int  
  total_npv          numeric
  avg_npv            numeric
}


/* ─── Relationships ─── */
Ref: cohort_analysis_view.customer_key>customer_npv.num_customer
Ref: store. storekey> sales.storekey
Ref: product.productkey>sales.productkey
Ref: date.date>sales.orderdate
Ref: currencyexchange.date>sales.orderdate
Ref: customer.customerkey>sales.customerkey
Ref: cohort_analysis_view.customer_key > customer.customerkey
Ref: cohort_analysis_view.orderdate    > "sales"."orderdate"          // ← fixed: points to the existing column
Ref: ltv_customer.customer_key    > cohort_analysis_view.customer_key
Ref: customer_segmentation.total_LTV    < ltv_customer.total_LTV
Ref: retention_output.cohort_year > cohort_analysis_view.cohort_year
Ref: cohort_analysis.cohort_year > cohort_analysis_view.cohort_year



