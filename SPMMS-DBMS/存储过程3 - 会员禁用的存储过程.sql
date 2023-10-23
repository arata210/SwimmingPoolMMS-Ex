/*会员禁用的存储过程*/

CREATE PROCEDURE Disabling (
    @ID CHAR(10),
    @Disable_Reason CHAR(50),
    @Employee_ID CHAR(5) = '001'
)
AS
BEGIN
    BEGIN TRANSACTION; -- 开始事务
    DECLARE @RecordID INT; -- 声明一个变量来存储流水号


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
            RAISERROR('会员卡已被禁用，无需继续操作。', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN; -- 退出存储过程
        END

    -- 验证操作是否合法
    -- 丙：原因只能'挂失' '停用' '其他'
    if @Disable_Reason != '挂失' AND @Disable_Reason != '停用'
        BEGIN
            SET @Disable_Reason = '其他'
        END
        
    -- 丁：防止外部恶意修改
    -- 改进之处：可以要求输入口令，或者在前端实现   
    if not exists (select Employee_ID from Employee where Employee_ID = @Employee_ID)
            BEGIN
                RAISERROR('工号不存在，无法执行操作。', 16, 1);
                ROLLBACK TRANSACTION;
                RETURN; -- 退出存储过程
            END


    -- 在记录表创建新行
    insert into Record(Category, ID) values
    ('禁用', @ID)
    -- 保存新的自增长流水号在存储过程中
    SET @RecordID = SCOPE_IDENTITY();


    -- 在禁用表创建禁用记录，日期为当前系统时间
    insert into Disable(ID, Employee_ID, Recordid, Disable_Reason, Disable_Date) values
    (@ID, @Employee_ID, @RecordID, @Disable_Reason, CONVERT(smalldatetime, GETDATE()))


    -- 更新会员卡内状态
    update MemberCard
    set status = 1
    where ID = @ID;

    -- 提交事务
    COMMIT TRANSACTION;
    RETURN;
END;


--SET NOCOUNT ON
--EXEC Disabling 'E230900002', '停用'