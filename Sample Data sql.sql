USE IT_Company_DB;

/* ========== DEPARTMENTS ========== */
INSERT INTO Departments VALUES
(1,'Engineering','Bangalore',GETDATE()),
(2,'HR','Kolkata',GETDATE()),
(3,'Finance','Delhi',GETDATE()),
(4,'QA','Hyderabad',GETDATE());

/* ========== EMPLOYEES ========== */
INSERT INTO Employees VALUES
(101,'Amit Sharma','amit@itco.com',1,'Manager',120000,'2019-03-10',NULL,'Active'),
(102,'Neha Roy','neha@itco.com',1,'Developer',85000,'2020-06-15',101,'Active'),
(103,'Rahul Das','rahul@itco.com',1,'Developer',65000,'2022-01-20',102,'Active'),
(104,'Sneha Paul','sneha@itco.com',4,'QA Lead',80000,'2021-09-01',NULL,'Active'),
(105,'Ravi Kumar','ravi@itco.com',4,'QA Engineer',55000,'2023-02-10',104,'Active'),
(106,'Pooja Sen','pooja@itco.com',2,'HR Executive',50000,'2021-05-12',NULL,'Active'),
(107,'Ankit Verma','ankit@itco.com',3,'Finance Analyst',70000,'2020-11-25',NULL,'Active');

/* ========== PROJECTS ========== */
INSERT INTO Projects VALUES
(201,'ERP System','TCS','2023-01-01','2023-12-31',1500000,'Active'),
(202,'Mobile App','Infosys','2023-03-01','2023-10-31',1200000,'Active'),
(203,'HR Portal','Internal','2023-05-01','2023-08-31',300000,'Completed');

/* ========== EMPLOYEE PROJECTS ========== */
INSERT INTO EmployeeProjects VALUES
(102,201,GETDATE()),
(103,201,GETDATE()),
(103,202,GETDATE()),
(104,202,GETDATE()),
(105,202,GETDATE()),
(102,203,GETDATE());

/* ========== TASKS ========== */
INSERT INTO Tasks VALUES
(1,102,201,'Backend Dev',10,'Completed','2023-07-10'),
(2,103,201,'API Work',8,'Completed','2023-07-11'),
(3,103,202,'UI Dev',9,'In Progress','2023-07-15'),
(4,104,202,'Test Plan',6,'Completed','2023-07-12');

/* ========== ATTENDANCE ========== */
INSERT INTO Attendance VALUES
(1,102,'2023-07-10',8),
(2,103,'2023-07-10',7),
(3,104,'2023-07-10',8),
(4,106,'2023-07-10',8);

/* ========== SALARY HISTORY ========== */
INSERT INTO Salaries VALUES
(1,102,85000,4000,'2023-06-30'),
(2,103,65000,3000,'2023-06-30'),
(3,104,80000,3500,'2023-06-30');