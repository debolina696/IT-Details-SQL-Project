USE IT_Company_DB;

/* =====================
1. EMPLOYEE ANALYTICS
===================== */

-- Employees without projects
SELECT e.emp_id, e.emp_name
FROM Employees e
LEFT JOIN EmployeeProjects ep ON e.emp_id = ep.emp_id
WHERE ep.project_id IS NULL;

-- Employees earning above company average
SELECT emp_name, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- Manager with number of reportees
SELECT m.emp_name AS manager, COUNT(e.emp_id) reportees
FROM Employees e
JOIN Employees m ON e.manager_id = m.emp_id
GROUP BY m.emp_name;


/* =====================
2. PROJECT ANALYTICS
===================== */

-- Project wise employee count
SELECT p.project_name, COUNT(ep.emp_id) emp_count
FROM Projects p
LEFT JOIN EmployeeProjects ep ON p.project_id = ep.project_id
GROUP BY p.project_name;

-- Project wise effort & cost
SELECT p.project_name,
       SUM(t.hours_spent) total_hours,
       SUM(t.hours_spent * (e.salary/160)) approx_cost
FROM Tasks t
JOIN Employees e ON t.emp_id = e.emp_id
JOIN Projects p ON t.project_id = p.project_id
GROUP BY p.project_name;


/* =====================
3. ATTENDANCE VS TASK
===================== */

-- Employees present but no task logged
SELECT emp_id FROM Attendance
EXCEPT
SELECT emp_id FROM Tasks;

-- Employees who logged task but absent
SELECT emp_id FROM Tasks
EXCEPT
SELECT emp_id FROM Attendance;


/* =====================
4. UNION / INTERSECT
===================== */

-- Employees involved in work (attendance OR task)
SELECT emp_id FROM Attendance
UNION
SELECT emp_id FROM Tasks;

-- Employees both present AND worked
SELECT emp_id FROM Attendance
INTERSECT
SELECT emp_id FROM Tasks;


/* =====================
5. CASE (BUSINESS RULES)
===================== */

-- Salary classification
SELECT emp_name, salary,
CASE
    WHEN salary >= 100000 THEN 'High Paid'
USE IT_Company_DB;

-------------------------------------------------
-- PHASE 1: DATA SETUP & DAILY OPERATIONS
-------------------------------------------------

-- 2. Add new department
INSERT INTO Departments VALUES (5,'Data Science','Bangalore',GETDATE());

-- 3. Modify salary precision
ALTER TABLE Employees
ALTER COLUMN salary DECIMAL(14,2);

-- 4. Remove obsolete column (example)
-- ALTER TABLE Employees DROP COLUMN obsolete_column;

-- 5. Correct incorrect salary
UPDATE Employees
SET salary = 70000
WHERE emp_id = 103;


-------------------------------------------------
-- PHASE 2: EMPLOYEE ANALYTICS
-------------------------------------------------

-- 6. Active employees with department & role
SELECT e.emp_name, d.dept_name, e.role
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
WHERE e.status = 'Active';

-- 7. Employees joined in last 1 year
SELECT emp_name, join_date
FROM Employees
WHERE join_date >= DATEADD(YEAR,-1,GETDATE());

-- 8. Salary above company average
SELECT emp_name, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- 9. Salary bands
SELECT emp_name, salary,
CASE
  WHEN salary >= 100000 THEN 'High'
  WHEN salary BETWEEN 60000 AND 99999 THEN 'Medium'
  ELSE 'Low'
END AS salary_band
FROM Employees;

-- 10. Employees without manager
SELECT emp_name
FROM Employees
WHERE manager_id IS NULL;


-------------------------------------------------
-- PHASE 3: DEPARTMENT INSIGHTS
-------------------------------------------------

-- 11. Employee count per department
SELECT d.dept_name, COUNT(e.emp_id) emp_count
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 12. High payroll departments
SELECT d.dept_name, SUM(e.salary) total_cost
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING SUM(e.salary) > (SELECT AVG(salary)*COUNT(*) FROM Employees);

-- 13. Dept avg salary > company avg
SELECT dept_id
FROM Employees
GROUP BY dept_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM Employees);

-- 14. Departments by cost
SELECT dept_id, SUM(salary) total_cost
FROM Employees
GROUP BY dept_id
ORDER BY total_cost DESC;

-- 15. Departments with no employees
SELECT d.dept_name
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;


-------------------------------------------------
-- PHASE 4: PROJECT & CLIENT ANALYSIS
-------------------------------------------------

-- 16. Ongoing projects
SELECT project_name, client_name, start_date, end_date
FROM Projects
WHERE project_status = 'Active';

-- 17. Delayed projects
SELECT project_name
FROM Projects
WHERE end_date < GETDATE()
AND project_status <> 'Completed';

-- 18–19. Project hours & cost
SELECT p.project_name,
       SUM(t.hours_spent) total_hours,
       SUM(t.hours_spent * (e.salary/160)) project_cost
FROM Tasks t
JOIN Employees e ON t.emp_id = e.emp_id
JOIN Projects p ON t.project_id = p.project_id
GROUP BY p.project_name;

-- 20. Client with highest workload
SELECT client_name, SUM(t.hours_spent) total_hours
FROM Projects p
JOIN Tasks t ON p.project_id = t.project_id
GROUP BY client_name
ORDER BY total_hours DESC;


-------------------------------------------------
-- PHASE 5: TASK & PRODUCTIVITY
-------------------------------------------------

-- 21. Tasks per employee
SELECT emp_id, COUNT(task_id) task_count
FROM Tasks
GROUP BY emp_id;

-- 22. Employees on multiple projects
SELECT emp_id
FROM EmployeeProjects
GROUP BY emp_id
HAVING COUNT(project_id) > 1;

-- 23. Employees with no tasks
SELECT e.emp_name
FROM Employees e
LEFT JOIN Tasks t ON e.emp_id = t.emp_id
WHERE t.task_id IS NULL;

-- 24. Avg hours per task
SELECT AVG(hours_spent) avg_task_hours
FROM Tasks;

-- 25. Pending tasks
SELECT task_name
FROM Tasks
WHERE task_status <> 'Completed';


-------------------------------------------------
-- PHASE 6: ATTENDANCE & WORK HOURS
-------------------------------------------------

-- 26. Total hours per employee
SELECT emp_id, SUM(hours_worked) total_hours
FROM Attendance
GROUP BY emp_id;

-- 27. Low working hours
SELECT emp_id
FROM Attendance
GROUP BY emp_id
HAVING SUM(hours_worked) < 40;

-- 28. Monthly attendance
SELECT emp_id,
       MONTH(work_date) month,
       SUM(hours_worked) total_hours
FROM Attendance
GROUP BY emp_id, MONTH(work_date);

-- 29. Missing attendance days
SELECT DISTINCT emp_id
FROM Employees
WHERE emp_id NOT IN (SELECT emp_id FROM Attendance);

-- 30. Attendance vs task mismatch
SELECT emp_id FROM Attendance
EXCEPT
SELECT emp_id FROM Tasks;


-------------------------------------------------
-- PHASE 7: MULTI-TABLE REPORTS
-------------------------------------------------

-- 31. Employee–dept–project–hours
SELECT e.emp_name, d.dept_name, p.project_name,
       SUM(t.hours_spent) total_hours
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
JOIN Tasks t ON e.emp_id = t.emp_id
JOIN Projects p ON t.project_id = p.project_id
GROUP BY e.emp_name, d.dept_name, p.project_name;

-- 32. Dept with most billable hours
SELECT d.dept_name, SUM(t.hours_spent) hours
FROM Departments d
JOIN Employees e ON d.dept_id = e.dept_id
JOIN Tasks t ON e.emp_id = t.emp_id
GROUP BY d.dept_name
ORDER BY hours DESC;


-------------------------------------------------
-- PHASE 8: SET OPERATIONS
-------------------------------------------------

-- 36. Project A or B
SELECT emp_id FROM EmployeeProjects WHERE project_id = 201
UNION
SELECT emp_id FROM EmployeeProjects WHERE project_id = 202;

-- 37. Internal & client projects
SELECT emp_id FROM EmployeeProjects ep
JOIN Projects p ON ep.project_id = p.project_id
WHERE client_name = 'Internal'
INTERSECT
SELECT emp_id FROM EmployeeProjects ep
JOIN Projects p ON ep.project_id = p.project_id
WHERE client_name <> 'Internal';

-- 38. Task but no attendance
SELECT emp_id FROM Tasks
EXCEPT
SELECT emp_id FROM Attendance;


-------------------------------------------------
-- PHASE 9: VIEWS
-------------------------------------------------

-- 41. Employee workload view
CREATE VIEW vw_employee_workload AS
SELECT e.emp_name, d.dept_name,
       SUM(t.hours_spent) total_hours
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
LEFT JOIN Tasks t ON e.emp_id = t.emp_id
GROUP BY e.emp_name, d.dept_name;
USE IT_Company_DB;

/* =====================================================
PHASE 10: BUSINESS RULES & AUTOMATION
===================================================== */

-- 46. Log salary changes (AUDIT TRIGGER)
CREATE TRIGGER trg_salary_audit
ON Employees
AFTER UPDATE
AS
BEGIN
    IF UPDATE(salary)
    INSERT INTO Salary_Audit (emp_id, old_salary, new_salary)
    SELECT d.emp_id, d.salary, i.salary
    FROM deleted d
    JOIN inserted i ON d.emp_id = i.emp_id;
END;


-- 47. Prevent invalid salary / work hours
ALTER TABLE Employees
ADD CONSTRAINT chk_salary_positive CHECK (salary > 0);

ALTER TABLE Attendance
ADD CONSTRAINT chk_hours_valid CHECK (hours_worked BETWEEN 0 AND 24);


-- 48. Track deleted employees (COMPLIANCE)
CREATE TRIGGER trg_employee_delete
ON Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO Employee_Delete_Log (emp_id, emp_name)
    SELECT emp_id, emp_name FROM deleted;
END;


/* =====================================================
PHASE 11: REUSABLE LOGIC (UDF & PROCEDURES)
===================================================== */

-- 51. Annual compensation calculation
CREATE FUNCTION fn_annual_compensation (@monthly_salary DECIMAL(12,2))
RETURNS DECIMAL(14,2)
AS
BEGIN
    RETURN @monthly_salary * 12;
END;


-- 52. Department-wise employee list
CREATE PROCEDURE sp_get_employees_by_dept
@dept_id INT
AS
BEGIN
    SELECT emp_id, emp_name, role, salary
    FROM Employees
    WHERE dept_id = @dept_id;
END;


-- 53. Employee onboarding process
CREATE PROCEDURE sp_add_employee
@emp_id INT, @name VARCHAR(100), @email VARCHAR(100),
@dept INT, @role VARCHAR(50), @salary DECIMAL(12,2),
@manager INT = NULL
AS
BEGIN
    INSERT INTO Employees
    VALUES (@emp_id, @name, @email, @dept, @role,
            @salary, GETDATE(), @manager, 'Active');
END;


-- 54. Safe salary update with validation
CREATE PROCEDURE sp_update_salary
@emp_id INT, @new_salary DECIMAL(12,2)
AS
BEGIN
    IF @new_salary <= 0
        THROW 50001, 'Invalid salary value', 1;

    UPDATE Employees
    SET salary = @new_salary
    WHERE emp_id = @emp_id;
END;


/* =====================================================
PHASE 12: TRANSACTIONS & SAFE DATA CHANGES
===================================================== */

-- 56–59. Company-wide salary revision (SAFE)
BEGIN TRY
    BEGIN TRAN;

    UPDATE Employees
    SET salary = salary * 1.08
    WHERE role LIKE '%Developer%';

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
END CATCH;


/* =====================================================
PHASE 13: ADVANCED DECISION QUERIES
===================================================== */

-- 61. Rank employees by contribution (salary proxy)
SELECT emp_name, dept_id, salary,
RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) dept_rank
FROM Employees;


-- 62. Top performer per department
SELECT *
FROM (
    SELECT emp_name, dept_id, salary,
           ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) rn
    FROM Employees
) t
WHERE rn = 1;


-- 63. Salary growth comparison
SELECT e.emp_id, e.emp_name,
       s.base_salary AS old_salary,
       e.salary AS current_salary,
       (e.salary - s.base_salary) growth
FROM Employees e
JOIN Salaries s ON e.emp_id = s.emp_id;


-- 64. Department cost trend
SELECT dept_id, SUM(salary) total_dept_cost
FROM Employees
GROUP BY dept_id;


-- 65. Promotion eligibility (business rule)
SELECT emp_name, salary
FROM Employees
WHERE salary BETWEEN 60000 AND 80000;