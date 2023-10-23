/*禁止更改存款记录*/
CREATE TRIGGER ProhibitChangingDepositRecords ON Deposit
FOR DELETE, UPDATE
AS
BEGIN
    --回滚事务
	RAISERROR('不能删除或更新存款记录。', 16, 1);
    ROLLBACK TRANSACTION
END