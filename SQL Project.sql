CREATE DATABASE EMPLOYEE_DB


CREATE TABLE Department(
Num_S INT,
Label VARCHAR(255),
Manager_Name VARCHAR(255),
CONSTRAINT NumS_PK PRIMARY KEY (Num_S)
);

CREATE TABLE Employee (
Num_E INT,
Name VARCHAR(255) NOT NULL,
Position VARCHAR(255),
Salary DECIMAL(10, 2),
Num_S INT,
CONSTRAINT NumE_PK PRIMARY KEY (Num_E),
CONSTRAINT Employee_NumS_FK FOREIGN KEY (Num_S) REFERENCES Department (Num_S) ON DELETE CASCADE
);

CREATE TABLE Project (
Num_P INT,
Title VARCHAR(255),
Start_Date DATE,
End_Date DATE,
Num_S INT,
CONSTRAINT NumP_PK PRIMARY KEY (Num_P),
CONSTRAINT Project_NumS_FK FOREIGN KEY (Num_S) REFERENCES Department (Num_S) ON DELETE CASCADE
);

CREATE TABLE Employee_Project(
Num_E INT,
Num_P INT,
Role VARCHAR(255) NOT NULL,
CONSTRAINT EP_NumE_FK FOREIGN KEY (Num_E) REFERENCES Employee (Num_E) ON DELETE CASCADE,
CONSTRAINT EP_NumP_FK FOREIGN KEY (Num_P) REFERENCES Project (Num_P) 
);


--Department
INSERT INTO Department VALUES 
(1, 'IT', 'Alice Johnson'),
(2, 'HR', 'Bob Smith'),
(3, 'Marketing', 'Clara Bennett');

--Employee
INSERT INTO Employee VALUES 
(101, 'John Doe', 'Developer', 60000.00, 1),
(102, 'Jane Smith', 'Analyst', 55000.00, 2),
(103, 'Mike Brown', 'Designer', 50000.00, 3),
(104, 'Sarah Johnson', 'Data Scientist', 70000.00, 1),
(105, 'Emma Wilson', 'HR Specialist', 52000.00, 2);

--Project
INSERT INTO Project VALUES 
(201, 'Website Redesign', '2024-01-15', '2024-06-30', 1),
(202, 'Employee Onboarding', '2024-03-01', '2024-09-01', 2),
(203, 'Market Research', '2024-02-01', '2024-07-31', 3),
(204, 'IT Infrastructure Setup', '2024-04-01', '2024-12-31', 1);

--Employee_Project (Roles)
INSERT INTO Employee_Project VALUES 
(101, 201, 'Frontend Developer'),
(104, 201, 'Backend Developer'),
(102, 202, 'Trainer'),
(105, 202, 'Coordinator'),
(103, 203, 'Research Lead'),
(101, 204, 'Network Specialist');

--Update the Role of Employee_Num_E = 101 in the Employee_Project table to "Full Stack Developer".
UPDATE Employee_Project 
SET Role = 'Full Stack Developer' 
WHERE Num_E = 101;

--Delete the employee with Num_E = 103 from the Employee table and remove their corresponding entries in the Employee_Project table
DELETE FROM Employee WHERE Num_E = 103


--Write a query to retrieve the names of employees who are assigned to more than one project, including the total number of projects for each employee.
SELECT Name, Employee.Num_E, COUNT(Num_P) AS No_of_Projects 
FROM Employee
JOIN Employee_Project
ON Employee.Num_E = Employee_Project.Num_E
GROUP BY Name, Employee.Num_E
HAVING COUNT(Num_P) > 1
ORDER BY Name;

--Write a query to retrieve the list of projects managed by each department, including the department label and manager’s name.
SELECT Title, Label, Manager_name
FROM Project
JOIN Department
ON Department.Num_S = Project.Num_S
ORDER BY Manager_name;


--Write a query to retrieve the names of employees working on the project "Website Redesign," including their roles in the project.
SELECT Name, Employee.Num_E, Title, Role
FROM Employee
JOIN Employee_Project
ON Employee.Num_E = Employee_Project.Num_E
JOIN Project
ON Employee_Project.Num_P = Project.Num_P
WHERE Title = 'Website Redesign'

--Write a query to retrieve the department with the highest number of employees, including the department label, manager name, and the total number of employees.
SELECT COUNT(Num_E) AS No_of_Employees, Label, Manager_name
From Department
JOIN Employee
ON Department.Num_S = Employee.Num_S
GROUP BY Label, Manager_name
ORDER BY No_of_Employees DESC;

--Write a query to retrieve the names and positions of employees earning a salary greater than 60,000, including their department names.
SELECT Name, Employee.Num_E, Label, Position, Salary
FROM Employee
JOIN Department
ON Employee.Num_S = Department.Num_S
WHERE Salary > 60000;

--Write a query to retrieve the number of employees assigned to each project, including the project title.
SELECT Title, COUNT(Num_E) AS Employee_count
FROM Project 
LEFT JOIN Employee_Project
ON Project.Num_P = Employee_Project.Num_P
GROUP BY Title;

--Write a query to retrieve a summary of roles employees have across different projects, including the employee name, project title, and role.
SELECT Employee.Num_E, name, title, role 
FROM Employee
JOIN Employee_Project
ON Employee.Num_E = Employee_Project.Num_E
JOIN Project
ON Employee_Project.Num_P = Project.Num_P
ORDER BY Employee.Num_E;


--Write a query to retrieve the total salary expenditure for each department, including the department label and manager name.
SELECT Department.Num_S, Label, Manager_Name, SUM(Salary) AS Total_salary_expenditure
FROM Employee
JOIN Department
ON Employee.Num_S = Department.Num_S
GROUP BY Department.Num_S, Label, Manager_Name
ORDER BY Department.Num_S;


