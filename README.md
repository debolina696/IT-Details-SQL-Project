# 🏢 IT Company SQL Practical Project  
**End-to-End Real-Life SQL (Basic → Advanced)**

---

## 📌 Project Overview
This project simulates **real-world IT company operations** where SQL is used daily by  
**Data Analysts, SQL Developers, and Backend Engineers**.

The focus is **business problem solving**, not isolated SQL functions.

> One project that can be used for:
- Interview preparation  
- SQL revision (basic to advanced)  
- GitHub portfolio demonstration  

---

## 🎯 Business Objective
To design and query an **IT Company Database** that supports:
- Employee & HR analytics  
- Project & task tracking  
- Attendance & productivity comparison  
- Cost & payroll analysis  
- Automation, audit, and data integrity  
- Safe data updates using transactions  

---

## 🧠 Business Scenario
You are working as a **Data Analyst / SQL Developer** in an IT company.  
Different teams ask business questions daily:

- **HR** → employee data, salaries, hierarchy  
- **Finance** → payroll, cost analysis, audits  
- **Project Managers** → workload, productivity  
- **Management** → dashboards & decision insights  

All queries in this project reflect such **real requests**.

---

## 🗂️ Database Design
**Database Name:** `IT_Company_DB`

### Core Tables
- `Departments`
- `Employees` (self-join for manager hierarchy)
- `Projects`
- `EmployeeProjects` (many-to-many)
- `Tasks`
- `Attendance`
- `Salaries` (salary history)
- `Salary_Audit` (audit trail)
- `Employee_Delete_Log` (compliance)

Designed to support:
- Multi-table joins  
- Set operations  
- Analytics & automation  

---

## 📁 Project Structure
-01 schema sql 
- 02 sample data sql
- 03 IT analytical queries basic to advanced
- Readme.md
- ---

## 🔍 SQL Coverage (Naturally Applied)
This project **naturally covers**:

- `SELECT`, `WHERE`, `ORDER BY`
- `JOIN` (INNER, LEFT, SELF)
- `GROUP BY`, `HAVING`
- Aggregate functions
- Subqueries (scalar & correlated)
- `CASE` expressions
- Set operations (`UNION`, `INTERSECT`, `EXCEPT`)
- Views
- Window functions (`RANK`, `ROW_NUMBER`)
- Stored Procedures
- User Defined Functions (UDF)
- Triggers (audit & compliance)
- Constraints & validation
- Transactions (`BEGIN / COMMIT / ROLLBACK`)

👉 **No artificial “practice questions”**  
👉 Everything is business-driven

---

## 🧩 Phase-Wise Implementation

### 🟢 Phase 1: Data Setup & Daily Operations
- Schema creation
- Altering tables
- Data corrections
- Safe updates

### 🟢 Phase 2–3: Employee & Department Analytics
- Active employees
- Salary analysis
- Manager hierarchy
- Department cost insights

### 🟢 Phase 4–5: Project, Task & Productivity
- Project workload
- Task distribution
- Multi-project employees
- Cost estimation

### 🟢 Phase 6: Attendance Analysis
- Attendance vs task comparison
- Missing or low work hours
- Payroll-ready summaries

### 🟢 Phase 7–8: Combined Reports & Set Operations
- Multi-table business reports
- UNION / INTERSECT / EXCEPT
- Real operational scenarios

### 🟢 Phase 9: Views
- Reusable reporting views
- Simplified analysis

### 🟢 Phase 10–11: Automation & Reusable Logic
- Triggers for audit & delete logging
- UDFs for compensation logic
- Stored procedures for HR operations

### 🟢 Phase 12–13: Transactions & Advanced Analytics
- Safe salary revisions
- Rollback on failure
- Ranking & performance analysis
- Decision-support queries

---

## 📘 Questions Reference
All business problems are documented in:

📄 **`Questions.md`**

This file acts as:
- A **revision guide**
- A **business requirement document**
- A mapping reference for SQL files

---

## 🚀 How to Use This Project
1. Execute `01_schema.sql`
2. Run `02_sample_data.sql`
3. Explore queries in `03_business_queries.sql`
4. Execute automation & advanced logic from `04_advanced.sql`
5. Refer to `Questions.md` for business context

---

## 🎓 Who This Project Is For
- SQL / Data Analyst aspirants  
- Backend / Database developers  
- Anyone preparing for **real SQL interviews**  
- Professionals wanting a **single SQL revision project**

---

## 🏁 Final Note
> If you understand and can explain this project,  
> you can confidently handle **real SQL work in IT companies**.

⭐ **Star this repo if it helps your learning**  
📌 Built with a focus on **clarity, realism, and long-term value**

