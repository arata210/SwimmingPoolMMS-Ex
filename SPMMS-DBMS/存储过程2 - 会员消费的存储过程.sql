/*会员消费的存储过程*/

CREATE PROCEDURE Expensing (
    @ID CHAR(10),
    @Amount NUMERIC(6,2)
)
AS
BEGIN
    BEGIN TRANSACTION; -- 开始事务
    DECLARE @RecordID INT; -- 声明一个变量来存储流水号
    DECLARE @PID CHAR(5);
    DECLARE @PValue float(10);
    DECLARE @balance NUMERIC(6,2);
    DISABLE TRIGGER CardDataSecurity ON MemberCard;


    -- 甲：会员卡必须存在
    if not exists (select ID from MemberCard where ID = @ID)
        BEGIN
            RAISERROR('无效的会员卡，请检查卡号是否正确。', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN; -- 退出存储过程
        END
    -- 乙：会员卡须处于非禁用状态
    if (select Status from MemberCard where ID = @ID) = 1
        BEGIN
            RAISERROR('会员卡被禁用，请联系管理员。', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN; -- 退出存储过程
        END

    SET @PID = (select pid from MemberCard where ID = @ID)
    SET @PValue = (select pvalue from ParameterTable where pid=@pid)
    SET @balance = (select balance from MemberCard where ID = @ID)

    -- 验证操作是否合法
    -- 丙：消费金额必须为正数或小于一万或消费完余额大于0
    if @Amount = 0 OR @Amount = 10000 OR (@balance - @Amount*@PValue)<0
        BEGIN
            RAISERROR('消费金额不符合要求或余额不足。', 16, 1);
            ROLLBACK TRANSACTION;
            return; -- 退出存储过程
        END

    -- 在记录表创建新行
    insert into Record(Category, ID) values
    ('消费', @ID)
    -- 保存新的自增长流水号在存储过程中
    SET @RecordID = SCOPE_IDENTITY();

    -- 在消费表创建消费记录，消费金额需要乘以折扣(无折扣则为1)，日期为当前系统时间
    insert into Expense(ID, RecordID, ExpenseAmount, ExpenseDate) values
    (@ID, @RecordID, @Amount*@PValue, CONVERT(smalldatetime, GETDATE()))


    -- 更新会员卡内金额
    update MemberCard
    set Balance = Balance - @Amount*@PValue
    where ID = @ID;

   ENABLE TRIGGER CardDataSecurity ON MemberCard;
    -- 提交事务
    COMMIT TRANSACTION;
    RETURN;
END;


--SET NOCOUNT ON
--EXEC Expensing 'A230900001', 10