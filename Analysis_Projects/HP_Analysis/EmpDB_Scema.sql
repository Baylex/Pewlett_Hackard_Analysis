﻿-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "dept_no" varchar  NOT NULL ,
    "dept_name" varchar  NOT NULL ,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
    )
)

GO

CREATE TABLE "Dept_Emp" (
    "emp_no" int  NOT NULL ,
    "dept_no" varchar  NOT NULL ,
    "from_date" date  NOT NULL ,
    "to_date" date  NOT NULL ,
    CONSTRAINT "pk_Dept_Emp" PRIMARY KEY (
        "emp_no"
    )
)

GO

CREATE TABLE "Dept_Manager" (
    "dept_no" varchar  NOT NULL ,
    "emp_no" int  NOT NULL ,
    "from_date" date  NOT NULL ,
    "to_date" date  NOT NULL ,
    CONSTRAINT "pk_Dept_Manager" PRIMARY KEY (
        "dept_no","emp_no"
    )
)

GO

CREATE TABLE "Employees" (
    "emp_no" int  NOT NULL ,
    "birth_date" date  NOT NULL ,
    "first_name" varchar  NOT NULL ,
    "last_name" varchar  NOT NULL ,
    "gender" varchar  NOT NULL ,
    "hire_date" date  NOT NULL ,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
    )
)

GO

CREATE TABLE "Salaries" (
    "emp_no" int  NOT NULL ,
    "salary" int  NOT NULL ,
    "from_date" date  NOT NULL ,
    "to_date" date  NOT NULL ,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "emp_no"
    )
)

GO

CREATE TABLE "Titles" (
    "emp_no" int  NOT NULL ,
    "title" varchar  NOT NULL ,
    "from_date" date  NOT NULL ,
    "to_date" date  NOT NULL ,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "emp_no","title","from_date"
    )
)

GO

ALTER TABLE "Departments" ADD CONSTRAINT "fk_Departments_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Dept_Emp" ("dept_no")
GO

ALTER TABLE "Dept_Emp" ADD CONSTRAINT "fk_Dept_Emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no")
GO

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no")
GO

ALTER TABLE "Dept_Manager" ADD CONSTRAINT "fk_Dept_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no")
GO

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Salaries" ("emp_no")
GO

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Dept_Emp" ("emp_no")
GO

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no")
GO

