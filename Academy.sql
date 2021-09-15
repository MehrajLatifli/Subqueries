
--Cannot drop database because it is currently in use
USE [master]
ALTER DATABASE Academy SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP database Academy;

-- Delete table with auto increment id
Truncate table Academy.dbo.[Groups and Lectures]; 
DROP table Academy.dbo.[Groups and Lectures]; 

-- Cannot truncate table because it is being referenced by a FOREIGN KEY constraint.
delete from Academy.dbo.Departments;
DBCC CHECKIDENT ('Academy.dbo.Departments', RESEED, 0);








create database Academy
use Academy


Begin



-- Curators

create table Curators
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Curator's name]  nvarchar(max) NOT NULL,
[Curator's surname]  nvarchar(max) NOT NULL,

Check([Curator's name] <>' '),
Check([Curator's surname] <>' ')
)


Insert into Academy.dbo.Curators(Academy.dbo.Curators.[Curator's name], Academy.dbo.Curators.[Curator's surname]) 
values
(N'Fikrət',N'Bayramlı'),
(N'Həsən',N'Hesenli'),
(N'Cavid',N'Oğuzlu'),
(N'Qıbçaq',N'Türksoy'),
(N'Orxan',N'Qüdrətli'),
(N'Bağır',N'Bağırzadə'),
(N'Səbinə',N'Fikrətli'),
(N'Zərifə',N'Osmanlı')

select *from Academy.dbo.Curators




-- Faculties

create table Faculties
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Faculty name]  nvarchar(100) NOT NULL,

Check([Faculty name] <>' '),
UNIQUE ([Faculty name])
)


Insert into Academy.dbo.Faculties(Academy.dbo.Faculties.[Faculty name]) 
values
(N'Computer Science'),
(N'Physics and Chemistry')



select *from Academy.dbo.Faculties




-- Departments

create table Departments
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Department name]  nvarchar(100) NOT NULL,
Financing money default(0) NOT NULL,
Building int NOT NULL,
FacultyId int  NOT NULL,

Check([Department name] <>' '),
UNIQUE ([Department name]),
Check(Financing>0),
Check(Building >=1 AND Building <=5),
Constraint FK_FacultyId Foreign key (FacultyId) References Faculties(Id) On Delete CASCADE On Update CASCADE
)


Insert into Academy.dbo.Departments(Academy.dbo.Departments.[Department name], Academy.dbo.Departments.Financing, Academy.dbo.Departments.Building, Academy.dbo.Departments.FacultyId) 
values
(N'Computer Science', 200500, 1, 1),
(N'Software Development', 150500, 1, 1),
(N'Physics', 100500, 2, 2),
(N'Chemistry', 201000, 2, 2)


select *from Academy.dbo.Departments




-- Groups 

create table Groups
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Group name] nvarchar(10) NOT NULL,
[Year] int  NOT NULL,
DepartmentId int  NOT NULL,
Constraint FK_DepartmentId Foreign key (DepartmentId) References Departments(Id) On Delete CASCADE On Update CASCADE,

Check([Group name] <>' '),
UNIQUE ([Group name]),
Check([Year] >=1 AND [Year] <=5)
)


Insert into Academy.dbo.Groups(Academy.dbo.Groups.[Group name], Academy.dbo.Groups.[Year], Academy.dbo.Groups.DepartmentId) 
values
(N'P107', 5, 1),
(N'B103', 5, 1),
(N'C226', 4, 2),
(N'D221', 4, 2),
(N'A213', 3, 3),
(N'Q289', 3, 3),
(N'V214', 2, 4),
(N'J283', 2, 4),
(N'P207', 1, 1),
(N'B203', 1, 1),
(N'C326', 5, 2),
(N'D421', 5, 2),
(N'A613', 4, 3),
(N'Q589', 4, 3),
(N'V714', 3, 4),
(N'J973', 3, 4),
(N'A870', 2, 3),
(N'Q849', 2, 3),
(N'V584', 1, 4),
(N'J974', 1, 4)




select *from Academy.dbo.Groups


select
*from
Academy.dbo.Groups as G,
Academy.dbo.Departments as D,
Academy.dbo.Faculties as F
where 
G.DepartmentId=D.Id
AND
F.Id=D.FacultyId




-- Groups and Curators

create table [Groups and Curators]
(
Id int primary key IDENTITY (1,1) NOT NULL,
CuratorId int  NOT NULL,
GroupId int  NOT NULL,

Constraint FK_CuratorId Foreign key (CuratorId) References Curators(Id) On Delete CASCADE On Update CASCADE,
Constraint FK_GroupId Foreign key (GroupId) References Groups(Id) On Delete CASCADE On Update CASCADE
)


Insert into Academy.dbo.[Groups and Curators](Academy.dbo.[Groups and Curators].CuratorId, Academy.dbo.[Groups and Curators].GroupId) 
values
(1,1),
(1,2),
(2,3),
(2,4),
(3,5),
(3,6),
(4,7),
(4,8),
(5,9),
(5,10),
(6,11),
(6,12),
(7,13),
(7,14),
(8,15),
(8,16),
(8,17),
(8,18),
(8,19),
(8,20),
(8,4),
(8,1)




select *from Academy.dbo.Curators


select *from Academy.dbo.Groups

select *from Academy.dbo.[Groups and Curators]

select 
G.Id, 
G.[Group name], 
G.[Year], 
C.Id, 
C.[Curator's name], 
C.[Curator's surname], 
GC.GroupId , 
GC.CuratorId
from  
Academy.dbo.Groups as G, 
Academy.dbo.Curators as C, 
Academy.dbo.[Groups and Curators] as GC
where 
G.Id=GC.GroupId 
AND 
C.Id=GC.CuratorId


select 
*from  
Academy.dbo.Groups as G, 
Academy.dbo.Curators as C, 
Academy.dbo.[Groups and Curators] as GC,
Academy.dbo.Departments as D,
Academy.dbo.Faculties as F
where 
G.Id=GC.GroupId 
AND 
C.Id=GC.CuratorId
AND
G.DepartmentId=D.Id
AND
F.Id = D.FacultyId
Order by G.Id ASC




-- Students

create table Students
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Student's name]  nvarchar(max) NOT NULL,
[Student's surname]  nvarchar(max) NOT NULL,
[Student's rating] int NOT NULL,

Check([Student's name] <>' '),
Check([Student's surname] <>' '),
Check([Student's rating] >=0 AND [Student's rating] <=5)
)


Insert into Academy.dbo.Students(Academy.dbo.Students.[Student's name],Academy.dbo.Students.[Student's surname],Academy.dbo.Students.[Student's rating])
values
(N'Student''s name 1',N'Student''s surname 1',5),
(N'Student''s name 2',N'Student''s surname 2',4),
(N'Student''s name 3',N'Student''s surname 3',4),
(N'Student''s name 4',N'Student''s surname 4',4),
(N'Student''s name 5',N'Student''s surname 5',5),
(N'Student''s name 6',N'Student''s surname 6',5),
(N'Student''s name 7',N'Student''s surname 7',5),
(N'Student''s name 8',N'Student''s surname 8',5),
(N'Student''s name 9',N'Student''s surname 9',5),
(N'Student''s name 10',N'Student''s surname 10',4),

(N'Student''s name 11',N'Student''s surname 11',5),
(N'Student''s name 12',N'Student''s surname 12',4),
(N'Student''s name 13',N'Student''s surname 13',4),
(N'Student''s name 14',N'Student''s surname 14',4),
(N'Student''s name 15',N'Student''s surname 15',5),
(N'Student''s name 16',N'Student''s surname 16',5),
(N'Student''s name 17',N'Student''s surname 17',5),
(N'Student''s name 18',N'Student''s surname 18',5),
(N'Student''s name 19',N'Student''s surname 19',5),
(N'Student''s name 20',N'Student''s surname 20',4),

(N'Student''s name 21',N'Student''s surname 21',5),
(N'Student''s name 22',N'Student''s surname 22',4),
(N'Student''s name 23',N'Student''s surname 23',4),
(N'Student''s name 24',N'Student''s surname 24',4),
(N'Student''s name 25',N'Student''s surname 25',5),
(N'Student''s name 26',N'Student''s surname 26',5),
(N'Student''s name 27',N'Student''s surname 27',5),
(N'Student''s name 28',N'Student''s surname 28',5),
(N'Student''s name 29',N'Student''s surname 29',5),
(N'Student''s name 30',N'Student''s surname 30',4),

(N'Student''s name 31',N'Student''s surname 31',5),
(N'Student''s name 32',N'Student''s surname 32',4),
(N'Student''s name 33',N'Student''s surname 33',4),
(N'Student''s name 34',N'Student''s surname 34',4),
(N'Student''s name 35',N'Student''s surname 35',5),
(N'Student''s name 36',N'Student''s surname 36',5),
(N'Student''s name 37',N'Student''s surname 37',5),
(N'Student''s name 38',N'Student''s surname 38',5),
(N'Student''s name 39',N'Student''s surname 39',5),
(N'Student''s name 40',N'Student''s surname 40',4),

(N'Student''s name 41',N'Student''s surname 41',4),
(N'Student''s name 42',N'Student''s surname 42',3),
(N'Student''s name 43',N'Student''s surname 43',3),
(N'Student''s name 44',N'Student''s surname 44',4),
(N'Student''s name 45',N'Student''s surname 45',3),
(N'Student''s name 46',N'Student''s surname 46',4),
(N'Student''s name 47',N'Student''s surname 47',4),
(N'Student''s name 48',N'Student''s surname 48',4),
(N'Student''s name 49',N'Student''s surname 49',3),
(N'Student''s name 50',N'Student''s surname 50',4),

(N'Student''s name 51',N'Student''s surname 51',4),
(N'Student''s name 52',N'Student''s surname 52',3),
(N'Student''s name 53',N'Student''s surname 53',3),
(N'Student''s name 54',N'Student''s surname 54',4),
(N'Student''s name 55',N'Student''s surname 55',3),
(N'Student''s name 56',N'Student''s surname 56',4),
(N'Student''s name 57',N'Student''s surname 57',4),
(N'Student''s name 58',N'Student''s surname 58',4),
(N'Student''s name 59',N'Student''s surname 59',3),
(N'Student''s name 60',N'Student''s surname 60',4),

(N'Student''s name 61',N'Student''s surname 61',4),
(N'Student''s name 62',N'Student''s surname 62',3),
(N'Student''s name 63',N'Student''s surname 63',3),
(N'Student''s name 64',N'Student''s surname 64',4),
(N'Student''s name 65',N'Student''s surname 65',3),
(N'Student''s name 66',N'Student''s surname 66',4),
(N'Student''s name 67',N'Student''s surname 67',4),
(N'Student''s name 68',N'Student''s surname 68',4),
(N'Student''s name 69',N'Student''s surname 69',3),
(N'Student''s name 70',N'Student''s surname 70',4),

(N'Student''s name 71',N'Student''s surname 71',4),
(N'Student''s name 72',N'Student''s surname 72',3),
(N'Student''s name 73',N'Student''s surname 73',3),
(N'Student''s name 74',N'Student''s surname 74',4),
(N'Student''s name 75',N'Student''s surname 75',3),
(N'Student''s name 76',N'Student''s surname 76',4),
(N'Student''s name 77',N'Student''s surname 77',4),
(N'Student''s name 78',N'Student''s surname 78',4),
(N'Student''s name 79',N'Student''s surname 79',3),
(N'Student''s name 80',N'Student''s surname 80',4)


select *from Academy.dbo.Students




-- Groups and Students 

create table [Groups and Students]
(
Id int primary key IDENTITY (1,1) NOT NULL,
GroupId_forGS int  NOT NULL,
StudentId_forGS int  NOT NULL,

Constraint FK_StudentId Foreign key (StudentId_forGS) References Students(Id) On Delete CASCADE On Update CASCADE,
Constraint FK_GroupId_forGS Foreign key (GroupId_forGS) References Groups(Id) On Delete CASCADE On Update CASCADE
)


Insert into Academy.dbo.[Groups and Students](Academy.dbo.[Groups and Students].GroupId_forGS, Academy.dbo.[Groups and Students].StudentId_forGS) 
values
(1,1),
(1,2),
(1,3),
(1,4),

(2,5),
(2,6),
(2,7),
(2,8),

(3,9),
(3,10),
(3,11),
(3,12),

(4,13),
(4,14),
(4,15),
(4,16),

(5,17),
(5,18),
(5,19),
(5,20),

(6,21),
(6,22),
(6,23),
(6,24),

(7,25),
(7,26),
(7,27),
(7,28),

(8,29),
(8,30),
(8,31),
(8,32),

(9,33),
(9,34),
(9,35),
(9,36),

(10,37),
(10,38),
(10,39),
(10,40),

(11,41),
(11,42),
(11,43),
(11,44),

(12,45),
(12,46),
(12,47),
(12,48),

(13,49),
(13,50),
(13,51),
(13,52),

(14,53),
(14,54),
(14,55),
(14,56),

(15,57),
(15,58),
(15,59),
(15,60),

(16,61),
(16,62),
(16,63),
(16,64),

(17,65),
(17,66),
(17,67),
(17,68),

(18,69),
(18,70),
(18,71),
(18,72),

(19,73),
(19,74),
(19,75),
(19,76),

(20,77),
(20,78),
(20,79),
(20,80)


select *from Academy.dbo.Groups


select *from Academy.dbo.Students


select *from Academy.dbo.[Groups and Students]


select 
G.Id, G.[Group name], S.Id, S.[Student's name], S.[Student's surname], S.[Student's rating]
from  
Academy.dbo.Groups as G, 
Academy.dbo.Students as S, 
Academy.dbo.[Groups and Students] as GS
where 
G.Id=GS.GroupId_forGS 
AND 
S.Id=GS.StudentId_forGS
Order by G.Id ASC




-- Teachers

create table Teachers
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Teacher's name] nvarchar(max) NOT NULL,
[Teacher's surname] nvarchar(max) NOT NULL,
IsProfessor bit  NOT NULL default(0),
[Teacher's salary] money NOT NULL default(0),

Check([Teacher's name] <>' '),
Check([Teacher's surname] <>' '),
Check([Teacher's salary]>0)
)


Insert into Academy.dbo.Teachers(Academy.dbo.Teachers.[Teacher's name], Academy.dbo.Teachers.[Teacher's surname], Academy.dbo.Teachers.IsProfessor, Academy.dbo.Teachers.[Teacher's salary])
values
(N'Samantha', N'Adams', 1, 2000 ),
(N'John', N'White', 0, 1250),
(N'Ülkər', N'Məmmədli', 1, 2750),
(N'Fazil', N'İsfəndiyarlı', 0, 1250),
(N'Teymur', N'Şeybani', 1, 2000),
(N'Aidə', N'Namazlı', 0, 1250),
(N'Kate', N'Brown', 1, 2500),
(N'Tamerlan', N'Zamanlı', 0, 1250)


select *from Academy.dbo.Teachers




-- Subjects

create table Subjects
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Subject name] nvarchar(100) NOT NULL,

Check([Subject name] <>' '),
UNIQUE ([Subject name])
)


Insert into Academy.dbo.Subjects(Academy.dbo.Subjects.[Subject name])
values
(N'Basics of Programming'),
(N'Algorithm'),
(N'Higher mathematics'),
(N'Basics of cybernetics'),
(N'Basics of physics'),
(N'Higher physics'),
(N'Basics of chemistry'),
(N'Higher chemistry')


select *from Academy.dbo.Subjects Order By Academy.dbo.Subjects.Id





-- Lectures

create table Lectures
(
Id int primary key IDENTITY (1,1) NOT NULL,
[Date of the lecture] date,
TeacherId int  NOT NULL,
SubjectId int  NOT NULL,

Constraint FK_TeacherId Foreign key (TeacherId) References Teachers(Id) On Delete CASCADE On Update CASCADE,
Constraint FK_SubjectId Foreign key (SubjectId) References Subjects(Id) On Delete CASCADE On Update CASCADE,

Check([Date of the lecture] <  GETDATE())
)


Insert into Academy.dbo.Lectures(Academy.dbo.Lectures.[Date of the lecture], Academy.dbo.Lectures.TeacherId, Academy.dbo.Lectures.SubjectId)
values
('2021-09-1',1,1),
('2021-09-1',1,2),
('2021-09-1',2,1),
('2021-09-1',2,2),

('2021-09-1',1,1),
('2021-09-1',1,2),
('2021-09-1',2,1),
('2021-09-1',2,2),

('2021-09-3',1,1),
('2021-09-3',1,2),
('2021-09-3',2,1),
('2021-09-3',2,2),

('2021-09-3',1,1),
('2021-09-3',1,2),
('2021-09-3',2,1),
('2021-09-3',2,2),

('2021-09-5',1,1),
('2021-09-5',1,2),
('2021-09-5',2,1),
('2021-09-5',2,2),

('2021-09-5',1,1),
('2021-09-5',1,2),
('2021-09-5',2,1),
('2021-09-5',2,2),

('2021-09-5',1,1),
('2021-09-5',1,2),
('2021-09-5',2,1),
('2021-09-5',2,2),

('2021-09-5',1,1),
('2021-09-5',1,2),
('2021-09-5',2,1),
('2021-09-5',2,2),

('2021-09-6',1,1),
('2021-09-6',1,2),
('2021-09-6',2,1),
('2021-09-6',2,2),

('2021-09-6',1,1),
('2021-09-6',1,2),
('2021-09-6',2,1),
('2021-09-6',2,2),

('2021-09-7',1,1),
('2021-09-7',1,2),
('2021-09-7',2,1),
('2021-09-7',2,2),

('2021-09-8',1,1),
('2021-09-8',1,2),
('2021-09-8',2,1),
('2021-09-8',2,2),

('2021-09-7',1,1),
('2021-09-7',1,2),
('2021-09-7',2,1),
('2021-09-7',2,2),

('2021-09-10',1,1),
('2021-09-10',1,2),
('2021-09-10',2,1),
('2021-09-10',2,2),

('2021-09-11',1,1),
('2021-09-11',1,2),
('2021-09-11',2,1),
('2021-09-11',2,2),

('2021-09-13',1,1),
('2021-09-13',1,2),
('2021-09-13',2,1),
('2021-09-13',2,2),

('2021-09-13',1,1),
('2021-09-13',1,2),
('2021-09-13',2,1),
('2021-09-13',2,2),

--

('2021-09-1',3,3),
('2021-09-1',4,4),
('2021-09-1',3,4),
('2021-09-1',4,3),

('2021-09-1',4,3),
('2021-09-1',3,4),
('2021-09-1',3,4),
('2021-09-1',4,3),

('2021-09-3',3,3),
('2021-09-3',4,3),
('2021-09-3',4,4),
('2021-09-3',3,4),

('2021-09-3',3,3),
('2021-09-3',4,4),
('2021-09-3',3,3),
('2021-09-3',4,4),

('2021-09-5',3,4),
('2021-09-5',4,4),
('2021-09-5',3,4),
('2021-09-5',3,4),

('2021-09-5',3,4),
('2021-09-5',3,3),
('2021-09-5',4,3),
('2021-09-5',4,4),

('2021-09-5',4,4),
('2021-09-5',3,4),
('2021-09-5',4,3),
('2021-09-5',3,3),

('2021-09-5',4,3),
('2021-09-5',4,4),
('2021-09-5',3,4),
('2021-09-5',3,3),

('2021-09-6',3,3),
('2021-09-6',3,4),
('2021-09-6',4,4),
('2021-09-6',4,3),

('2021-09-6',3,3),
('2021-09-6',3,4),
('2021-09-6',4,4),
('2021-09-6',4,3),

('2021-09-7',3,3),
('2021-09-7',3,4),
('2021-09-7',4,4),
('2021-09-7',4,3),

('2021-09-8',3,3),
('2021-09-8',3,4),
('2021-09-8',4,4),
('2021-09-8',4,3),

('2021-09-7',3,4),
('2021-09-7',3,3),
('2021-09-7',4,4),
('2021-09-7',4,3),

('2021-09-10',3,3),
('2021-09-10',3,4),
('2021-09-10',4,4),
('2021-09-10',4,3),

('2021-09-11',4,3),
('2021-09-11',4,4),
('2021-09-11',3,4),
('2021-09-11',3,3),

('2021-09-13',3,3),
('2021-09-13',3,4),
('2021-09-13',4,4),
('2021-09-13',4,3),

('2021-09-13',3,4),
('2021-09-13',3,3),
('2021-09-13',4,4),
('2021-09-13',4,3),

--

('2021-09-1',5,5),
('2021-09-1',6,6),
('2021-09-1',6,5),
('2021-09-1',5,6),


('2021-09-3',5,5),
('2021-09-3',5,6),
('2021-09-3',6,6),
('2021-09-3',6,5),

('2021-09-3',5,6),
('2021-09-3',5,5),
('2021-09-3',6,6),
('2021-09-3',6,5),


('2021-09-5',6,5),
('2021-09-5',6,6),
('2021-09-5',5,5),
('2021-09-5',5,6),

('2021-09-5',5,5),
('2021-09-5',5,6),
('2021-09-5',6,5),
('2021-09-5',6,6),

('2021-09-6',5,6),
('2021-09-6',5,5),
('2021-09-6',6,6),
('2021-09-6',6,5),

('2021-09-7',5,5),
('2021-09-7',5,6),
('2021-09-7',6,5),
('2021-09-7',6,6),


('2021-09-10',5,6),
('2021-09-10',5,5),
('2021-09-10',6,5),
('2021-09-10',6,6),

('2021-09-13',5,6),
('2021-09-13',6,5),
('2021-09-13',6,6),
('2021-09-13',5,5),

--

('2021-09-1',7,7),
('2021-09-1',8,7),
('2021-09-1',7,8),
('2021-09-1',8,8),


('2021-09-3',7,8),
('2021-09-3',8,8),
('2021-09-3',7,7),
('2021-09-3',8,7),

('2021-09-5',7,8),
('2021-09-5',8,8),
('2021-09-5',7,7),
('2021-09-5',8,7),

('2021-09-5',8,7),
('2021-09-5',7,7),
('2021-09-5',7,8),
('2021-09-5',8,8),

('2021-09-6',7,8),
('2021-09-6',7,7),
('2021-09-6',8,8),
('2021-09-6',8,7),

('2021-09-7',8,7),
('2021-09-7',8,8),
('2021-09-7',7,7),
('2021-09-7',7,8),


('2021-09-10',8,8),
('2021-09-10',7,7),
('2021-09-10',8,8),
('2021-09-10',7,7),

('2021-09-13',7,7),
('2021-09-13',7,8),
('2021-09-13',8,7),
('2021-09-13',8,8)


select *from Subjects order by Subjects.Id


select *from Teachers order by Teachers.Id


select *from Academy.dbo.Lectures


select 
*from  
Academy.dbo.Subjects as S, 
Academy.dbo.Teachers as T, 
Academy.dbo.Lectures as L
where 
T.Id=L.TeacherId
AND 
S.Id=L.SubjectId 





-- Groups and Lectures

create table [Groups and Lectures]
(
Id int primary key IDENTITY (1,1) NOT NULL,
GroupId_forGL int  NOT NULL,
LectureId_forGL int  NOT NULL,

Constraint FK_GroupId_forGL Foreign key (GroupId_forGL) References Groups(Id) On Delete CASCADE On Update CASCADE,
Constraint FK_LectureId_forGL Foreign key (LectureId_forGL) References Lectures(Id) On Delete CASCADE On Update CASCADE
)



Insert into Academy.dbo.[Groups and Lectures](Academy.dbo.[Groups and Lectures].GroupId_forGL, Academy.dbo.[Groups and Lectures].LectureId_forGL)
VALUES

(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),

(1,201),
(1,202),
(1,203),
(1,204),


(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),

(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(2, 19),
(2, 20),

(2, 21),
(2, 22),
(2, 23),
(2, 24),
(2, 25),
(2, 26),
(2, 27),
(2, 28),
(2, 29),
(2, 30),

(2, 31),
(2, 32),
(2, 33),
(2, 34),
(2, 35),
(2, 36),
(2, 37),
(2, 38),
(2, 39),
(2, 40),

(2, 41),
(2, 42),
(2, 43),
(2, 44),
(2, 45),
(2, 46),
(2, 47),
(2, 48),
(2, 49),
(2, 50),

(2, 51),
(2, 52),
(2, 53),
(2, 54),
(2, 55),
(2, 56),
(2, 57),
(2, 58),
(2, 59),
(2, 60),

(2, 61),
(2, 62),
(2, 63),
(2, 64),
(2, 65),
(2, 66),
(2, 67),
(2, 68),
(2, 69),
(2, 70),

(2, 71),
(2, 72),
(2, 73),
(2, 74),
(2, 75),
(2, 76),
(2, 77),
(2, 78),
(2, 79),
(2, 80),


(2, 151),
(2, 152),
(2, 153),
(2, 154),
(2, 155),
(2, 156),
(2, 157),
(2, 158),
(2, 159),
(2, 160),

(2, 161),
(2, 162),
(2, 163),
(2, 164),
(2, 165),
(2, 166),
(2, 167),
(2, 168),
(2, 169),
(2, 170),

(2, 191),
(2, 192),
(2, 193),
(2, 194),
(2, 195),
(2, 196),
(2, 197),
(2, 198),
(2, 199),
(2, 200),


(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),

(3, 11),
(3, 12),
(3, 13),
(3, 14),
(3, 15),
(3, 16),
(3, 17),
(3, 18),
(3, 19),
(3, 20),

(3, 201),
(3, 202),
(3, 203),
(3, 204),


(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(4, 6),
(4, 7),
(4, 8),
(4, 9),
(4, 10),

(4, 11),
(4, 12),
(4, 13),
(4, 14),
(4, 15),
(4, 16),
(4, 17),
(4, 18),
(4, 19),
(4, 20),

(4, 21),
(4, 22),
(4, 23),
(4, 24),
(4, 25),
(4, 26),
(4, 27),
(4, 28),
(4, 29),
(4, 30),

(4, 31),
(4, 32),
(4, 33),
(4, 34),
(4, 35),
(4, 36),
(4, 37),
(4, 38),
(4, 39),
(4, 40),

(4, 41),
(4, 42),
(4, 43),
(4, 44),
(4, 45),
(4, 46),
(4, 47),
(4, 48),
(4, 49),
(4, 50),

(4, 51),
(4, 52),
(4, 53),
(4, 54),
(4, 55),
(4, 56),
(4, 57),
(4, 58),
(4, 59),
(4, 60),

(4, 61),
(4, 62),
(4, 63),
(4, 64),
(4, 65),
(4, 66),
(4, 67),
(4, 68),
(4, 69),
(4, 70),

(4, 71),
(4, 72),
(4, 73),
(4, 74),
(4, 75),
(4, 76),
(4, 77),
(4, 78),
(4, 79),
(4, 80),

(4, 81),
(4, 82),
(4, 83),
(4, 84),
(4, 85),
(4, 86),
(4, 87),
(4, 88),
(4, 89),
(4, 90),

(4, 91),
(4, 92),
(4, 93),
(4, 94),
(4, 95),
(4, 96),
(4, 97),
(4, 98),
(4, 99),
(4, 100),

(4, 101),
(4, 102),
(4, 103),
(4, 104),
(4, 105),
(4, 106),
(4, 107),
(4, 108),
(4, 109),
(4, 110),

(4, 111),
(4, 112),
(4, 113),
(4, 114),
(4, 115),
(4, 116),
(4, 117),
(4, 118),
(4, 119),
(4, 120),

(4, 121),
(4, 122),
(4, 123),
(4, 124),
(4, 125),
(4, 126),
(4, 127),
(4, 128),
(4, 129),
(4, 130),

(4, 131),
(4, 132),
(4, 133),
(4, 134),
(4, 135),
(4, 136),
(4, 137),
(4, 138),
(4, 139),
(4, 140),

(4, 141),
(4, 142),
(4, 143),
(4, 144),
(4, 145),
(4, 146),
(4, 147),
(4, 148),
(4, 149),
(4, 150),

(4, 151),
(4, 152),
(4, 153),
(4, 154),
(4, 155),
(4, 156),
(4, 157),
(4, 158),
(4, 159),
(4, 160),

(4, 161),
(4, 162),
(4, 163),
(4, 164),
(4, 165),
(4, 166),
(4, 167),
(4, 168),
(4, 169),
(4, 170),

(4, 171),
(4, 172),
(4, 173),
(4, 174),
(4, 175),
(4, 176),
(4, 177),
(4, 178),
(4, 179),
(4, 180),

(4, 181),
(4, 182),
(4, 183),
(4, 184),
(4, 185),
(4, 186),
(4, 187),
(4, 188),
(4, 189),
(4, 190),

(4, 191),
(4, 192),
(4, 193),
(4, 194),
(4, 195),
(4, 196),
(4, 197),
(4, 198),
(4, 199),
(4, 200),

(4, 201),
(4, 202),
(4, 203),
(4, 204),


(5, 1),
(5, 2),
(5, 3),
(5, 4),
(5, 5),
(5, 6),
(5, 7),
(5, 8),
(5, 9),
(5, 10),

(5, 11),
(5, 12),
(5, 13),
(5, 14),
(5, 15),
(5, 16),
(5, 17),
(5, 18),
(5, 19),
(5, 20),

(5, 81),
(5, 82),
(5, 83),
(5, 84),
(5, 85),
(5, 86),
(5, 87),
(5, 88),
(5, 89),
(5, 90),

(5, 91),
(5, 92),
(5, 93),
(5, 94),
(5, 95),
(5, 96),
(5, 97),
(5, 98),
(5, 99),
(5, 100),

(5, 121),
(5, 122),
(5, 123),
(5, 124),
(5, 125),
(5, 126),
(5, 127),
(5, 128),
(5, 129),
(5, 130),

(5, 201),
(5, 202),
(5, 203),
(5, 204),


(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 5),
(6, 6),
(6, 7),
(6, 8),
(6, 9),
(6, 10),

(6, 11),
(6, 12),
(6, 13),
(6, 14),
(6, 15),
(6, 16),
(6, 17),
(6, 18),
(6, 19),
(6, 20),

(6, 191),
(6, 192),
(6, 193),
(6, 194),
(6, 195),
(6, 196),
(6, 197),
(6, 198),
(6, 199),
(6, 200),

(6, 201),
(6, 202),
(6, 203),
(6, 204),

(7, 1),
(7, 2),
(7, 3),
(7, 4),
(7, 5),
(7, 6),
(7, 7),
(7, 8),
(7, 9),
(7, 10),


(7, 201),
(7, 202),
(7, 203),
(7, 204),


(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(8, 6),
(8, 7),
(8, 8),
(8, 9),
(8, 10),

(8, 91),
(8, 92),
(8, 93),
(8, 94),
(8, 95),
(8, 96),
(8, 97),
(8, 98),
(8, 99),
(8, 100),

(8, 201),
(8, 202),
(8, 203),
(8, 204),


(9, 1),
(9, 2),
(9, 3),
(9, 4),
(9, 5),
(9, 6),
(9, 7),
(9, 8),
(9, 9),
(9, 10),

(9, 51),
(9, 52),
(9, 53),
(9, 54),
(9, 55),
(9, 56),
(9, 57),
(9, 58),
(9, 59),
(9, 60),

(10, 1),
(10, 2),
(10, 3),
(10, 4),
(10, 5),
(10, 6),
(10, 7),
(10, 8),
(10, 9),
(10, 10),

(10, 51),
(10, 52),
(10, 53),
(10, 54),
(10, 55),
(10, 56),
(10, 57),
(10, 58),
(10, 59),
(10, 60),


(10, 91),
(10, 92),
(10, 93),
(10, 94),
(10, 95),
(10, 96),
(10, 97),
(10, 98),
(10, 99),
(10, 100),


(11, 1),
(11, 2),
(11, 3),
(11, 4),
(11, 5),
(11, 6),
(11, 7),
(11, 8),
(11, 9),
(11, 10),


(11, 21),
(11, 22),
(11, 23),
(11, 24),
(11, 25),
(11, 26),
(11, 27),
(11, 28),
(11, 29),
(11, 30),

(11, 81),
(11, 82),
(11, 83),
(11, 84),
(11, 85),
(11, 86),
(11, 87),
(11, 88),
(11, 89),
(11, 90),

(11, 201),
(11, 202),
(11, 203),
(11, 204),


(12, 1),
(12, 2),
(12, 3),
(12, 4),
(12, 5),
(12, 6),
(12, 7),
(12, 8),
(12, 9),
(12, 10),

(12, 121),
(12, 122),
(12, 123),
(12, 124),
(12, 125),
(12, 126),
(12, 127),
(12, 128),
(12, 129),
(12, 130),


(13, 1),
(13, 2),
(13, 3),
(13, 4),
(13, 5),
(13, 6),
(13, 7),
(13, 8),
(13, 9),
(13, 10),

(13, 201),
(13, 202),
(13, 203),
(13, 204),


(14, 1),
(14, 2),
(14, 3),
(14, 4),
(14, 5),
(14, 6),
(14, 7),
(14, 8),
(14, 9),
(14, 10),

(14, 11),
(14, 12),
(14, 13),
(14, 14),
(14, 15),
(14, 16),
(14, 17),
(14, 18),
(14, 19),
(14, 20),

(14, 151),
(14, 152),
(14, 153),
(14, 154),
(14, 155),
(14, 156),
(14, 157),
(14, 158),
(14, 159),
(14, 160),

(15, 1),
(15, 2),
(15, 3),
(15, 4),
(15, 5),
(15, 6),
(15, 7),
(15, 8),
(15, 9),
(15, 10),


(16, 1),
(16, 2),
(16, 3),
(16, 4),
(16, 5),
(16, 6),
(16, 7),
(16, 8),
(16, 9),
(16, 10),

(16, 11),
(16, 12),
(16, 13),
(16, 14),
(16, 15),
(16, 16),
(16, 17),
(16, 18),
(16, 19),
(16, 20),


(16, 161),
(16, 162),
(16, 163),
(16, 164),
(16, 165),
(16, 166),
(16, 167),
(16, 168),
(16, 169),
(16, 170),

(16, 201),
(16, 202),
(16, 203),
(16, 204),


(17, 141),
(17, 142),
(17, 143),
(17, 144),
(17, 145),
(17, 146),
(17, 147),
(17, 148),
(17, 149),
(17, 150),

(17, 201),
(17, 202),
(17, 203),
(17, 204),


(18, 1),
(18, 2),
(18, 3),
(18, 4),
(18, 5),
(18, 6),
(18, 7),
(18, 8),
(18, 9),
(18, 10),

(18, 201),
(18, 202),
(18, 203),
(18, 204),


(19, 1),
(19, 2),
(19, 3),
(19, 4),
(19, 5),
(19, 6),
(19, 7),
(19, 8),
(19, 9),
(19, 10),



(19, 201),
(19, 202),
(19, 203),
(19, 204),


(20, 1),
(20, 2),
(20, 3),
(20, 4),
(20, 5),
(20, 6),
(20, 7),
(20, 8),
(20, 9),
(20, 10),

(20, 201),
(20, 202),
(20, 203),
(20, 204)


SELECT* FROM Subjects


select *from Academy.dbo.Lectures 


select *from Academy.dbo.[Groups and Lectures] 


select
 G.Id as [Id of Group],
 G.[Group name],
 S.[Subject name],
 L.[Date of the lecture],
 T.[Teacher's name]+' '+T.[Teacher's surname] as Teacher
from  
Academy.dbo.Groups as G, 
Academy.dbo.Lectures as L, 
Academy.dbo.[Groups and Lectures] as GL,
Academy.dbo.Subjects as S,
Academy.dbo.Teachers as T
Where
G.Id = GL.GroupId_forGL
AND
L.Id= GL.LectureId_forGL
AND
T.Id = L.TeacherId
AND
S.Id=L.SubjectId


select distinct
 G.Id as [Id of Group],
 G.[Group name],
 S.[Subject name],
 L.[Date of the lecture],
 T.[Teacher's name]+' '+T.[Teacher's surname] as Teacher
from  
Academy.dbo.Groups as G, 
Academy.dbo.Lectures as L, 
Academy.dbo.[Groups and Lectures] as GL,
Academy.dbo.Subjects as S,
Academy.dbo.Teachers as T
Where
G.Id = GL.GroupId_forGL
AND
L.Id= GL.LectureId_forGL
AND
T.Id = L.TeacherId
AND
S.Id=L.SubjectId
group by 
G.Id,
G.[Group name], 
S.[Subject name],  
L.[Date of the lecture],
T.[Teacher's name]+' '+T.[Teacher's surname]


End