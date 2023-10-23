/*禁止更改消费记录*/
CREATE TRIGGER ProhibitChangingExpenseRecords ON Expense
FOR DELETE, UPDATE
AS
BEGIN
    --回滚事务
	RAISERROR('不能删除或更新消费记录。', 16, 1);
    ROLLBACK TRANSACTION
END