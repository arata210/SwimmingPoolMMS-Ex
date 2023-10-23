/*存储过程 - 解禁会员卡*/
--创建存储过程 输入ID完成解禁
CREATE PROCEDURE CardResuming (
    @ID char(10)
)
AS
BEGIN
   --获取当前卡片状态
    DECLARE @Status varchar(6)
    SET @Status = (select Status from MemberCard where ID=@ID)
    IF @Status=1
        BEGIN
            update MemberCard set Status=0 where ID=@ID
            print @ID + '已解禁，可正常使用。'
        END
     COMMIT;
END