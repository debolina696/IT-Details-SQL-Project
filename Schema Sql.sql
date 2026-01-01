/* ================================
   DATABASE
================================ */
CREATE DATABASE IT_Company_DB;
GO
USE IT_Company_DB;
GO

/* ================================
   DEPARTMENTS
================================ */
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL UNIQUE,
    location VARCHAR(50),
    created_date DATE DEFAULT GETDATE()
);

/* ================================
   EMPLOYEES
================================ */
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    dept_id INT,
    role VARCHAR(50),
    salary DECIMAL(12,2) CHECK (salary > 0),
    join_date DATE,
    manager_id INT NULL,
    status VARCHAR(20) DEFAULT 'Active',

    CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id)
        REFERENCES Departments(dept_id),

    CONSTRAINT fk_emp_manager FOREIGN KEY (manager_id)
        REFERENCES Employees(emp_id)
);

/* ================================
   PROJECTS
================================ */
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    client_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(14,2) CHECK (budget >= 0),
    project_status VARCHAR(30)
);

/* ================================
   EMPLOYEE – PROJECT (MANY TO MANY)
================================ */
CREATE TABLE EmployeeProjects (
    emp_id INT,
    project_id INT,
    assigned_date DATE DEFAULT GETDATE(),

    CONSTRAINT pk_emp_proj PRIMARY KEY (emp_id, project_id),

    CONSTRAINT fk_ep_emp FOREIGN KEY (emp_id)
        REFERENCES Employees(emp_id),

    CONSTRAINT fk_ep_project FOREIGN KEY (project_id)
        REFERENCES Projects(project_id)
);

/* ================================
   TASKS
================================ */
CREATE TABLE Tasks (
    task_id INT PRIMARY KEY,
    emp_id INT,
    project_id INT,
    task_name VARCHAR(100),
    hours_spent DECIMAL(6,2) CHECK (hours_spent >= 0),
    task_status VARCHAR(30),
    task_date DATE,

    CONSTRAINT fk_task_emp FOREIGN KEY (emp_id)
        REFERENCES Employees(emp_id),

    CONSTRAINT fk_task_project FOREIGN KEY (project_id)
        REFERENCES Projects(project_id)
);

/* ================================
   ATTENDANCE
================================ */
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    emp_id INT,
    work_date DATE,
    hours_worked DECIMAL(5,2) CHECK (hours_worked >= 0),

    CONSTRAINT fk_att_emp FOREIGN KEY (emp_id)
        REFERENCES Employees(emp_id)
);

/* ================================
   SALARY HISTORY (DO NOT OVERWRITE)
================================ */
CREATE TABLE Salaries (
    salary_id INT PRIMARY KEY,
    emp_id INT,
    base_salary DECIMAL(12,2),
    bonus DECIMAL(10,2) DEFAULT 0,
    pay_date DATE,

    CONSTRAINT fk_sal_emp FOREIGN KEY (emp_id)
        REFERENCES Employees(emp_id)
);

/* ================================
   SALARY AUDIT (FOR TRIGGERS)
================================ */
CREATE TABLE Salary_Audit (
    audit_id INT IDENTITY PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(12,2),
    new_salary DECIMAL(12,2),
    change_date DATETIME DEFAULT GETDATE()
);

/* ================================
   EMPLOYEE DELETE LOG (SOFT DELETE)
================================ */
CREATE TABLE Employee_Delete_Log (
    log_id INT IDENTITY PRIMARY KEY,
    emp_id INT,
    emp_name VARCHAR(100),
    deleted_date DATETIME DEFAULT GETDATE()
);