/*触发器 - 卡号金额不可修改*/
--创建触发器
CREATE TRIGGER CardDataSecurity ON MemberCard
--不完全更新 借用inserted表
INSTEAD OF UPDATE
AS
BEGIN
    --当更新卡号或金额时进入判断
    IF UPDATE(ID) OR UPDATE(Balance)
    BEGIN
        --回滚事务
        RAISERROR('不能修改卡号或是金额。', 16, 1);
        ROLLBACK TRANSACTION
    END
    --当更新其他项时
    ELSE
    BEGIN
       --复制inserted表内容实现更新
        UPDATE MemberCard
        SET Name=i.Name,
            PhoneNumber=i.PhoneNumber,
            Sex=i.Sex,
            Birth=i.Birth,
            Type = i.Type,
            Status = i.Status
        FROM inserted as i
        WHERE MemberCard.id=i.id
    END
END