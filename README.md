# ETL and SCD Type 2 Implementation Using SSIS and SQL Server

## Project Overview

This project demonstrates the implementation of an end-to-end ETL pipeline and Slowly Changing Dimension (SCD Type 2) process using SQL Server Integration Services (SSIS) and SQL Server.

The project uses the AdventureWorks2022 database as the source system and implements automated historical tracking for customer dimension changes.

---

## Technologies Used

* SQL Server
* SQL Server Integration Services (SSIS)
* SQL Server Management Studio (SSMS)
* AdventureWorks2022
* Visual Studio

---

## Project Components

### ETL Packages

* Load_DimCustomer.dtsx
* Load_DimDate.dtsx
* Load_DimProduct.dtsx
* Load_DimTerritory.dtsx
* Load_FactSales.dtsx
* Master_ETL.dtsx
* Single_ETL.dtsx

### SCD Type 2 Package

* SCD_Customer_Load.dtsx

---

## Features

### ETL Pipeline

* Extraction of source data from AdventureWorks2022
* Data transformation using SSIS
* Loading dimension and fact tables
* Incremental data processing
* Centralized ETL execution using Master ETL package

### SCD Type 2 Implementation

* Historical tracking of customer changes
* Surrogate key implementation
* Automatic expiration of old records
* Insertion of new customer versions
* Current active record identification using IsCurrent flag

---

## Database Tables

### Staging Table

```sql
StgCustomer
```

### Dimension Table

```sql
DimCustomer
```

### DimCustomer Columns

* CustomerKey
* CustomerID
* BusinessEntityID
* FirstName
* LastName
* EmailAddress
* AddressLine1
* City
* StartDate
* EndDate
* IsCurrent

---

## SCD Type 2 Workflow

1. Load source data into staging table
2. Compare staging data with current dimension records
3. Detect changed records
4. Expire old records by updating:

   * IsCurrent = 0
   * EndDate = GETDATE()
5. Insert new version of changed records
6. Preserve historical data for reporting and auditing

---

## SSIS Components Used

* OLE DB Source
* Lookup Transformation
* Conditional Split
* Derived Column
* OLE DB Command
* OLE DB Destination

---

## Project Workflow

```text
AdventureWorks2022
        ↓
   Staging Tables
        ↓
 Lookup Transformation
        ↓
  Conditional Split
   ├── New Records
   ├── Changed Records
   └── Unchanged Records
        ↓
 SCD Type 2 Processing
        ↓
    DimCustomer
```

---

## Screenshots

Screenshots of the following components are included in the `screenshots` folder:

* Control Flow
* Data Flow
* Lookup Transformation
* Conditional Split
* Derived Column
* Final DimCustomer Output
* Successful Package Execution

---

## Learning Outcomes

* ETL pipeline development using SSIS
* Data warehousing concepts
* SCD Type 2 implementation
* Incremental loading techniques
* Historical data management
* SSIS transformations and workflow automation

---

## Repository Structure

```text
ETL-and-SCD-Type2-Implementation-Using-SSIS-and-SQL-Server/
│
├── SQL Scripts/
├── screenshots/
├── Load_DimCustomer.dtsx
├── Load_DimDate.dtsx
├── Load_DimProduct.dtsx
├── Load_DimTerritory.dtsx
├── Load_FactSales.dtsx
├── Master_ETL.dtsx
├── Single_ETL.dtsx
├── SCD_Customer_Load.dtsx
├── SalesETL.dtproj
├── SalesETL.sln
├── Project.params
├── README.md
└── .gitignore
```

---

## Author

Soham Pujari
