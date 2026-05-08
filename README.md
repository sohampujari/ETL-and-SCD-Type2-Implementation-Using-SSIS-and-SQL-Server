# ETL and SCD Type 2 Implementation Using SSIS and SQL Server

A complete ETL-based Data Warehouse implementation using SQL Server Integration Services (SSIS) and SQL Server with Slowly Changing Dimension (SCD) Type 2 handling for maintaining historical data.

This project demonstrates real-world Data Engineering concepts, including:
- ETL Pipeline Development
- Data Warehouse Design
- Star Schema Implementation
- Slowly Changing Dimension (SCD) Type 2
- Incremental Data Loading
- Data Transformation & Validation
- Historical Data Tracking
- Analytical Reporting Readiness

---

# Architecture Diagram

![Architecture](docs/ETLFlow.png)

---

# Project Objectives

- Build a scalable ETL pipeline using SSIS
- Implement SCD Type 2 for historical tracking
- Design a Star Schema Data Warehouse
- Perform incremental data loading
- Create analytical data models for reporting
- Maintain data consistency and integrity

---

# Tech Stack

| Technology | Purpose |
|---|---|
| SQL Server | Data Warehouse Database |
| SSIS (SQL Server Integration Services) | ETL Development |
| SQL Server Management Studio (SSMS) | Database Management |
| Visual Studio | SSIS Package Development |
| AdventureWorks | Source Database |
| Power BI / Tableau | Data Visualization |
| GitHub | Version Control & Documentation |

---

# Source System

The project uses the AdventureWorks database as the source system.

## Source Tables

- Sales.SalesOrderHeader
- Sales.SalesOrderDetail
- Person.Customer
- Production.Product
- Production.ProductCategory
- Sales.SalesTerritory
- Sales.SalesPerson

---

# Data Warehouse Architecture

The project follows a Star Schema architecture for analytical querying and reporting.

## Dimension Tables

### DimCustomer
Stores customer information with SCD Type 2 implementation.

### DimProduct
Stores product information with historical tracking.

### DimDate
Stores date-related attributes for reporting.

### DimSalesTerritory
Stores territory and regional sales information.

---

## Fact Table

### FactSales
Stores transactional sales data and references all dimension tables using surrogate keys.

---

# ETL Workflow

The ETL process follows these stages:

1. Extract data from the AdventureWorks database
2. Load extracted data into staging tables
3. Perform data cleansing and validation
4. Apply business transformations
5. Implement SCD Type 2 logic
6. Load dimension tables
7. Load fact table
8. Prepare warehouse for reporting and analytics

---

# Planned Staging Layer

A staging layer is used between source systems and the Data Warehouse.

## Staging Tables

- stg_Customer
- stg_Product
- stg_Sales
- stg_SalesOrderHeader
- stg_SalesOrderDetail

## Benefits of Staging Layer

- Improves ETL performance
- Enables data validation
- Supports error handling
- Simplifies transformation logic
- Allows retry mechanisms

---

# Slowly Changing Dimension (SCD) Type 2

This project implements SCD Type 2 to maintain historical versions of records whenever source data changes.

## Features

- Historical data preservation
- Surrogate key generation
- CurrentFlag implementation
- StartDate and EndDate tracking
- Automatic expiration of old records

---

## SCD Type 2 Process

When a source record changes:

1. Existing record is marked inactive
2. EndDate is updated
3. New record is inserted
4. A new surrogate key is generated
5. CurrentFlag is updated

---

## Example

### Before Update

| CustomerKey | CustomerName | City | CurrentFlag |
|---|---|---|---|
| 1 | John | Pune | 1 |

### After Update

| CustomerKey | CustomerName | City | CurrentFlag |
|---|---|---|---|
| 1 | John | Pune | 0 |
| 2 | John | Mumbai | 1 |

---

# Incremental Loading

The ETL pipeline supports incremental loading, processing only newly inserted or modified records.

## Benefits

- Faster execution
- Reduced database load
- Improved scalability
- Better ETL performance
- Efficient warehouse maintenance

---

# Data Transformations

The ETL pipeline performs multiple transformations, including:

- Lookup Transformations
- Derived Columns
- Data Cleansing
- Data Validation
- Surrogate Key Generation
- Null Handling
- Conditional Splits

---

#  Planned Error Handling & Logging

The project includes ETL error handling mechanisms.

## Features

- SSIS Logging
- Error Redirection
- Failed Row Capture
- Package Execution Tracking
- Audit Logging

---

# Database Design

## Star Schema

The warehouse uses a Star Schema structure consisting of:
- Central Fact Table
- Multiple Dimension Tables
- Surrogate Keys
- Optimized Analytical Queries

---

# Key Features

- SCD Type 2 Implementation
- Incremental Data Loading
- Historical Data Tracking
- SSIS Package Orchestration
- Star Schema Modeling
- Data Validation & Cleansing
- Warehouse Optimization
- Reporting-Ready Architecture

---

# Planned Performance Optimization Techniques

The project uses several optimization techniques:

- Incremental ETL Loading
- Lookup Caching
- Fast Load Options
- Batch Inserts
- Indexed Keys
- Optimized Transformations

---

# Analytics & Reporting

The warehouse is designed for analytical reporting using:
- Power BI
- Tableau
- SQL Reporting Queries

## Sample Analytics

- Monthly Sales Trends
- Top Selling Products
- Territory-wise Revenue
- Customer Purchase Analysis
- Product Category Performance

---

# Project Structure

```bash
ETL-and-SCD-Type2-Implementation-Using-SSIS-and-SQL-Server/
│
├── SSIS Packages/
├── SQL Scripts/
├── Screenshots/
├── docs/
│   └── architecture.png
├── README.md
```

---

# How to Run the Project

## Prerequisites

- SQL Server
- SQL Server Integration Services (SSIS)
- SQL Server Data Tools (SSDT)
- Visual Studio
- AdventureWorks Database

---

## Setup Steps

1. Restore the AdventureWorks database
2. Open the SSIS solution in Visual Studio
3. Configure database connection managers
4. Execute staging layer packages
5. Execute dimension load packages
6. Execute fact table load package
7. Validate loaded warehouse data

---

# Screenshots

## SSIS Packages

(Add screenshots here)

---

## Data Warehouse Tables

(Add screenshots here)

---

## SCD Type 2 Results

(Add screenshots here)

---

## Fact Table Loading

(Add screenshots here)

---

# Results

- Successfully implemented ETL pipeline using SSIS
- Created Star Schema Data Warehouse
- Implemented SCD Type 2 historical tracking
- Enabled incremental data loading
- Prepared analytical reporting structure
- Improved warehouse maintainability and scalability

---

# Future Enhancements

- Power BI Dashboard Integration
- Azure Data Factory Migration
- Cloud Data Warehouse Integration
- Change Data Capture (CDC)
- Real-Time Streaming Pipeline
- Automated Scheduling using SQL Server Agent
- Data Quality Monitoring

---

# Learning Outcomes

This project helped in understanding:
- ETL Development using SSIS
- Data Warehouse Architecture
- SCD Type 2 Concepts
- Incremental ETL Processing
- Data Modeling Techniques
- Warehouse Optimization
- Analytical Data Preparation

---

# Author

Soham Pujari

GitHub Repository:
https://github.com/sohampujari/ETL-and-SCD-Type2-Implementation-Using-SSIS-and-SQL-Server
