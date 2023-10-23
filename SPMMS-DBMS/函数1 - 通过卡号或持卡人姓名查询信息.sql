/*函数1 - 通过卡号或持卡人姓名查询信息*/
--创建函数 输入卡号(精准查询)或持卡人姓名(模糊查询)
CREATE FUNCTION SearchMember (
    @SearchTerm varchar(50)
)
RETURNS TABLE
AS
RETURN(
    select
        ID as 卡号,
    	Name as 姓名,
    	PhoneNumber as 手机号,
    	Sex as 性别,
    	Birth as 生日,
    	Type as 类型,
    	PName as 折扣,
    	Balance as 金额,
    	CASE
            WHEN Status=0 THEN '正常'
        	WHEN Status=1 THEN '禁用'
        END as 状态
    from MemberCard
    join ParameterTable on MemberCard.PID = ParameterTable.PID
    where id=@SearchTerm or name like '%'+@SearchTerm+'%'
)