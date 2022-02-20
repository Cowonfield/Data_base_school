--Создали базу данных 

Create Database School

--Таблица сотрудников

Create table Employees(
EmplID int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(50),
LastName nvarchar(50),
BirthDate date NOT NULL,
HireDate date NOT NULL,
Position nvarchar(20), 
Category nvarchar(20))

--заполняем таблицу

Insert into Employees(FirstName,LastName,BirthDate,HireDate,Position)
Values('Snezhanna','Ptichkina','2005-6-05','2015-5-12','Secretary')
Insert into Employees(FirstName,LastName,BirthDate,HireDate,Position)
Values('Vaciliy','Petrov','1958-3-05','1995-5-12','Electric')
Insert into Employees(FirstName,LastName,BirthDate,HireDate,Position)
Values('Mariya','Ivanova','1972-2-04','2002-3-02','Cliner')
Insert into Employees(FirstName,LastName,BirthDate,HireDate,Position,Category)
Values('Efim','Katc','1956-3-05','1995-5-12','Teacher','C1254')
Insert into Employees(FirstName,LastName,BirthDate,HireDate,Position,Category)
Values('Iran','Botcman','1967-6-05','2004-6-22','Teacher','D4256')
Insert into Employees(FirstName,LastName,BirthDate,HireDate,Position,Category)
Values('Haric','Grain','1999-6-05','1998-4-12','Teacher','E678')
Insert into Employees(FirstName,LastName,BirthDate,HireDate,Position,Category)
Values('Joan','Bergman','1989-12-05','2012-5-04','Teacher','G2468')
Insert into Employees(FirstName,LastName,BirthDate,HireDate,Position,Category)
Values('Karl','Lihtenshteyn','1955-11-12','1998-4-23','Director','G1456')

--таблица Зарплата связывается с таблицей Employees по полю EmplID

Create table Salary(
SalaryID int IDENTITY(1,1) PRIMARY KEY,
EmplID int NOT NULL FOREIGN KEY REFERENCES Employees(EmplID),
Salary float Check(Salary>6300))--чтобы не меньше минималки

--заполняем таблицу Salary

Insert into Salary(EmplID,Salary)
Values(15,6500)
Insert into Salary(EmplID,Salary)
Values(16,10000)
Insert into Salary(EmplID,Salary)
Values(17,10500)
Insert into Salary(EmplID,Salary)
Values(18,12000)
Insert into Salary(EmplID,Salary)
Values(19,20000)
Insert into Salary(EmplID,Salary)
Values(20,6350)
Insert into Salary(EmplID,Salary)
Values(21,7000)
Insert into Salary(EmplID,Salary)
Values(22,22000)

--Создаём таблицу классы связывается с таблицей Employees по полю EmplID для назначения куратора

Create table Classes(
ClassID int IDENTITY(1,1) PRIMARY KEY,
ClassName nvarchar(20),
Specialization nvarchar(20),
CuratorID int FOREIGN KEY REFERENCES Employees(EmplID))

 --Сделала триггер на добавление, который проверяет наличие категории у куратора и не является ли он директором.

Create trigger Check_Curator
On Classes
Instead of  Insert
AS
Begin
              Declare 
			       @vClassName nvarchar(20),
                   @vSpecialization nvarchar(20),
				   @vCuratorID int

          Set @vClassName=(Select inserted.ClassName from inserted)
		  Set @vSpecialization=(Select inserted.Specialization from inserted)
		  Set @vCuratorID=(Select inserted.CuratorID from inserted)
    If (@vCuratorID in(Select EmplID
	                  from Employees
					  Where Category=Null or Position='Director'))
					  
	Print 'This person can not be curaror or teacher'
	Else
	Begin
	 Insert into Classes(ClassName,Specialization,CuratorID)
	 Values(@vClassName,@vSpecialization,@vCuratorID)
	 EnD
End

--заполняем таблицу Classes

Insert into Classes(ClassName,Specialization,CuratorID)
Values('M-8','Math',18)
Insert into Classes(ClassName,Specialization,CuratorID)
Values('Ph-9','Physics',16)
Insert into Classes(ClassName,Specialization,CuratorID)
Values('B-10','Biologe',19)
Insert into Classes(ClassName,Specialization,CuratorID)
Values('Eng-7','English',17)


--Таблица для связи учителей с предметами, которые они читают 

Create table TeachSubj(
 ID int IDENTITY(1,1) PRIMARY KEY,
 TeacherID int  FOREIGN KEY REFERENCES Employees(EmplID),
 SubjectID int NOT NULL FOREIGN KEY REFERENCES Subjects(SubjectID))

 --заполняем таблицу TeachSubj

 Insert into TeachSubj(TeacherID,SubjectID)
 Values(16,1)
 Insert into TeachSubj(TeacherID,SubjectID)
 Values(16,2)
 Insert into TeachSubj(TeacherID,SubjectID)
 Values(18,3)
 Insert into TeachSubj(TeacherID,SubjectID)
 Values(18,2)
 Insert into TeachSubj(TeacherID,SubjectID)
 Values(19,1)
 Insert into TeachSubj(TeacherID,SubjectID)
 Values(19,2)
 Insert into TeachSubj(TeacherID,SubjectID)
 Values(22,4)
 Insert into TeachSubj(TeacherID,SubjectID)
 Values(22,3)
 
 --Создаём таблицу ученики 

Create table Pupils(
PupilID int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(50),
LastName nvarchar(50),
BirthDate date NOT NULL,
AdmissionDate date NOT NULL,
ClassID int NOT NULL FOREIGN KEY REFERENCES Classes(ClassID))--связь с  таблицей Classes по ID класса

--заполняем таблицу Pupils

Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Gorje','Lidnyev','2002-03-12','2017-12-15',1)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Egor','Drozdov','2003-05-06','2018-04-17',2)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Marina','Lantc','2003-04-17','2017-07-23',1)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Karl','Manec','2004-09-14','2018-09-26',1)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Gain','Larina','2003-02-20','2017-07-16',2)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Moris','Druon','2002-02-06','2017-06-09',2)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Yurij','Pupkin','2002-12-03','2017-05-01',3)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Linda','Dron','2003-10-01','2018-11-11',3)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Klara','Brain','2002-01-31','2019-03-02',3)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Anna','Pray','2002-10-02','2017-09-09',4)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Garry','Moon','2004-12-31','2019-08-30',4)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Sam','Ruzmin','2003-07-03','2018-10-02',4)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Dick','Berg','2003-12-03','2018-11-02',4)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Henry','Ernas','2002-11-05','2018-08-02',1)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Mark','Lumerk','2001-03-12','2021-12-15',1)
Insert into Pupils(FirstName,LastName,BirthDate,AdmissionDate,ClassID)
Values('Ivan','Ivanov','2002-05-03','2021-10-04',1)

--Таблица предметы

Create table Subjects(
SubjectID int IDENTITY(1,1) PRIMARY KEY,
SubName nvarchar(20) NOT NULL)

-- Заполняем таблицу Subjects

Insert into Subjects(SubName)
values('Math')
Insert into Subjects(SubName)
values('Physics')
Insert into Subjects(SubName)
values('Biologe')
Insert into Subjects(SubName)
values('English')

--Создаём таблицу  оценки

Create table Marks(
MarkId int IDENTITY(1,1) PRIMARY KEY,
PupilID int Not NULL FOREIGN KEY REFERENCES Pupils(PupilID),--связь с таблицей Pupils
SubjectID int NOT NULL,
Mark int Check(Mark<= 12))-- оценка не может быть больше 12 баллов

-- Заполняем таблицу Marks
Insert into Marks(PupilID,SubjectID,Mark)
Values(13,1,9)
Insert into Marks(PupilID,SubjectID,Mark)
Values(13,2,10)
Insert into Marks(PupilID,SubjectID,Mark)
Values(13,3,11)
Insert into Marks(PupilID,SubjectID,Mark)
Values(13,4,9)




--Для спроектированной базы данных реализовать следующие объекты и привести примеры их вызова:

-- Вьюшка, которая выводит имя и оклад сотрудника.

Create View EmplSalary
AS
Select (FirstName+'  '+LastName) as 'Full_Name',Salary
from Salary S join Employees E
on S.EmplID=E.EmplID

--Вьюшка, которая показывает количество учеников по специализациям.

Create View Count_Pupils_by_Spec
AS
Select C.Specialization,Count(P.PupilID) as Count_Pupils
 from Classes C join Pupils P
 on C.ClassID=P.ClassID
 Group by C.Specialization

 -- Хранимую процедуру для назначения учителя директором.

Create Proc NewDirector
     @vEmplId int
AS
Begin
     Update Employees
     Set Position = 'Teacher' --снимаем с должности бывшего директора
     Where Position='Director'
     Update Employees
     Set Position='Director' 
     Where  EmplID=@vEmplId  --назначаем нового(выбор претендента по ID)
End

--выполняем хранимку
     exec NewDirector @vEmplId=17


-- Триггер, который недопускает назначение нового преаодавателя без указания его акредитации (вместо этого выводим на сообщение с предупреждением).

Create Trigger Check_Categ
on Employees
Instead of Insert
As                                                                                    
Begin
     Declare 
	     @vFirstName nvarchar(50),
		 @vLastName nvarchar(50),
		 @vBirthDate date,
		 @vHireDate date,
	     @vPosition nvarchar(20),
		 @vCategory nvarchar(20)

		 Set @vFirstName=(Select inserted.FirstName from inserted)
		 Set @vLastName=(Select inserted.LastName from inserted)
		 Set @vBirthDate=(Select inserted.BirthDate from inserted)
		 Set @vHireDate=(Select inserted.HireDate from inserted)
		 Set @vPosition=(Select inserted.Position from inserted)
		 Set @vCategory=(Select inserted.Category from inserted)
     
	 If(@vPosition='Teacher' and @vCategory=NULL or @vCategory=' ')
	  Print 'Exception- Teacher must be with accreditation'  --если пытаются нанять человека на должность учителя без категории- показываем предупреждение
	  
	 Else
	  Insert into Employees(FirstName,LastName,BirthDate,HireDate,Position,Category)--иначе  добавляем
	  Values(@vFirstName,@vLastName,@vBirthDate,@vHireDate,@vPosition,@vCategory)
End


--Триггер, который при добавлении ученика создает запись в таблице "Новенькие", в которой указывает имя, фамилию, класс и дату приема.

--создаём таблицу для новеньких

Create table New_Pupile(
ID int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(50),
LastName nvarchar(50),
AdmissionDate date NOT NULL,
ClassID int NOT NULL)


-- создаём триггер,который после добавления нового ученика добавляет его ещё и в таблицу для новеньких
Create Trigger Adding_New_Pupile
On Pupils
After Insert
As
Begin
     Declare
	      @vFirstName nvarchar(50),
		  @vLastName nvarchar(50),
		  @vAdmissionDate date,
		  @vClassID int

    Set @vFirstName=(Select inserted.FirstName from inserted)
	Set @vLastName=(Select inserted.LastName from inserted)
	Set @vAdmissionDate=(Select inserted.AdmissionDate from inserted)
	Set @vClassID=(Select inserted.ClassID from inserted)

Insert into New_Pupile(FirstName,LastName,AdmissionDate,ClassID)
Values(@vFirstName,@vLastName,@vAdmissionDate,@vClassID)
End

-- Хранимую процедуру, которая очищает таблицу с "Новенькими", если новенькие больше 3х месяцев в школе.

Create Proc Clear_New_Pupiles
As
Begin
   Delete 
	 from New_Pupile
	Where AdmissionDate <= DATEADD(day, -90, GETDATE())  --сравниваем дату поступления с (текущая дата минус 90 дней)
End

--выполнить хранимку
exec Clear_New_Pupiles