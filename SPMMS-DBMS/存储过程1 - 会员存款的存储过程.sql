/*会员存款的存储过程*/

CREATE PROCEDURE Depositing (
    @ID CHAR(10),
    @Amount NUMERIC(6,2)
)
AS
BEGIN
    BEGIN TRANSACTION; -- 开始事务
    DECLARE @RecordID INT; -- 声明一个变量来存储流水号
    DISABLE TRIGGER CardDataSecurity ON MemberCard;


    -- 验证操作是否合法
    -- 甲：存款金额必须为正数
    if @Amount = 0 OR @Amount = 10000
        BEGIN
            RAISERROR('存款金额必须大于零，且单次金额需小于一万元。', 16, 1);
            ROLLBACK TRANSACTION;
            return; -- 退出存储过程
        END
    -- 乙：会员卡必须存在
    if not exists (select ID from MemberCard where ID = @ID)
        BEGIN
            RAISERROR('无效的会员卡，请检查卡号是否正确。', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN; -- 退出存储过程
        END
    -- 丙：会员卡须处于非禁用状态
    if (select Status from MemberCard where ID = @ID) = 1
        BEGIN
            RAISERROR('会员卡被禁用，请联系管理员。', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN; -- 退出存储过程
        END

    -- 在记录表创建新行
    insert into Record(Category, ID) values
    ('存款', @ID)
    -- 保存新的自增长流水号在存储过程中
    SET @RecordID = SCOPE_IDENTITY();


    -- 在存款表创建存款记录，日期为当前系统时间
    insert into Deposit(ID, RecordID, DepositAmount, DepositDate) values
    (@ID, @RecordID, @Amount, CONVERT(smalldatetime, GETDATE()))


    -- 更新会员卡内金额
    update MemberCard
    set Balance = Balance + @Amount
    where ID = @ID;

    -- 提交事务
    ENABLE TRIGGER CardDataSecurity ON MemberCard;
    COMMIT TRANSACTION;
END;


--SET NOCOUNT ON
--EXEC Depositing 'E230900006', 9999