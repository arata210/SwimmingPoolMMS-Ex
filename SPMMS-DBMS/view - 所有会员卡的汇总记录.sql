/*所有会员卡的汇总记录*/

--LEFT JOIN实现存款、消费、禁用若为空不返回，连接记录表

SELECT 
    a.RecordID AS 单号,
    a.ID AS 卡号,
    a.Category AS 类别,
    CASE 
        WHEN a.Category = '存款' THEN CAST(b.DepositAmount AS varchar(10))
        WHEN a.Category = '消费' THEN CAST(c.ExpenseAmount AS varchar(10))
        WHEN a.Category = '禁用' THEN CAST(d.Disable_Reason AS varchar(10))
    END AS 交易内容,
    CASE 
        WHEN a.Category = '存款' THEN b.DepositDate
        WHEN a.Category = '消费' THEN c.ExpenseDate
        WHEN a.Category = '禁用' THEN d.Disable_Date
    END AS 交易时间
FROM Record AS a
LEFT JOIN Deposit AS b ON a.RecordID = b.RecordID
LEFT JOIN Expense AS c ON a.RecordID = c.RecordID
LEFT JOIN Disable AS d ON a.RecordID = d.RecordID

--SELECT * FROM SummaryRecord;