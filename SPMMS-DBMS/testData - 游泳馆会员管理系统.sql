-- 插入参数表数据
insert into ParameterTable(pid, pname,pvalue) values
(1,'无折扣', 1),
(2,'88折', 0.88),
(3,'学生特惠', 0.5),
(4,'青年优惠',0.75)

-- 插入会员卡数据
insert into membercard(id, pid, name, phonenumber, sex, birth, type, balance) values
('A230900001', 4,'张伟', '18402187121', '男', '1999-08-21', '折扣卡', '0'),
('E230900002', 1,'赵凯康', '13918051730', '男', '1990-09-10', '储值卡', '0'),
('E230900003', 1,'赵奇水', '13918853396', '男', '1977-03-12', '储值卡', '0'),
('A230900004', 3,'丁梦香', '18217759319', '女', '2001-05-04', '折扣卡', '0'),
('A230900005', 2,'吴兰娟', '19821705462', '女', '1983-10-11', '折扣卡', '0'),
('E230900006', 1,'白云蔚', '13918188447', '女', '1997-07-14', '储值卡', '0')

-- 插入操作员信息
insert into Employee(Employee_ID,Employee_name, Employee_Code) values
('001', 'admin', '1234'),
('002', '谢富有', '2023')

/*
--存款
--SET NOCOUNT ON
--EXEC Depositing 'A230900001', 30

--消费
--SET NOCOUNT ON
--EXEC Expensing 'A230900001', 10

--禁用
--SET NOCOUNT ON
--EXEC Disabling 'A230900001', '挂失'

--解禁
--SET NOCOUNT ON
--EXEC CardResuming 'A230900001'

-- 查询会员资料
select * from SearchMember('A230900001')
select * from SearchMember('伟')

-- 查询消费记录 近一个月/指定开始时间、结束时间(可以精确到分)
select * from  GetTransactionHistory('A23090000100', null, null)
select * from  GetTransactionHistory('A23090000100', '2023-09-18', null)
select * from  GetTransactionHistory('A23090000100', null, '2023-09-19')

-- 查询所有会员卡的汇总记录
select * from SummaryRecord;
*/
