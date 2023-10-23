/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     2023/9/18 12:26:16                           */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Deposit') and o.name = 'FK_DEPOSIT_DEPOSIT_MEMBERCA')
alter table Deposit
   drop constraint FK_DEPOSIT_DEPOSIT_MEMBERCA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Deposit') and o.name = 'FK_DEPOSIT_DEPOSIT2_RECORD')
alter table Deposit
   drop constraint FK_DEPOSIT_DEPOSIT2_RECORD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Disable') and o.name = 'FK_DISABLE_DISABLED_MEMBERCA')
alter table Disable
   drop constraint FK_DISABLE_DISABLED_MEMBERCA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Disable') and o.name = 'FK_DISABLE_DISABLED2_RECORD')
alter table Disable
   drop constraint FK_DISABLE_DISABLED2_RECORD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Disable') and o.name = 'FK_DISABLE_DISABLED3_EMPLOYEE')
alter table Disable
   drop constraint FK_DISABLE_DISABLED3_EMPLOYEE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Expense') and o.name = 'FK_EXPENSE_EXPENSE_MEMBERCA')
alter table Expense
   drop constraint FK_EXPENSE_EXPENSE_MEMBERCA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Expense') and o.name = 'FK_EXPENSE_EXPENSE2_RECORD')
alter table Expense
   drop constraint FK_EXPENSE_EXPENSE2_RECORD
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MemberCard') and o.name = 'FK_MEMBERCA_DISCOUNT_PARAMETE')
alter table MemberCard
   drop constraint FK_MEMBERCA_DISCOUNT_PARAMETE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('Record') and o.name = 'FK_RECORD_HOLD_MEMBERCA')
alter table Record
   drop constraint FK_RECORD_HOLD_MEMBERCA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SummaryRecord')
            and   type = 'V')
   drop view SummaryRecord
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Deposit')
            and   name  = 'Deposit2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Deposit.Deposit2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Deposit')
            and   name  = 'Deposit_FK'
            and   indid > 0
            and   indid < 255)
   drop index Deposit.Deposit_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Deposit')
            and   type = 'U')
   drop table Deposit
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Disable')
            and   name  = 'Disabled3_FK'
            and   indid > 0
            and   indid < 255)
   drop index Disable.Disabled3_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Disable')
            and   name  = 'Disabled2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Disable.Disabled2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Disable')
            and   name  = 'Disabled_FK'
            and   indid > 0
            and   indid < 255)
   drop index Disable.Disabled_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Disable')
            and   type = 'U')
   drop table Disable
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Employee')
            and   type = 'U')
   drop table Employee
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Expense')
            and   name  = 'Expense2_FK'
            and   indid > 0
            and   indid < 255)
   drop index Expense.Expense2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Expense')
            and   name  = 'Expense_FK'
            and   indid > 0
            and   indid < 255)
   drop index Expense.Expense_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Expense')
            and   type = 'U')
   drop table Expense
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MemberCard')
            and   name  = 'Discount_FK'
            and   indid > 0
            and   indid < 255)
   drop index MemberCard.Discount_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MemberCard')
            and   type = 'U')
   drop table MemberCard
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ParameterTable')
            and   type = 'U')
   drop table ParameterTable
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('Record')
            and   name  = 'Hold_FK'
            and   indid > 0
            and   indid < 255)
   drop index Record.Hold_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('Record')
            and   type = 'U')
   drop table Record
go

/*==============================================================*/
/* Table: Deposit                                               */
/*==============================================================*/
create table Deposit (
   ID                   char(10)             not null,
   RecordID             int                  not null,
   DepositAmount        numeric(6,2)         null,
   DepositDate          smalldatetime        null,
   constraint PK_DEPOSIT primary key nonclustered (ID, RecordID)
)
go

/*==============================================================*/
/* Index: Deposit_FK                                            */
/*==============================================================*/
create index Deposit_FK on Deposit (
ID ASC
)
go

/*==============================================================*/
/* Index: Deposit2_FK                                           */
/*==============================================================*/
create index Deposit2_FK on Deposit (
RecordID ASC
)
go

/*==============================================================*/
/* Table: Disable                                               */
/*==============================================================*/
create table Disable (
   ID                   char(10)             not null,
   RecordID             int                  not null,
   Employee_ID          char(5)              not null,
   Disable_Reason       varchar(10)          null,
   Disable_Date         smalldatetime        null,
   constraint PK_DISABLE primary key nonclustered (ID, RecordID, Employee_ID)
)
go

/*==============================================================*/
/* Index: Disabled_FK                                           */
/*==============================================================*/
create index Disabled_FK on Disable (
ID ASC
)
go

/*==============================================================*/
/* Index: Disabled2_FK                                          */
/*==============================================================*/
create index Disabled2_FK on Disable (
RecordID ASC
)
go

/*==============================================================*/
/* Index: Disabled3_FK                                          */
/*==============================================================*/
create index Disabled3_FK on Disable (
Employee_ID ASC
)
go

/*==============================================================*/
/* Table: Employee                                              */
/*==============================================================*/
create table Employee (
   Employee_ID          char(5)              not null,
   Employee_Name        varchar(20)          not null,
   Employee_Code        char(4)              not null,
   constraint PK_EMPLOYEE primary key nonclustered (Employee_ID)
)
go

/*==============================================================*/
/* Table: Expense                                               */
/*==============================================================*/
create table Expense (
   ID                   char(10)             not null,
   RecordID             int                  not null,
   ExpenseAmount        numeric(6,2)         null,
   ExpenseDate          smalldatetime        null,
   constraint PK_EXPENSE primary key nonclustered (ID, RecordID)
)
go

/*==============================================================*/
/* Index: Expense_FK                                            */
/*==============================================================*/
create index Expense_FK on Expense (
ID ASC
)
go

/*==============================================================*/
/* Index: Expense2_FK                                           */
/*==============================================================*/
create index Expense2_FK on Expense (
RecordID ASC
)
go

/*==============================================================*/
/* Table: MemberCard                                            */
/*==============================================================*/
create table MemberCard (
   ID                   char(10)             not null,
   PID                  char(5)              null,
   Name                 varchar(20)          not null,
   PhoneNumber          char(11)             not null,
   Sex                  char(2)              null,
   Birth                date                 null,
   Type                 char(6)              not null,
   Balance              numeric(6,2)         not null,
   Status               bit                  null default 0,
   constraint PK_MEMBERCARD primary key nonclustered (ID)
)
go

/*==============================================================*/
/* Index: Discount_FK                                           */
/*==============================================================*/
create index Discount_FK on MemberCard (
PID ASC
)
go

/*==============================================================*/
/* Table: ParameterTable                                        */
/*==============================================================*/
create table ParameterTable (
   PID                  char(5)              not null,
   PName                char(20)             null,
   PValue               float(10)            null,
   constraint PK_PARAMETERTABLE primary key nonclustered (PID)
)
go

/*==============================================================*/
/* Table: Record                                                */
/*==============================================================*/
create table Record (
   RecordID             int                  identity,
   ID                   char(10)             null,
   Category             char(5)              not null,
   constraint PK_RECORD primary key nonclustered (RecordID)
)
go

/*==============================================================*/
/* Index: Hold_FK                                               */
/*==============================================================*/
create index Hold_FK on Record (
ID ASC
)
go

/*==============================================================*/
/* View: SummaryRecord                                          */
/*==============================================================*/
create view SummaryRecord as
select
   RecordID as 单号,
   ID as 卡号,
   '存款' as 类别,
   CAST(Deposit_Amount AS varchar(50)) as 交易内容,
   Deposit_Date as 交易时间
from
   Deposit
UNION
select
   RecordID as 单号,
   ID as 卡号,
   '消费' as 类别,
   CAST(Expense_Amount AS varchar(50)) as 交易内容,
   Expense_Date as 交易时间
from
   Expense
UNION
select
   RecordID as 单号,
   ID as 卡号,
   '禁用' as 类别,
   Disable_Reason as 交易内容,
   Disable_Date as 交易时间
from
   Disabled
go

alter table Deposit
   add constraint FK_DEPOSIT_DEPOSIT_MEMBERCA foreign key (ID)
      references MemberCard (ID)
go

alter table Deposit
   add constraint FK_DEPOSIT_DEPOSIT2_RECORD foreign key (RecordID)
      references Record (RecordID)
go

alter table Disable
   add constraint FK_DISABLE_DISABLED_MEMBERCA foreign key (ID)
      references MemberCard (ID)
go

alter table Disable
   add constraint FK_DISABLE_DISABLED2_RECORD foreign key (RecordID)
      references Record (RecordID)
go

alter table Disable
   add constraint FK_DISABLE_DISABLED3_EMPLOYEE foreign key (Employee_ID)
      references Employee (Employee_ID)
go

alter table Expense
   add constraint FK_EXPENSE_EXPENSE_MEMBERCA foreign key (ID)
      references MemberCard (ID)
go

alter table Expense
   add constraint FK_EXPENSE_EXPENSE2_RECORD foreign key (RecordID)
      references Record (RecordID)
go

alter table MemberCard
   add constraint FK_MEMBERCA_DISCOUNT_PARAMETE foreign key (PID)
      references ParameterTable (PID)
go

alter table Record
   add constraint FK_RECORD_HOLD_MEMBERCA foreign key (ID)
      references MemberCard (ID)
go

