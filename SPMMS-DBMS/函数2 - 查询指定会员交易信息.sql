/*查询指定会员交易信息*/
--创建函数 输入卡号 起始时间 结束时间
CREATE FUNCTION GetTransactionHistory (
    @ID varchar(10),
    @StartTime datetime = null,
    @EndTime datetime = null
)
--返回一张表 来自视图中符合要求的 起始时间默认1个月前 结束时间默认当前时间
RETURNS TABLE
AS
RETURN(
        select * from SummaryRecord where (卡号 = @ID) and (交易时间 between ISNULL(@StartTime, DATEADD(MONTH, -1, GETDATE())) and ISNULL(@EndTime, GETDATE()))
)