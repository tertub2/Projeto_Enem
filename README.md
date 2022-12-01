# Enem Project

![image](https://user-images.githubusercontent.com/88055274/196243128-97ec51c4-e6f8-4434-be82-853647c3ad32.png)

The National High School Exam (Enem) was instituted in 1998 by the Brazilian Ministry of Education to evaluate the performance of students at the end of basic education. In 2009, the exam improved its methodology and began to be used as a mechanism for access to higher education, which can be used for admission to universities throughout the country and even to universities abroad.
 
For more information: https://www.gov.br/inep/pt-br/areas-de-atuacao/avaliacao-e-exames-educacionais/enem.

In this project, the goal was the **Analysis of the microdata from the National High School Exam (ENEM)** of each participant, for the 2020 edition.

Soon, the data were made available, along with their dictionary, which can be seen in the *Data* folder at the link:  [https://docs.google.com/document/d/1UtS5hPXzrH77_KHT8RneRkpiqHiu1iR9KWb9QuQS3MI/edit](https://drive.google.com/drive/u/0/folders/1tL3c-TI7jnJbXgjPr3o9DllFtkxckiYA) 

Also, all the files used in the project are at the link above

# Project focus

Perform an analysis of the microdata from ENEM 2020, in order to be able to answer the following questions:


**1.Which school has the highest average score?**

**2.Which student has the highest average score and the value of this average?

**3.What is the GPA?**

**4.What is the % of absentees?**

**5.What is the % of Absentees?** 

**6.What is the ranking of the best students in Alagoas by discipline?**

**7.What is the profile of the students with below average grades? Describe by sex, ethnicity, age group.**

For this, the following conditions were requested:

**1.Use of DAX Functions**

**2.Documentation of the measurements**

**3.ETL**

**4.Dimensional modeling of the data**

# 1. Reading the data

Because it is a database of 1.8 gb approximately, it is necessary to read the data in a way that does not use so much ram memory, since the machine used has only 4 GB of ram. 

So, the importation was done in MySQL, POSTGRESQL and Microsoft SQL Server, but in all of them it was not possible to perform the importation due to the memory (the shortest estimated time, of the 3, was 12 Hours). So, Python was used, more specifically Jupyter notebook in order to do this importation.

However, when this import was made
![image](https://user-images.githubusercontent.com/88055274/196234802-78482e00-93ee-4484-99a8-87546c7fbada.png)
The memory error occurred again:
![image](https://user-images.githubusercontent.com/88055274/196234731-6cc140e7-2c7d-4075-9e51-05930c2d77f6.png)

So, in order to import this database, a sample was made, to be used in this project, the machine could read the data from 2000000 samples (lines), so this was used:
![image](https://user-images.githubusercontent.com/88055274/196232944-b9f2c7d9-54d4-4636-acb9-e5ebe0344b70.png)
![image](https://user-images.githubusercontent.com/88055274/196233359-cb5bae6a-2727-4c3c-8da0-afe8fc7779e0.png)

When analyzing the data, it was seen that not all columns would be used, so some were dropped, lowering the number of columns to 36, making it much lighter.
![image](https://user-images.githubusercontent.com/88055274/196233053-ad9a6cc3-b286-44d7-a589-a6e0580f2616.png)
![image](https://user-images.githubusercontent.com/88055274/196233198-ed8f82f4-8daf-45af-9f0d-93a2e7d884be.png)

# 2. ETL 
So, with this, we got the read and some of the drop data. Then, the next step will be to export this data to a database, which will be MySQL, to store these data in a more fluid and secure way, since according to Junior (2021) this is a software that has as a characteristic:

**1.Being very popular**

**To be flexible**

**3. be very reliable**

**4. it offers stable code**

**5. it has high performance**

So for exporting, the following libraries are used: pymysql, openpyxl and sqlalchemy. Then the create.engine of sqlalchemy.engine is selected in order to get the Jupyter and SQL connection. 
 
Then the engine is created, which has:

**mysql**: Database

**pymysql**: Database connection

**root**: Username

**bootcamp**: Password

**@127.0.0.1:3307**: IP

**project_enem**: Database name

With the connection, you can have the connection with df.to_sql
![image](https://user-images.githubusercontent.com/88055274/196235805-1e105d69-1169-4f99-add5-40a276dd2a59.png)

In SQL, the **ETL** was done, as follows: The CSV file, that was read before as dataframe in pandas, is exported as database table (*Extraction*), some queries are created to handle or create metrics (*transform*), and new tables are created based on these queries (*Load*). ETL = Extract, Transform & Load. This way, the tables are created from the base, coming from CSV

For the first query, the bank is tested in order to observe its functionality.

As for the table, it is the table that has the count of subscribers for each state:
![image](https://user-images.githubusercontent.com/88055274/196250832-08f13076-2f8a-4499-a297-4ac0206bf7b4.png)

The second table, is the social profile of the students with below average grades, for this a lookup table must be created first:
![image](https://user-images.githubusercontent.com/88055274/196251215-88d3e68e-c84d-48d4-907c-8ffb90bbdbc7.png)

The third, is the table that presents the average of the best schools, in terms of grade
![image](https://user-images.githubusercontent.com/88055274/196252347-5ab2afc0-c1da-43b7-adb9-2d409dbbdef3.png)

After these queries, the data are imported into the BI using the MySQL option
![image](https://user-images.githubusercontent.com/88055274/196253044-7c117aff-23c1-4c40-9cf8-d5d032c7e9ac.png)

# 3. database modeling

Modeling is in the modeling part of Power BI, due to the ease of it, this: 
![image](https://user-images.githubusercontent.com/88055274/196253765-55487df5-370a-4584-8660-8c9d1274fbd2.png)

The relationship with the table Enrolled by State is done through the Federative Unit:
![image](https://user-images.githubusercontent.com/88055274/196254005-25625ba5-eafd-406f-b9ea-c380673cf4b9.png)

For the Best Schools table the relationship is made through the Final Grade of each student, and this one makes a join with the table States:
![image](https://user-images.githubusercontent.com/88055274/196255083-41973a77-7225-4883-b727-f581271cb61b.png)

On the right side, there is the connection with the Below Average Profile, through the Final Grade:
![image](https://user-images.githubusercontent.com/88055274/196255277-929a16df-7e61-4563-8133-4c0591d5dd04.png)

# 4. Dashboard

First, the layout of the Dashboard, previously made in Microsoft PowerPoint, is allocated, which can be found under *Layout*.

Metrics necessary for the realization of the Dashboard are made:

![image](https://user-images.githubusercontent.com/88055274/196256080-4b71b50c-2d8f-45aa-9db6-07604e257a5d.png)

## Measurement documentation

**General**: Overall average of ENEM 2020

**Humanities**: Overall average of Humanities 

**Languages**: Language overall average 

**Mathematics**: Mathematics overall grade point average 

**Nature Science**: Overall average for Nature Science 

**Writing: Writing overall grade point average 

**Missing Counts**: Missing Counts 

**Writing**: Overall average for Writing 

**Percentage of Missing**: Overall average of Writing 

So, with the metrics and calculations from the other tables, you can fill out the layout and make the dashboard, which follows at the drive link:
https://drive.google.com/drive/u/0/folders/1tL3c-TI7jnJbXgjPr3o9DllFtkxckiYA or via the public link: https://app.powerbi.com/view?r=eyJrIjoiNDE0NzkwZTctYTk3OS00ZTMwLThlOTctYzQ5NjU5M2QxNjY1IiwidCI6Ijg1MDA4MzQ1LWRhNTMtNGJjYy1iMzc3LWU1NTFjM2FhMDllZSJ9 

# 5. Conclusions

- **Total enrollment of 2 million, with more than half of the participants absent (55.06%)**

- **The overall average score for ENEM 2020 was 523.95 and the scores for CN, CH, languages, math, and writing are 490.45, 511.27, 523.89, 520.72, and 573.41 respectively**

- **The profile for students who scored lower than the overall average varies widely**.

- **The 3 states with the highest enrollments are São Paulo, Minas Gerais and Bahia**.

- **The highest overall score was 851.0, with this student from Ceará**

- **The Colégio Estadual Landulfo Alves De Almeida is the school with the highest average in Brazil, with a score of 748.50, from Bahia**

- **The regions with the largest number of schools in the top 10 are the Southeast and the Northeast, with 4 schools each**. 

- **In Alagoas, the ranking of the best students by subject is composed of the following scores: 805.2, 824.9, 725.6, 975 and 1000 of the subjects CN, CH, languages, mathematics and writing, respectively.** 

- **The regions with the greatest number of schools in the top 10 are the Southeast and Northeast, with 4 schools each** 


## Reference

JUNIOR, C. Banco de dados MariaDB e MySQL: vantagens e desvantagens. Porto Fácil. 2021. Available at:<https://www.portofacil.net/banco-de-dados-mariadb-e-mysql.html> Acesso em: 17 de Outubro de 2022 
