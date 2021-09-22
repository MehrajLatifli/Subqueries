use Academy




-- Print numbers of buildings if the total financing fund of the departments located in them exceeds 100,000.


SELECT distinct
COUNT(Academy.dbo.Departments.Building) as [Count of Building]
FROM Academy.dbo.Departments
group by  Academy.dbo.Departments.Building
having 
(
select 
SUM(Academy.dbo.Departments.Financing)
FROM Academy.dbo.Departments
)>100000




-- Print names of the 5th year groups of the Software Development  department  that  have  more  than  10  double  periods  in  the first week.


select 
COUNT(*) as [Count of Lectures for Group],
D.[Department name], 
G.[Group name],
L.[Date of the lecture]
from 
Academy.dbo.Departments as D,
Academy.dbo.Groups as G,
Academy.dbo.[Groups and Lectures] as GL,
Academy.dbo.Lectures as L
where 
G.Id=GL.GroupId_forGL
AND
L.Id= GL.LectureId_forGL
AND
D.Id= G.DepartmentId
AND
G.[Year]=5
AND
D.[Department name]='Software Development'
AND 
Day(GETDATE()) - Day(L.[Date of the lecture])<20
group by 
D.[Department name],
G.[Group name],
L.[Date of the lecture]
having COUNT(*)>10


select 
* from
(Select  
COUNT(*) as [Count of Lectures for Group],
D.[Department name], 
G.[Group name],
L.[Date of the lecture]
from 
Academy.dbo.Departments as D,
Academy.dbo.Groups as G,
Academy.dbo.[Groups and Lectures] as GL,
Academy.dbo.Lectures as L
where 
G.Id=GL.GroupId_forGL
AND
L.Id= GL.LectureId_forGL
AND
D.Id= G.DepartmentId
AND
G.[Year]=5
AND
D.[Department name]='Software Development'
AND 
Day(GETDATE()) - Day(L.[Date of the lecture])<20
group by 
D.[Department name],
G.[Group name],
L.[Date of the lecture]
having COUNT(*)>10
) as [Table]




-- Print names of the groups whose rating (average rating of all students in the group) is greater than the rating of the "D221" group.


select
G.[Group name]
from 
Academy.dbo.[Groups and Students] as GS,
Academy.dbo.Students as S,
Academy.dbo.Groups as G
where 
G.Id=GS.GroupId_forGS
AND
S.Id=GS.StudentId_forGS
group by 
G.[Group name]
having
AVG(S.[Student's rating]) >
(
SELECT AVG(S.[Student's rating])
from 
Academy.dbo.Students as S,
Academy.dbo.Groups as G,
Academy.dbo.[Groups and Students] as GS
where 
GS.GroupId_forGS=G.Id
AND
G.[Group name]='D221'
) 




-- Print  full  names  of  teachers  whose  wage  rate  is  higher  than  the average wage rate of professors.


select Distinct
T.[Teacher's name]+' '+T.[Teacher's surname] as [Teacher's full name]
from 
Academy.dbo.Lectures as L,
Academy.dbo.Teachers as T
where 
L.TeacherId=T.Id
AND
T.[Teacher's salary]>
(
SELECT AVG(T.[Teacher's salary])
from 
Academy.dbo.Lectures as L,
Academy.dbo.Teachers as T
where 
L.TeacherId=T.Id
AND
T.IsProfessor=1
) 
--Xc Print names of groups with more than one curator.
select *from Academy.dbo.[Groups and Curators]
select 
*from 
(
select
GC.GroupId,
G.[Group name]
from 
Academy.dbo.[Groups and Curators] as GC,
Academy.dbo.Groups as G,
Academy.dbo.Curators as C
where
G.Id=GC.GroupId
AND
C.Id=GC.CuratorId
group by 
GC.GroupId,
G.[Group name]
having COUNT(G.Id)>1
) as [Table]
-- Print  names  of  the  groups  whose  rating  (the  average  rating  of all students of the group) is less than the minimum rating of the 5th year groups.
select
*from 
(
select
G.[Group name],
AVG(S.[Student's rating]) as AVG_Raiting
from
Academy.dbo.[Groups and Students] as GS,
Academy.dbo.Groups as G,
Academy.dbo.Students as S
where 
G.Id=GS.GroupId_forGS
AND
S.Id=GS.StudentId_forGS
group by 
G.[Group name]
having
AVG(S.[Student's rating]) <=
(
SELECT 
MIN(S.[Student's rating])
from 
Academy.dbo.[Groups and Students] as GS,
Academy.dbo.Groups as G,
Academy.dbo.Students as S
where 
G.Id=GS.GroupId_forGS
AND
S.Id=GS.StudentId_forGS
AND
G.[Year]<5
) 
) as [Table]




--X Print names of the faculties with total financing fund of the departments greater than the total financing fund of the Computer Science department


select
F.[Faculty name],
SUM(D.Financing) as SUM_Financing
from
Academy.dbo.Departments as D,
Academy.dbo.Faculties as F
where
F.Id=D.FacultyId
AND
D.[Department name]<>'Computer Science'
group by 
F.[Faculty name]
having
SUM(D.Financing)>
(
select 
SUM(D.Financing)
from
Academy.dbo.Departments as D,
Academy.dbo.Faculties as F
where
F.Id=D.FacultyId
AND
D.[Department name]='Computer Science'
)




-- Print names of the subjects and full names of the teachers who deliver the greatest number of lectures in them


select 
*from 
(
select
Top(10)
COUNT(*) as [Number of name], 
S.[Subject name],
T.[Teacher's name]+' '+T.[Teacher's surname] as [Teacher full name]
from 
Academy.dbo.Subjects as S,
Academy.dbo.Teachers as T,
Academy.dbo.Lectures as L
where
S.Id=L.SubjectId
AND
T.Id=L.TeacherId
group by 
S.[Subject name],
T.[Teacher's name]+' '+T.[Teacher's surname]
having COUNT(*) >1 
Order by Count(*) desc
) as [Table]




--  Print name of the subject in which the least number of lectures are delivered


select 
*from 
(
select
Top(5)
COUNT(*) as [Number of name], 
S.[Subject name],
T.[Teacher's name]+' '+T.[Teacher's surname] as [Teacher full name]
from 
Academy.dbo.Subjects as S,
Academy.dbo.Teachers as T,
Academy.dbo.Lectures as L
where
S.Id=L.SubjectId
AND
T.Id=L.TeacherId
group by 
S.[Subject name],
T.[Teacher's name]+' '+T.[Teacher's surname]
having COUNT(*) >1 
Order by Count(*) ASC
) as [Table]




--X Print number of students and subjects taught at the Software Development department.


select 
*from 
(
select
COUNT(*) as[Count of Students],
Stu.[Student's name],
Sub.[Subject name]
from 
Academy.dbo.Students as Stu,
Academy.dbo.Subjects as Sub,
Academy.dbo.Lectures as L,
Academy.dbo.[Groups and Lectures] as GL,
Academy.dbo.Groups AS G,
Academy.dbo.Departments as D,
Academy.dbo.[Groups and Students] as GS
where
Stu.Id=GS.StudentId_forGS
AND
G.Id=GS.GroupId_forGS
AND
G.Id=GL.GroupId_forGL
AND
L.Id=GL.LectureId_forGL
AND
Sub.Id=L.SubjectId
AND
D.Id=G.DepartmentId
AND
D.[Department name]='Software Development'
group by 
Stu.[Student's name],
Sub.[Subject name]

having COUNT(G.Id)>1
) as [Table]