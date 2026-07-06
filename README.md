# 🏥 Hospital Management Database

## Project Description

This project consists of the design and implementation of a relational database for a **Hospital Management System** using PostgreSQL. The database manages patients, doctors, cities, medications, appointments, and prescriptions while ensuring data integrity through primary and foreign key relationships.

The project demonstrates relational database design by implementing table creation, data insertion, SQL queries, aggregate functions, and views to efficiently manage hospital information.

---

## Technologies Used

- PostgreSQL 17
- SQL
- pgAdmin 4
- Git
- GitHub

---

## Database Engine

**PostgreSQL 17**

---

## Database Structure

The project contains the following tables:

- `cities`
- `patients`
- `doctors`
- `medications`
- `appointments`
- `prescriptions`

---

## Database Design

The database follows relational database principles to ensure consistency and eliminate data redundancy.

The relationships between entities are implemented using:

- Primary Keys (PK)
- Foreign Keys (FK)
- One-to-Many (1:N) relationships
- Referential Integrity

---

## Relational Model

### Cities

- `city_id` (PK)
- `city_name`
- `department`

### Patients

- `patient_id` (PK)
- `name`
- `document`
- `phone`
- `city_id` (FK)

### Doctors

- `doctor_id` (PK)
- `name`
- `specialty`
- `office`

### Medications

- `medication_id` (PK)
- `name`

### Appointments

- `appointment_id` (PK)
- `appointment_date`
- `appointment_time`
- `diagnosis`
- `patient_id` (FK)
- `doctor_id` (FK)

### Prescriptions

- `prescription_id` (PK)
- `appointment_id` (FK)
- `medication_id` (FK)
- `quantity`

---

## Entity Relationship Model (ERM)

```text
Cities
   │
   │ 1:N
   ▼
Patients
   │
   │ 1:N
   ▼
Appointments
   ├──────────────┐
   ▼              ▼
Doctors      Prescriptions
                  │
                  │ N:1
                  ▼
             Medications
```

---

## Installation Instructions

1. Install PostgreSQL 17.
2. Install pgAdmin 4.
3. Create a new database.
4. Execute the SQL script to create the tables.
5. Insert the sample data.
6. Run the SQL queries and views.

---

## Database Features

The project includes:

- Database creation using SQL DDL
- Auto-increment primary keys (`SERIAL`)
- Foreign key constraints
- Referential integrity
- SQL JOIN operations
- Aggregate functions
- Filtering and sorting
- SQL Views

---

## SQL Queries

The project includes SQL queries that allow you to:

- Display patients and their assigned doctors.
- Display patients living in Barranquilla.
- Show appointments scheduled in July.
- Filter appointments by diagnosis.
- Display medications delivered in quantities greater than 15.
- List patients alphabetically.
- Show appointments ordered by date.
- Count patients, doctors, appointments, and medications.
- Display patient, doctor, appointment date, and diagnosis.
- Display patient and city information.
- Display prescribed medications and quantities.
- Display doctors with their specialties and patients.
- Show the complete medical history of each patient.
- Count appointments per doctor.
- Count patients by city.
- Count consultations by diagnosis.
- Find the most prescribed medication.
- Count appointments per patient.
- Display doctors with more than two consultations.
- Display patients with multiple appointments.
- Display repeated diagnoses.

---

## SQL Views

The project includes the following views:

- `vw_patients`
- `vw_appointments`
- `vw_patient_history`
- `vw_appointments_per_doctor`
- `vw_appointments_per_city`

These views simplify reporting and improve data retrieval.

---

## Concepts Applied

- Relational Database Design
- SQL DDL
- SQL DML
- Primary Keys
- Foreign Keys
- INNER JOIN
- GROUP BY
- HAVING
- ORDER BY
- Aggregate Functions (`COUNT`, `SUM`)
- SQL Views

---

## Repository Structure

```text
Hospital-Management-Database/
│
├── 01_create_tables.sql
├── 02_insert_data.sql
├── 03_queries.sql
├── 04_views.sql
└── README.md
```

---

## Developer

**Name:** Kerlys Bello 

**Program:** Riwi 

**Project:** Hospital Management Database

---

## License

This project was developed for educational purposes to practice relational database design and SQL programming using PostgreSQL.
