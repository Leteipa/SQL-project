--load hospital visit data
select * from pendovisit

--import diagnosis data
select * from pendodia

--load invoice data
select * from pendoinvoice


--join the three tables into one table
create table visindi as
select pv.*, pi.Amount, pd.Diagnosis
from pendovisit pv
join pendoinvoice pi on pv.VisitCode=pi.VisitCode
join pendodia pd on pv.VisitCode=pd.VisitCode


--check the table
select * from visindi

---checking for return customers
SELECT VisitCode,PatientCode, MedicalCenter, Payor
FROM visindi
GROUP BY 1,2,3,4
HAVING COUNT(VisitCode) > 1;


--create table without duplicates
create table visindi_no_duplicates as
select distinct*
from visindi

select * from visindi_no_duplicates

--checking for duplicates
SELECT VisitCode,PatientCode, MedicalCenter, Payor, Amount
FROM visindi_no_duplicates
GROUP BY 1,2,3,4,5
HAVING COUNT(VisitCode) > 1;

--check for payment method with most income
select payor, sum(Amount) as Amount
from visindi_no_duplicates
group by payor
order by Amount desc

--branch that was most visited
select MedicalCenter, count(MedicalCenter) as count
from visindi_no_duplicates
group by MedicalCenter
order by count desc

--branch with most revenue
select MedicalCenter, sum(Amount)as Amount
from visindi_no_duplicates
group by 1
order by Amount desc

--medical centers with diagnosis of acute nasopharyngitis
select MedicalCenter, Diagnosis, Amount
from visindi_no_duplicates
where Diagnosis='acute nasopharyngitis'



