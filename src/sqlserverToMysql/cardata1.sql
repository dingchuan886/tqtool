USE [master]
GO
/****** Object:  Database [cardata]    Script Date: 2014/12/17 16:43:50 ******/
CREATE DATABASE [cardata]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'cardata_Data', FILENAME = N'D:\sqldata\cardata.mdf' , SIZE = 37716800KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'cardata_Log', FILENAME = N'D:\sqldata\cardata_log.ldf' , SIZE = 1536KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO
ALTER DATABASE [cardata] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [cardata].[dbo].[sp_fulltext_database] @action = 'disable'
end
GO
ALTER DATABASE [cardata] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cardata] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cardata] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cardata] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cardata] SET ARITHABORT OFF 
GO
ALTER DATABASE [cardata] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cardata] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [cardata] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [cardata] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cardata] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cardata] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cardata] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cardata] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cardata] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cardata] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cardata] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cardata] SET AUTO_UPDATE_STATISTICS_ASYNC ON 
GO
ALTER DATABASE [cardata] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cardata] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [cardata] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [cardata] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cardata] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [cardata] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [cardata] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [cardata] SET  MULTI_USER 
GO
ALTER DATABASE [cardata] SET PAGE_VERIFY TORN_PAGE_DETECTION  
GO
ALTER DATABASE [cardata] SET DB_CHAINING OFF 
GO
ALTER DATABASE [cardata] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [cardata] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'cardata', N'ON'
GO
USE [cardata]
GO
/****** Object:  User [readdata]    Script Date: 2014/12/17 16:43:51 ******/
CREATE USER [readdata] FOR LOGIN [readdata] WITH DEFAULT_SCHEMA=[db_datareader]
GO
/****** Object:  User [NT AUTHORITY\NETWORK SERVICE]    Script Date: 2014/12/17 16:43:51 ******/
CREATE USER [NT AUTHORITY\NETWORK SERVICE] FOR LOGIN [NT AUTHORITY\NETWORK SERVICE]
GO
/****** Object:  User [315che1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE USER [315che1] FOR LOGIN [315che1] WITH DEFAULT_SCHEMA=[db_datareader]
GO
/****** Object:  User [315che]    Script Date: 2014/12/17 16:43:51 ******/
CREATE USER [315che] FOR LOGIN [315che] WITH DEFAULT_SCHEMA=[db_owner]
GO
ALTER ROLE [db_datareader] ADD MEMBER [readdata]
GO
ALTER ROLE [db_datareader] ADD MEMBER [NT AUTHORITY\NETWORK SERVICE]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [NT AUTHORITY\NETWORK SERVICE]
GO
ALTER ROLE [db_owner] ADD MEMBER [315che1]
GO
ALTER ROLE [db_datareader] ADD MEMBER [315che1]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [315che1]
GO
ALTER ROLE [db_owner] ADD MEMBER [315che]
GO
ALTER ROLE [db_datareader] ADD MEMBER [315che]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [315che]
GO
/****** Object:  Schema [NT AUTHORITY\NETWORK SERVICE]    Script Date: 2014/12/17 16:43:51 ******/
CREATE SCHEMA [NT AUTHORITY\NETWORK SERVICE]
GO
/****** Object:  FullTextCatalog [keyhot]    Script Date: 2014/12/17 16:43:51 ******/
CREATE FULLTEXT CATALOG [keyhot]WITH ACCENT_SENSITIVITY = ON

GO
/****** Object:  FullTextCatalog [keyhot_all]    Script Date: 2014/12/17 16:43:51 ******/
CREATE FULLTEXT CATALOG [keyhot_all]WITH ACCENT_SENSITIVITY = ON

GO
/****** Object:  FullTextCatalog [new_news_all]    Script Date: 2014/12/17 16:43:51 ******/
CREATE FULLTEXT CATALOG [new_news_all]WITH ACCENT_SENSITIVITY = ON

GO
/****** Object:  PartitionFunction [ifts_comp_fragment_partition_function_11AA5024]    Script Date: 2014/12/17 16:43:51 ******/
CREATE PARTITION FUNCTION [ifts_comp_fragment_partition_function_11AA5024](varbinary(128)) AS RANGE LEFT FOR VALUES (0x00660033, 0x4E09, 0x54095229, 0x60A6, 0x70ED5356, 0x8F66591A957F)
GO
/****** Object:  PartitionScheme [ifts_comp_fragment_data_space_11AA5024]    Script Date: 2014/12/17 16:43:51 ******/
CREATE PARTITION SCHEME [ifts_comp_fragment_data_space_11AA5024] AS PARTITION [ifts_comp_fragment_partition_function_11AA5024] TO ([PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY], [PRIMARY])
GO
/****** Object:  StoredProcedure [dbo].[addyuyuebaoyang]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 CREATE  PROCEDURE [dbo].[addyuyuebaoyang] 
@eid int,
@userid int,
@realname nvarchar(200),
@phone nvarchar(50),
@carcode nvarchar(50),
@placeid int,
@qujian int,
@openid  nvarchar(50),
@fromsource int,
@licheng nvarchar(300),
@issenior int
as
declare
@tempid int 

set @tempid = (select top 1 id from dea_byyuyue where carcode=@carcode and placeid=@placeid and issenior=@issenior and isnull(isdelete,0)=0)
if @tempid > 0
begin
select -@tempid
end
else
begin



if @issenior = 0
begin
set @tempid=(select top 1 id from  dea_byschedule  where isdelete=0 and eid=@eid and id=@placeid and places>=1 )
    if isnull(@tempid,0)>0
	begin
	update dea_byschedule set places=places-1 where id=@tempid
    insert into dea_byyuyue (userid,realname,phone,carcode,eid,placeid,zhekou,qujian,openid,fromsource,licheng,issenior) 
	select top 1 @userid,@realname,@phone,@carcode,@eid,@placeid,zhekou,@qujian,@openid,@fromsource,@licheng,@issenior from dea_byschedule where isdelete=0 and id=@tempid
    select @@identity
	end
	else
	begin
	select -3
	end
end
else if @issenior = 1
begin
Begin transaction trans
begin try
set @tempid=(select top 1 id from  dea_byschedulesenior  where isdelete=0 and eid=@eid and id=@placeid and places>=1 )
    if isnull(@tempid,0)>0
	begin
	update dea_byschedulesenior set places=places-1 where id=@tempid
    insert into dea_byyuyue (userid,realname,phone,carcode,eid,placeid,zhekou,qujian,openid,fromsource,licheng,issenior) 
	select top 1 @userid,@realname,@phone,@carcode,@eid,@placeid,zhekou,@qujian,@openid,@fromsource,@licheng,@issenior from dea_byschedulesenior where isdelete=0 and id=@tempid
    select @@identity
	end
	else
	begin
	select -2
	end
	
commit transaction trans
end try
begin catch
rollback  transaction trans
select -1
end catch
end

Return
end


GO
/****** Object:  StoredProcedure [dbo].[dea_ClickCount]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[dea_ClickCount] AS

DECLARE @NCOUNT AS INT
SELECT @NCOUNT=count(1) FROM view_dea_ClickCount

IF(@NCOUNT=0)
BEGIN

INSERT INTO dea_dayclick (clicktype, deaid, adddate, clickcount)
SELECT clicktype, deaid, CONVERT(NVARCHAR(12),adddate,102), SUM(clickcount)
FROM dea_click WHERE adddate < CONVERT(NVARCHAR(12),GETDATE(),102)
GROUP BY clicktype, deaid, CONVERT(NVARCHAR(12),adddate,102)

DELETE dea_click WHERE adddate < CONVERT(NVARCHAR(12),GETDATE(),102)

INSERT INTO dea_backdayclick (clicktype, deaid, adddate, clickcount)
SELECT clicktype, deaid, adddate, clickcount
FROM dea_dayclick WHERE adddate < CONVERT(NVARCHAR(12), DATEADD(DD, - 31, GETDATE()), 102)

DELETE dea_dayclick WHERE adddate < CONVERT(NVARCHAR(12), DATEADD(DD, - 31, GETDATE()), 102)
--------------------------------------------------
END
GO
/****** Object:  StoredProcedure [dbo].[get_tableinfo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_tableinfo] AS 
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tablespaceinfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
create table tablespaceinfo --创建结果存储表 
 (nameinfo varchar(50) , 
 rowsinfo int , reserved varchar(20) , 
 datainfo varchar(20) , 
 index_size varchar(20) , 
 unused varchar(20) ) 


delete from tablespaceinfo --清空数据表 
declare @tablename varchar(255) --表名称 
declare @cmdsql varchar(500) 
DECLARE Info_cursor CURSOR FOR 
select o.name 
from dbo.sysobjects o where OBJECTPROPERTY(o.id, N'IsTable') = 1 
 and o.name not like N'#%%' order by o.name 
OPEN Info_cursor 
FETCH NEXT FROM Info_cursor INTO @tablename 
WHILE @@FETCH_STATUS = 0 
BEGIN 
 if exists (select * from dbo.sysobjects where id = object_id(@tablename) and OBJECTPROPERTY(id, N'IsUserTable') = 1) 
 execute sp_executesql 
 N'insert into tablespaceinfo exec sp_spaceused @tbname', 
 N'@tbname varchar(255)', 
 @tbname = @tablename 
 FETCH NEXT FROM Info_cursor 
 INTO @tablename 
END 

CLOSE Info_cursor 
DEALLOCATE Info_cursor 

GO
/****** Object:  StoredProcedure [dbo].[GetDealerClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDealerClick]
 @clickType INT,@deaid INT,@startdate DATETIME ,@enddate DATETIME 
AS
BEGIN
SELECT clickCount AS acount,adddate as [day] FROM 
(
	(SELECT SUM(clickCount) AS clickCount,CONVERT(NVARCHAR(12),adddate,102) AS adddate 
	FROM dea_click WHERE adddate BETWEEN @startdate AND @enddate AND clickType=@clickType AND deaid=@deaid AND @enddate > CONVERT(NVARCHAR(12),GETDATE(),102)
	 GROUP BY CONVERT(NVARCHAR(12),adddate,102))
	UNION
	(SELECT clickCount,adddate 
	FROM dea_dayclick WHERE adddate BETWEEN @startdate AND @enddate AND clicktype=@clickType AND deaid=@deaid AND @startdate < CONVERT(NVARCHAR(12),GETDATE(),102))
	UNION
	(SELECT clickCount,adddate 
	FROM dea_backdayclick WHERE adddate BETWEEN @startdate AND @enddate AND clicktype=@clickType AND deaid=@deaid AND @startdate < CONVERT(NVARCHAR(12),DATEADD(DD, - 31, GETDATE()),102))
) AS TEMPDATA
ORDER BY [day]

END
GO
/****** Object:  StoredProcedure [dbo].[p23]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[p23]

as
begin
select id,sid,title,content,pic,link,ctitle,clink,color,bold,adddate,sortId from sub_data where isDelete is null or isDelete=0 order by sortId desc,id desc
end
GO
/****** Object:  StoredProcedure [dbo].[p24]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[p24]

as
begin
select id,pname,place,stype from sub_content where isDelete is null or isDelete=0 order by id desc
end
GO
/****** Object:  StoredProcedure [dbo].[p25]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[p25]

as
begin
select * from pub_defad where isDelete is null or isDelete=0 order by id desc
end
GO
/****** Object:  StoredProcedure [dbo].[p26]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[p26]

as
begin
delete from pub_ad where id not in(select MAX(ID) from pub_ad where isshow=1 and (isDelete=0 or isDelete is null)  group by typeName,place,upload);insert into pub_adschedule (aid,sdate,edate) select ID,DATEADD(day, -1,GETDATE()),DATEADD(month, 1,GETDATE()) from pub_ad where ID not in (select aid from pub_adschedule);select a.*,b.sdate,b.edate from pub_ad a,pub_adschedule b where a.id=b.aid and  (isdelete IS NULL OR isdelete = 0) 
end
GO
/****** Object:  StoredProcedure [dbo].[setDeaNewsClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[setDeaNewsClick]
as
begin
declare @newsid int
declare @eid int
declare @date int
declare @ishot int
declare @isvip int
declare @num int
declare @randomstr nvarchar(100) set @randomstr='17294317131109050303'
declare @rmin int
declare @rmax int
declare @i int  --循环次数
declare @d int  -- 时间推移
declare @tempNum int ---临时变量
declare cursor1 cursor for         --定义游标cursor1
select  newsid,eid,DATEDIFF(DAY,publishdate,GETDATE()) as date,ishot,(case when exists (select 1 from dea_dealers where eid=dea_news.eid and paylevel=5) then 1 else 0 end) as isvip from dea_news
where ISNULL(isdelete,0)=0 and DATEDIFF(DAY,publishdate,GETDATE())<10               --使用游标的对象(跟据需要填入select文)
open cursor1                       --打开游标

fetch next from cursor1 into @newsid,@eid,@date,@ishot,@isvip  --将游标向下移1行，获取的数据放入之前定义的变量@id,@name中

while @@fetch_status=0           --判断是否成功获取数据
begin

set @num=(case when @ishot=1 then 1+ceiling(rand()*8) else 0 end)--热门推荐，随机（2，9）
if @date between 2 and 6 begin
		set @rmin=cast(SUBSTRING(@randomstr,(@date-1)*2+1,2) as int)
		set @rmax=cast(SUBSTRING(@randomstr,(@date+1)*2+1,2) as int)
		if(@rmin>@rmin)
		begin
		set @tempNum=@rmin
			set @rmin=@rmax
			set @rmax=@tempNum
		end
		set @num=@num+(@rmin-1)+ceiling(rand()*(@rmax-@rmin+1))
end
else begin
	set @num=@num+cast(SUBSTRING(@randomstr,@date*2+1,2) as int)
end
if @isvip=0 begin set @num=@num/2 end--非vip减半
update dea_news set [views]=[views]+@num where newsid=@newsid
insert into dea_click(clicktype,deaid,adddate,clickCount) values(1,@eid, DATEADD(MI, 10, DATEADD(HOUR, 8, GETDATE())),@num);
insert into dea_click(clicktype,deaid,adddate,clickCount) values(2,@eid, DATEADD(MI, 10, DATEADD(HOUR, 8, GETDATE())),@num)
fetch next from cursor1 into @newsid,@eid,@date,@ishot,@isvip  --将游标向下移1行
end

close cursor1                   --关闭游标
deallocate cursor1  
end

GO
/****** Object:  StoredProcedure [dbo].[sp_ClickCount]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ClickCount] AS              
SET DATEFIRST 5              
              
DECLARE @NCOUNT AS INT              
select @NCOUNT=count(*) FROM view_sp_ClickCount
              
IF(@NCOUNT=0)              
BEGIN              
              
INSERT INTO TDayClick              
      (type, tid, adddate, su, click)              
SELECT type, tid, ADDDATE, COUNT(*) AS SU, SUM(CNUM) AS CLICK              
FROM (SELECT type, tid, ip, ADDDATE, COUNT(*) AS CNUM              
        FROM (SELECT *, YEAR(addtime) * 10000 + MONTH(addtime) * 100 + DAY(addtime)               
                      AS ADDDATE              
                FROM TClick) DERIVEDTBL              
        GROUP BY type, tid, ip, ADDDATE) DERIVEDTBL              
WHERE (ADDDATE < YEAR(GETDATE()) * 10000 + MONTH(GETDATE())               
      * 100 + DAY(GETDATE()))              
GROUP BY type, tid, ADDDATE              
              
delete tclick where (YEAR(addtime) * 10000 + MONTH(addtime) * 100 + DAY(addtime)               
      < YEAR(GETDATE()) * 10000 + MONTH(GETDATE()) * 100 + DAY(GETDATE()))              
              
insert into tudayclick (adddate,adminid,su,click)               
SELECT adddate, id, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT a.*, c.id              
        FROM (SELECT *              
                FROM TDayClick              
                WHERE (type = 1) AND (adddate >              
                          (SELECT MAX(adddate)              
                         FROM tudayclick) OR              
                          (SELECT COUNT(*)              
                         FROM tudayclick) = 0)) a INNER JOIN              
              new_news b ON a.tid = b.id INNER JOIN              
              adm_user c ON b.addAdmin = c.username) DERIVEDTBL              
GROUP BY adddate, id              
              
INSERT INTO TUMonClick              
      (adminid, addmonth, su, click)              
SELECT adminid, addmonth, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT adminid, adddate / 100 AS addmonth, su, click              
        FROM TUDayClick) DERIVEDTBL              
WHERE (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND               
      (addmonth >              
          (SELECT MAX(addmonth)              
         FROM tumonclick)) OR              
      (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND              
          ((SELECT COUNT(*)              
          FROM tumonclick) = 0)              
GROUP BY adminid, addmonth              
              
INSERT INTO TUWekClick              
 (adminid,addweek,su,click)              
SELECT adminid, addweek, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT *, year(adate)*100+DATEPART(wk, adate) AS addweek              
        FROM (SELECT *, CAST(CAST(adddate / 10000 AS varchar)               
                      + '-' + CAST((adddate - 10000 * (adddate / 10000)) / 100 AS varchar)               
                      + '-' + CAST(adddate - 100 * (adddate / 100) AS varchar)               
                      AS smalldatetime) AS adate              
                FROM TUDayClick) DERIVEDTBL) DERIVEDTBL              
WHERE  (addweek < year(GETDATE())*100+DATEPART(wk, GETDATE())) AND               
 (addweek >              
          (SELECT MAX(addweek)              
         FROM tuwekclick) OR              
          ((SELECT COUNT(*)              
          FROM tuwekclick) = 0))               
GROUP BY adminid, addweek              
              
INSERT INTO TFUDayClick              
      (adddate, adminid, su, click)              
SELECT adddate, id, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT tid, adddate, su, click, id              
        FROM (SELECT a.*, YEAR(b.addDate) * 10000 + MONTH(b.addDate)               
                      * 100 + DAY(b.addDate) AS pubdate, c.id              
                FROM TDayClick a INNER JOIN              
                      new_news b ON a.tid = b.id INNER JOIN              
 adm_user c ON b.addadmin = c.username              
                WHERE (a.type = 1)) DERIVEDTBL              
        WHERE  (adddate >                          (SELECT MAX(adddate)              
                 FROM tfudayclick) OR              
                  (SELECT COUNT(*)              
                 FROM tfudayclick) = 0)) DERIVEDTBL              
GROUP BY adddate, id              
              
INSERT INTO TFUMonClick              
      (adminid, addmonth, su, click)              
SELECT adminid, addmonth, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT adminid, adddate / 100 AS addmonth, su, click              
        FROM TFUDayClick) DERIVEDTBL              
WHERE (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND               
      (addmonth >              
        (SELECT MAX(addmonth)              
         FROM TFUMonClick)) OR              
      (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND              
          ((SELECT COUNT(*)              
          FROM TFUMonClick) = 0)              
GROUP BY adminid, addmonth              
              
INSERT INTO TFUWekClick              
 (adminid,addweek,su,click)              
SELECT adminid, addweek, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT *, year(adate)*100+DATEPART(wk, adate) AS addweek              
        FROM (SELECT *, CAST(CAST(adddate / 10000 AS varchar)               
                      + '-' + CAST((adddate - 10000 * (adddate / 10000)) / 100 AS varchar)               
                      + '-' + CAST(adddate - 100 * (adddate / 100) AS varchar)               
                      AS smalldatetime) AS adate              
                FROM TFUDayClick) DERIVEDTBL) DERIVEDTBL              
WHERE  (addweek < year(GETDATE())*100+DATEPART(wk, GETDATE())) AND               
 (addweek >              
          (SELECT MAX(addweek)              
         FROM TFUWekClick) OR              
          ((SELECT COUNT(*)              
          FROM TFUWekClick) = 0))              
GROUP BY adminid, addweek              
              
insert into tuzdayclick (adddate,adminid,su,click)               
SELECT adddate, id, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT a.*, c.id              
        FROM (SELECT *              
                FROM TDayClick              
                WHERE (type = 6) AND (adddate >              
                          (SELECT MAX(adddate)              
                         FROM tuzdayclick) OR              
                          (SELECT COUNT(*)              
                         FROM tuzdayclick) = 0)) a INNER JOIN              
              zht_content b ON a.tid = b.id INNER JOIN              
              adm_user c ON b.addAdmin = c.username) DERIVEDTBL              
GROUP BY adddate, id              
              
INSERT INTO TUZMonClick              
      (adminid, addmonth, su, click)              
SELECT adminid, addmonth, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT adminid, adddate / 100 AS addmonth, su, click              
        FROM tuzdayclick) DERIVEDTBL              
WHERE (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND               
      (addmonth >              
          (SELECT MAX(addmonth)              
         FROM TUZMonClick)) OR              
      (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND              
          ((SELECT COUNT(*)              
          FROM TUZMonClick) = 0)              
GROUP BY adminid, addmonth              
              
INSERT INTO TUZWekClick              
 (adminid,addweek,su,click)              
SELECT adminid, addweek, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT *, year(adate)*100+DATEPART(wk, adate) AS addweek              
        FROM (SELECT *, CAST(CAST(adddate / 10000 AS varchar)               
                      + '-' + CAST((adddate - 10000 * (adddate / 10000)) / 100 AS varchar)               
                      + '-' + CAST(adddate - 100 * (adddate / 100) AS varchar)               
                      AS smalldatetime) AS adate              
                FROM tuzdayclick) DERIVEDTBL) DERIVEDTBL              
WHERE  (addweek < year(GETDATE())*100+DATEPART(wk, GETDATE())) AND               
 (addweek >              
          (SELECT MAX(addweek)              
         FROM TUZWekClick) OR              
          ((SELECT COUNT(*)              
          FROM TUZWekClick) = 0))              
GROUP BY adminid, addweek              
              
INSERT INTO TFUZDayClick              
      (adddate, adminid, su, click)              
SELECT adddate, id, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT tid, adddate, su, click, id              
        FROM (SELECT a.*, YEAR(b.AddDate) * 10000 + MONTH(b.AddDate)               
                      * 100 + DAY(b.AddDate) AS pubdate, c.id              
                FROM TDayClick a INNER JOIN              
                      zht_content b ON a.tid = b.id INNER JOIN              
                      adm_user c ON b.addadmin = c.username              
                WHERE (a.type = 6)) DERIVEDTBL              
        WHERE (adddate >              
                  (SELECT MAX(adddate)              
                 FROM TFUZDayClick) OR              
                  (SELECT COUNT(*)              
                 FROM TFUZDayClick) = 0)) DERIVEDTBL              
GROUP BY adddate, id              
              
INSERT INTO TFUZMonClick              
      (adminid, addmonth, su, click)              
SELECT adminid, addmonth, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT adminid, adddate / 100 AS addmonth, su, click              
        FROM TFUZDayClick) DERIVEDTBL              
WHERE (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND               
      (addmonth >              
          (SELECT MAX(addmonth)              
         FROM TFUZMonClick)) OR              
      (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND              
          ((SELECT COUNT(*)              
          FROM TFUZMonClick) = 0)              
GROUP BY adminid, addmonth              
              
INSERT INTO TFUZWekClick              
 (adminid,addweek,su,click)              
SELECT adminid, addweek, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT *, year(adate)*100+DATEPART(wk, adate) AS addweek              
        FROM (SELECT *, CAST(CAST(adddate / 10000 AS varchar)               
                      + '-' + CAST((adddate - 10000 * (adddate / 10000)) / 100 AS varchar)               
                      + '-' + CAST(adddate - 100 * (adddate / 100) AS varchar)               
                      AS smalldatetime) AS adate              
                FROM TFUZDayClick) DERIVEDTBL) DERIVEDTBL              
WHERE  (addweek < year(GETDATE())*100+DATEPART(wk, GETDATE())) AND               
 (addweek >              
          (SELECT MAX(addweek)              
         FROM TFUZWekClick) OR              
          ((SELECT COUNT(*)              
          FROM TFUZWekClick) = 0))              
GROUP BY adminid, addweek              
            
            
----------add on 2008-3-31---------------            
-----------------作用：统计品牌点击率--------------------            
insert into TCDayClick (adddate,BrandId,su,click)            
            
SELECT adddate, case when brandid is null then 0 else  brandid end as brandid, SUM(su) AS su, SUM(click) AS click  FROM             
 (SELECT a.*,             
(            
 select (case when fatherid=0 then 0 else substring(substring(path+CAST(catalogid AS varchar)+'.',4,len(path+CAST(catalogid AS varchar)+'.')),1,            
charindex('.',substring(path+CAST(catalogid AS varchar)+'.',4,len(path+CAST(catalogid AS varchar)+'.')))-1) end) as CarCataLogId   from car_catalog  where catalogid=a.tid            
) as brandid  FROM             
  (SELECT *  FROM TDayClick  WHERE (type = 16) AND ----从统计表里搜出新更新的数据            
   (adddate > (SELECT max(adddate)  FROM tcdayclick) OR  (SELECT COUNT(*)   FROM tcdayclick) = 0)            
  ) a ) DERIVEDTBL              
GROUP BY adddate, brandid            
          
            
INSERT INTO TCMonClick              
      (BrandId, addmonth, su, click)              
SELECT BrandId, addmonth, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT BrandId, adddate / 100 AS addmonth, su, click              
        FROM TCDayClick) DERIVEDTBL              
WHERE (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND               
      (addmonth >              
      (SELECT MAX(addmonth)              
         FROM TCMonClick)) OR              
      (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND              
          ((SELECT COUNT(*)              
          FROM TCMonClick) = 0)              
GROUP BY BrandId, addmonth              
              
INSERT INTO TCWekClick              
 (BrandId,addweek,su,click)              
SELECT BrandId, addweek, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT *, year(adate)*100+DATEPART(wk, adate) AS addweek              
        FROM (SELECT *, CAST(CAST(adddate / 10000 AS varchar)               
                      + '-' + CAST((adddate - 10000 * (adddate / 10000)) / 100 AS varchar)               
                      + '-' + CAST(adddate - 100 * (adddate / 100) AS varchar)               
                      AS smalldatetime) AS adate              
                FROM TCDayClick) DERIVEDTBL) DERIVEDTBL              
WHERE  (addweek < year(GETDATE())*100+DATEPART(wk, GETDATE())) AND               
 (addweek >              
          (SELECT MAX(addweek)              
         FROM TCWekClick) OR              
          ((SELECT COUNT(*)              
          FROM TCWekClick) = 0))        
GROUP BY BrandId, addweek            
--------------------------------------------------            
              
----------add on 2008-4-8---------------            
-----------------作用：统计频道点击率--------------------            
insert into TPDayClick (adddate,ChannelId,su,click)            
            
SELECT adddate, case when ChannelId is null then 0 else  ChannelId end as ChannelId, SUM(su) AS su, SUM(click) AS click  FROM             
 (SELECT a.*,a.tid as ChannelId  FROM             
  (SELECT *  FROM TDayClick  WHERE (type = 17) AND ----从统计表里搜出新更新的数据            
   (adddate > (SELECT max(adddate)  FROM TPdayclick) OR  (SELECT COUNT(*)   FROM TPdayclick) = 0)            
  ) a ) DERIVEDTBL              
GROUP BY adddate, ChannelId            
              
            
INSERT INTO TPMonClick              
      (ChannelId, addmonth, su, click)              
SELECT ChannelId, addmonth, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT ChannelId, adddate / 100 AS addmonth, su, click              
        FROM TPDayClick) DERIVEDTBL              
WHERE (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND               
      (addmonth >              
          (SELECT MAX(addmonth)              
         FROM TPMonClick)) OR              
      (addmonth < YEAR(GETDATE()) * 100 + MONTH(GETDATE())) AND              
          ((SELECT COUNT(*)              
          FROM TPMonClick) = 0)              
GROUP BY ChannelId, addmonth              
              
INSERT INTO TPWekClick              
 (ChannelId,addweek,su,click)              
SELECT ChannelId, addweek, SUM(su) AS su, SUM(click) AS click              
FROM (SELECT *, year(adate)*100+DATEPART(wk, adate) AS addweek              
        FROM (SELECT *, CAST(CAST(adddate / 10000 AS varchar)               
                      + '-' + CAST((adddate - 10000 * (adddate / 10000)) / 100 AS varchar)               
                      + '-' + CAST(adddate - 100 * (adddate / 100) AS varchar)               
                      AS smalldatetime) AS adate              
                FROM TPDayClick) DERIVEDTBL) DERIVEDTBL              
WHERE  (addweek < year(GETDATE())*100+DATEPART(wk, GETDATE())) AND               
 (addweek >              
          (SELECT MAX(addweek)              
         FROM TPWekClick) OR              
          ((SELECT COUNT(*)              
          FROM TPWekClick) = 0))         
GROUP BY ChannelId, addweek            
--------------------------------------------------            
        
              
END

GO
/****** Object:  StoredProcedure [dbo].[sp_SetIndexOnAddKey]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SetIndexOnAddKey]
 @keyId INT
AS
BEGIN
	DECLARE @key NVARCHAR(200)
	SET @key=(SELECT TOP 1 keywords FROM new_keylibrary WHERE id=@keyId)
	IF @key IS NOT NULL
	BEGIN
		DELETE FROM new_keywordindex where keyid=@keyId
		DECLARE @count INT SET @count=1
		DECLARE @newsid INT
		DECLARE @contentid INT
		DECLARE Info_cursor CURSOR FOR 
		SELECT id FROM new_news WHERE ISNULL(isdelete,0)=0 AND relink IS NULL ORDER BY id DESC
		OPEN Info_cursor 
		FETCH NEXT FROM Info_cursor INTO @newsid 
		WHILE @@FETCH_STATUS = 0 AND @count<=20
		BEGIN 
			SET @contentid=0
			SET @contentid=(SELECT TOP 1 id FROM new_content 
			WHERE newsContent LIKE '%'+@key+'%' AND ISNULL(isDelete,0)=0 AND newsId=@newsid ORDER BY id)
			IF ISNULL(@contentid,0)>=1
			BEGIN
				INSERT INTO new_keywordindex (keyid,newsid,contentid) VALUES (@keyId,@newsid,@contentid)
				SET @count=@count+1
			END
			FETCH NEXT FROM Info_cursor INTO @newsid
		END 
		CLOSE Info_cursor 
		DEALLOCATE Info_cursor
	END
END

GO
/****** Object:  UserDefinedFunction [dbo].[carCompare]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE Function [dbo].[carCompare](@chvA varchar(8000),@chvB varchar(8000))
returns decimal(10,2)
As
Begin
 declare @i int,@j int,@k decimal(10,2),@cc int,@same decimal(10,2),@result varchar(20)
 select @same=1
 If len(@chvA)>=len(@chvB)
  select @i=len(@chvA),@j=len(@chvB)
 Else
  select @i=len(@chvB),@j=len(@chvA)
 select @k=10000000
 select @cc=0
 while @cc<@j
  Begin
  If substring(@chvA,@cc,1)=substring(@chvB,@cc,1)
    select @same=@same+@k
  set @cc=@cc+1
  set @k=@k/10
  End
 select @result=(Cast(@same/@i as decimal(10,2)))
 return @result
End

GO
/****** Object:  UserDefinedFunction [dbo].[f_IP2Int]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   FUNCTION   [dbo].[f_IP2Int](   
@ip   char(15)   
)RETURNS   bigint   
AS   
BEGIN   
DECLARE   @re   bigint   
SET   @re=0   
SELECT   @re=@re+LEFT(@ip,CHARINDEX('.',@ip+'.')-1)*ID   
,@ip=STUFF(@ip,1,CHARINDEX('.',@ip+'.'),'')   
FROM(   
SELECT   ID=CAST(16777216   as   bigint)   
UNION   ALL   SELECT   65536   
UNION   ALL   SELECT   256   
UNION   ALL   SELECT   1)A   
RETURN(@re)   
END 
GO
/****** Object:  UserDefinedFunction [dbo].[f_LongTime2Day]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[f_LongTime2Day](@daysrc as datetime) returns datetime
as
begin
	return cast(cast(year(@daysrc) as varchar) + '-' + cast(month(@daysrc) as varchar) + '-' + cast(day(@daysrc) as varchar) as datetime);
end

GO
/****** Object:  UserDefinedFunction [dbo].[fnCompare]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
Create Function [dbo].[fnCompare](@chvA varchar(8000),@chvB varchar(8000))
returns decimal(10,2)
As
Begin
 declare @i int,@j int,@same decimal(10,2),@result varchar(20)
 select @same=0
 If len(@chvA)>=len(@chvB)
  select @i=len(@chvA),@j=len(@chvB)
 Else
  select @i=len(@chvB),@j=len(@chvA)
 while @j>0
  Begin
  If substring(@chvA,@j,1)=substring(@chvB,@j,1)
    select @same=@same+1
  set @j=@j-1
  End
 select @result=(Cast(@same*100/@i as decimal(10,2)))
 return @result
End

GO
/****** Object:  UserDefinedFunction [dbo].[fun_getPY]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fun_getPY](@str nvarchar(4000)) RETURNS nvarchar(4000) AS BEGIN DECLARE @word nchar(1),@PY nvarchar(4000),@i int SET @PY='' SET @i=1 WHILE (substring(@str,@i,1)<>'' OR @i<=len(@str)) BEGIN SET @word=substring(@str,@i,1) SET @PY=@PY+(CASE WHEN unicode(@word) BETWEEN 19968 AND 19968+20901 THEN (SELECT TOP 1 PY FROM ( SELECT 'A' AS PY,N'驁' AS word UNION ALL SELECT 'B',N'簿' UNION ALL SELECT 'C',N'錯' UNION ALL SELECT 'D',N'鵽' UNION ALL SELECT 'E',N'樲' UNION ALL SELECT 'F',N'鰒' UNION ALL SELECT 'G',N'腂' UNION ALL SELECT 'H',N'夻' UNION ALL SELECT 'J',N'攈' UNION ALL SELECT 'K',N'穒' UNION ALL SELECT 'L',N'鱳' UNION ALL SELECT 'M',N'旀' UNION ALL SELECT 'N',N'桛' UNION ALL SELECT 'O',N'漚' UNION ALL SELECT 'P',N'曝' UNION ALL SELECT 'Q',N'囕' UNION ALL SELECT 'R',N'鶸' UNION ALL SELECT 'S',N'蜶' UNION ALL SELECT 'T',N'籜' UNION ALL SELECT 'W',N'鶩' UNION ALL SELECT 'X',N'鑂' UNION ALL SELECT 'Y',N'韻' UNION ALL SELECT 'Z',N'咗' ) T WHERE word>=@word COLLATE Chinese_PRC_CS_AS_KS_WS ORDER BY PY ASC) ELSE @word END) SET @i=@i+1 END RETURN @PY END

GO
/****** Object:  Table [dbo].[ad_placedefad]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_placedefad](
	[id] [int] NOT NULL,
	[typeName] [nvarchar](50) NULL,
	[upload] [nvarchar](400) NULL,
	[frequency] [int] NULL,
	[showcount] [int] NULL,
	[type] [int] NULL,
	[place] [int] NULL,
	[isDelete] [int] NULL,
	[url] [nvarchar](200) NULL,
	[content] [ntext] NULL,
	[adwidth] [int] NULL,
	[adheight] [int] NULL,
	[isshow] [int] NULL,
	[upload2] [nvarchar](400) NULL,
	[url2] [nvarchar](50) NULL,
	[closeTime] [int] NULL,
	[sortId] [int] NULL,
	[isdefault] [int] NULL,
	[areakeyid] [int] NOT NULL,
 CONSTRAINT [PK_ad_placedefad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ad_popad]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_popad](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[adid] [int] NULL,
	[poptotaltimes] [int] NULL,
	[remaintimes] [int] NULL,
	[adstr] [nvarchar](4000) NULL,
	[isdelete] [tinyint] NULL,
	[jsstr] [nvarchar](4000) NULL,
	[scheduledDay] [datetime] NULL,
	[totalclick] [int] NOT NULL,
	[adtitle] [nvarchar](100) NULL,
 CONSTRAINT [PK_ad_popad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ad_popadcarinfo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_popadcarinfo](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[popaid] [int] NULL,
	[carid] [int] NULL,
	[isdelete] [tinyint] NULL,
 CONSTRAINT [PK_ad_popadcarinfo] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ad_popadrealtime]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_popadrealtime](
	[popid] [int] NOT NULL,
	[remaintimes] [int] NOT NULL,
	[refurl] [nvarchar](4000) NULL,
	[adurl] [nvarchar](4000) NULL,
	[hourtimes] [int] NOT NULL,
 CONSTRAINT [PK_ad_popadrealtime] PRIMARY KEY CLUSTERED 
(
	[popid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ad_popadschedule]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_popadschedule](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[popaid] [int] NULL,
	[sdate] [datetime] NULL,
	[edate] [datetime] NULL,
	[isdelete] [tinyint] NULL,
 CONSTRAINT [PK_ad_popadschedule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ad_serialAd]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_serialAd](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[modelstr] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_ad_serialAd] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ad_usingplace]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ad_usingplace](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[typeName] [nvarchar](50) NULL,
	[place] [int] NULL,
 CONSTRAINT [PK_ad_usingplace] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[adm_accesslog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adm_accesslog](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [nvarchar](200) NULL,
	[ip] [nvarchar](50) NULL,
	[logstat] [int] NULL,
	[logtime] [datetime] NULL,
 CONSTRAINT [PK_adm_accesslog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[adm_function]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adm_function](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[page] [nvarchar](500) NOT NULL,
	[cag] [nvarchar](50) NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[isdelete] [int] NOT NULL,
	[isusing] [int] NOT NULL,
 CONSTRAINT [PK_adm_function] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[adm_funManage]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adm_funManage](
	[funID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[funName] [nvarchar](50) NOT NULL,
	[funSQL] [nvarchar](500) NULL,
	[sortId] [int] NULL,
 CONSTRAINT [PK_adm_funManage] PRIMARY KEY CLUSTERED 
(
	[funID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[adm_hobby]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adm_hobby](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userid] [int] NOT NULL,
	[barcatalogtype] [int] NOT NULL,
	[barverify] [int] NOT NULL,
	[bartimearea] [int] NOT NULL,
	[isnews] [int] NOT NULL,
	[isreport] [int] NOT NULL,
	[baristotop] [int] NOT NULL,
	[barisindextop] [int] NOT NULL,
	[searchtype] [int] NOT NULL,
	[barauthorcookie] [bigint] NULL,
	[barauthorip] [bigint] NULL,
	[menulist] [nvarchar](4000) NULL,
	[bartitlecatalog] [nvarchar](400) NULL,
	[bartitle] [nvarchar](400) NULL,
	[barcontent] [nvarchar](400) NULL,
	[barauthor] [nvarchar](400) NULL,
	[sqlstr] [nvarchar](4000) NULL,
	[serialimage] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_adm_hobby] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[adm_log]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adm_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[adminid] [int] NULL,
	[type] [int] NULL,
	[typename] [nvarchar](200) NULL,
	[adid] [int] NULL,
	[operate] [int] NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_all_catalog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[adm_OwnBrand]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adm_OwnBrand](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[uid] [int] NOT NULL,
	[brandid] [int] NOT NULL,
	[areaid] [int] NOT NULL,
 CONSTRAINT [PK_adm_OwnBrand] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[adm_question]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adm_question](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Question] [nvarchar](50) NULL,
	[qKey] [nvarchar](50) NULL,
 CONSTRAINT [PK_adm_question] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[adm_user]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adm_user](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [nvarchar](100) NOT NULL,
	[password] [nvarchar](100) NOT NULL,
	[realname] [nvarchar](50) NOT NULL,
	[adddate] [datetime] NULL,
	[udate] [datetime] NULL,
	[areaid] [int] NOT NULL,
	[phone] [nvarchar](40) NULL,
 CONSTRAINT [PK_adm_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[adm_userpermission]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adm_userpermission](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[uid] [int] NOT NULL,
	[fid] [int] NOT NULL,
	[opertion] [int] NULL,
 CONSTRAINT [PK_adm_userpermission] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[app_click]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[app_click](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[appid] [nvarchar](100) NULL,
	[clienttype] [nvarchar](8) NULL,
	[source] [nvarchar](200) NULL,
	[ip] [nvarchar](16) NULL,
	[data] [nvarchar](100) NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_app_click] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[app_clientuid]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[app_clientuid](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[clientuid] [nvarchar](100) NOT NULL,
	[userid] [int] NOT NULL,
 CONSTRAINT [PK_app_clientuid] PRIMARY KEY CLUSTERED 
(
	[clientuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[are_catalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[are_catalog](
	[catalogId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogName] [nvarchar](200) NULL,
	[fatherId] [int] NULL,
	[byName] [nvarchar](200) NULL,
	[ClassId] [int] NULL,
	[isDelete] [int] NULL,
	[map] [nvarchar](200) NULL,
	[coords] [nvarchar](2000) NULL,
	[path] [nvarchar](500) NULL,
	[sortId] [int] NULL,
	[forumsid] [int] NOT NULL,
	[MapAreaId] [nvarchar](100) NULL,
	[LName] [char](4) NULL,
	[pathlevel] [int] NOT NULL,
	[isCity] [int] NOT NULL,
	[adareakeyid] [int] NOT NULL,
	[englingname] [nvarchar](50) NULL,
 CONSTRAINT [PK_are_catalog] PRIMARY KEY CLUSTERED 
(
	[catalogId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[are_distances]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[are_distances](
	[id] [int] NOT NULL,
	[areaid1] [int] NULL,
	[areaid2] [int] NULL,
	[distances] [float] NULL,
 CONSTRAINT [PK_are_distances] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[are_mobile]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[are_mobile](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[mobstart] [bigint] NULL,
	[mobend] [bigint] NULL,
	[area1] [nvarchar](50) NULL,
 CONSTRAINT [PK_are_mobile] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ath_carcatalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ath_carcatalog](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogid] [int] NOT NULL,
	[fatherid] [int] NOT NULL,
	[pathlevel] [int] NOT NULL,
	[catalogname] [nvarchar](200) NOT NULL,
	[lastupdate] [datetime] NULL,
	[ispropchanged] [int] NOT NULL,
	[carpropertiesstr] [ntext] NULL,
 CONSTRAINT [PK_ath_carcatalog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ath_carproperties]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ath_carproperties](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[fatherid] [int] NOT NULL,
	[p1] [nvarchar](200) NULL,
	[p2] [nvarchar](200) NULL,
	[p3] [nvarchar](200) NULL,
	[p4] [nvarchar](200) NULL,
	[p5] [nvarchar](200) NULL,
	[p6] [nvarchar](200) NULL,
	[p7] [nvarchar](200) NULL,
	[p8] [nvarchar](200) NULL,
	[p9] [nvarchar](200) NULL,
	[p10] [nvarchar](200) NULL,
	[p11] [nvarchar](200) NULL,
	[p12] [nvarchar](200) NULL,
	[p13] [nvarchar](200) NULL,
	[p14] [nvarchar](200) NULL,
	[p15] [nvarchar](200) NULL,
	[p16] [nvarchar](200) NULL,
	[p17] [nvarchar](200) NULL,
	[p18] [nvarchar](200) NULL,
	[p19] [nvarchar](200) NULL,
	[p20] [nvarchar](200) NULL,
	[p21] [nvarchar](200) NULL,
	[p22] [nvarchar](200) NULL,
	[p23] [nvarchar](200) NULL,
	[p24] [nvarchar](200) NULL,
	[p25] [nvarchar](200) NULL,
	[p26] [nvarchar](200) NULL,
	[p27] [nvarchar](200) NULL,
	[p28] [nvarchar](200) NULL,
	[p29] [nvarchar](200) NULL,
	[p30] [nvarchar](200) NULL,
	[p31] [nvarchar](200) NULL,
	[p32] [nvarchar](200) NULL,
	[p33] [nvarchar](200) NULL,
	[p34] [nvarchar](200) NULL,
	[p35] [nvarchar](200) NULL,
	[p36] [nvarchar](200) NULL,
	[p37] [nvarchar](200) NULL,
	[p38] [nvarchar](200) NULL,
	[p39] [nvarchar](200) NULL,
	[p40] [nvarchar](200) NULL,
	[p41] [nvarchar](200) NULL,
	[p42] [nvarchar](200) NULL,
	[p43] [nvarchar](200) NULL,
	[p44] [nvarchar](200) NULL,
	[p45] [nvarchar](200) NULL,
	[p46] [nvarchar](200) NULL,
	[p47] [nvarchar](200) NULL,
	[p48] [nvarchar](200) NULL,
	[p49] [nvarchar](200) NULL,
	[p50] [nvarchar](200) NULL,
	[p51] [nvarchar](200) NULL,
	[p52] [nvarchar](200) NULL,
	[p53] [nvarchar](200) NULL,
	[p54] [nvarchar](200) NULL,
	[p55] [nvarchar](200) NULL,
	[p56] [nvarchar](200) NULL,
	[p57] [nvarchar](200) NULL,
	[p58] [nvarchar](200) NULL,
	[p59] [nvarchar](200) NULL,
	[p60] [nvarchar](200) NULL,
	[p61] [nvarchar](200) NULL,
	[p62] [nvarchar](200) NULL,
	[p63] [nvarchar](200) NULL,
	[p64] [nvarchar](200) NULL,
	[p65] [nvarchar](200) NULL,
	[p66] [nvarchar](200) NULL,
	[p67] [nvarchar](200) NULL,
	[p68] [nvarchar](200) NULL,
	[p69] [nvarchar](200) NULL,
	[p70] [nvarchar](200) NULL,
	[p71] [nvarchar](200) NULL,
	[p72] [nvarchar](200) NULL,
	[p73] [nvarchar](200) NULL,
	[p74] [nvarchar](200) NULL,
	[p75] [nvarchar](200) NULL,
	[p76] [nvarchar](200) NULL,
	[p77] [nvarchar](200) NULL,
	[p78] [nvarchar](200) NULL,
	[p79] [nvarchar](200) NULL,
	[p80] [nvarchar](200) NULL,
	[p81] [nvarchar](200) NULL,
	[p82] [nvarchar](200) NULL,
	[p83] [nvarchar](200) NULL,
	[p84] [nvarchar](200) NULL,
	[p85] [nvarchar](200) NULL,
	[p86] [nvarchar](200) NULL,
	[p87] [nvarchar](200) NULL,
	[p88] [nvarchar](200) NULL,
	[p89] [nvarchar](200) NULL,
	[p90] [nvarchar](200) NULL,
	[p91] [nvarchar](200) NULL,
	[p92] [nvarchar](200) NULL,
	[p93] [nvarchar](200) NULL,
	[p94] [nvarchar](200) NULL,
	[p95] [nvarchar](200) NULL,
	[p96] [nvarchar](200) NULL,
	[p97] [nvarchar](200) NULL,
	[p98] [nvarchar](200) NULL,
	[p99] [nvarchar](200) NULL,
	[p100] [nvarchar](200) NULL,
	[p101] [nvarchar](200) NULL,
	[p102] [nvarchar](200) NULL,
	[p103] [nvarchar](200) NULL,
	[p104] [nvarchar](200) NULL,
	[p105] [nvarchar](200) NULL,
	[p106] [nvarchar](200) NULL,
	[p107] [nvarchar](200) NULL,
	[p108] [nvarchar](200) NULL,
	[p109] [nvarchar](200) NULL,
	[p110] [nvarchar](200) NULL,
	[p111] [nvarchar](200) NULL,
	[p112] [nvarchar](200) NULL,
	[p113] [nvarchar](200) NULL,
	[p114] [nvarchar](200) NULL,
	[p115] [nvarchar](200) NULL,
	[p116] [nvarchar](200) NULL,
	[p117] [nvarchar](200) NULL,
	[p118] [nvarchar](200) NULL,
	[p119] [nvarchar](200) NULL,
	[p120] [nvarchar](200) NULL,
	[p121] [nvarchar](200) NULL,
	[p122] [nvarchar](200) NULL,
	[p123] [nvarchar](200) NULL,
	[p124] [nvarchar](200) NULL,
	[p125] [nvarchar](200) NULL,
	[p126] [nvarchar](200) NULL,
	[p127] [nvarchar](200) NULL,
	[p128] [nvarchar](200) NULL,
	[p129] [nvarchar](200) NULL,
	[p130] [nvarchar](200) NULL,
	[p131] [nvarchar](200) NULL,
	[p132] [nvarchar](200) NULL,
	[p133] [nvarchar](200) NULL,
	[p134] [nvarchar](200) NULL,
	[p135] [nvarchar](200) NULL,
	[p136] [nvarchar](200) NULL,
	[p137] [nvarchar](200) NULL,
	[p138] [nvarchar](200) NULL,
	[p139] [nvarchar](200) NULL,
	[p140] [nvarchar](200) NULL,
	[p141] [nvarchar](200) NULL,
	[p142] [nvarchar](200) NULL,
	[p143] [nvarchar](200) NULL,
	[p144] [nvarchar](200) NULL,
	[p145] [nvarchar](200) NULL,
	[p146] [nvarchar](200) NULL,
	[p147] [nvarchar](200) NULL,
	[p148] [nvarchar](200) NULL,
	[p149] [nvarchar](200) NULL,
	[p150] [nvarchar](200) NULL,
	[p151] [nvarchar](200) NULL,
	[p152] [nvarchar](200) NULL,
	[p153] [nvarchar](200) NULL,
	[p154] [nvarchar](200) NULL,
	[p155] [nvarchar](200) NULL,
	[p156] [nvarchar](200) NULL,
	[p157] [nvarchar](200) NULL,
	[p158] [nvarchar](200) NULL,
	[p159] [nvarchar](200) NULL,
	[p160] [nvarchar](200) NULL,
	[p161] [nvarchar](200) NULL,
	[p162] [nvarchar](200) NULL,
	[p163] [nvarchar](200) NULL,
	[p164] [nvarchar](200) NULL,
	[p165] [nvarchar](200) NULL,
	[p166] [nvarchar](200) NULL,
	[p167] [nvarchar](200) NULL,
	[p168] [nvarchar](200) NULL,
	[p169] [nvarchar](200) NULL,
	[p170] [nvarchar](200) NULL,
	[p171] [nvarchar](200) NULL,
	[p172] [nvarchar](200) NULL,
	[p173] [nvarchar](200) NULL,
	[p174] [nvarchar](200) NULL,
	[p175] [nvarchar](200) NULL,
	[p176] [nvarchar](200) NULL,
	[p177] [nvarchar](200) NULL,
	[p178] [nvarchar](200) NULL,
	[p179] [nvarchar](200) NULL,
	[p180] [nvarchar](200) NULL,
	[p181] [nvarchar](200) NULL,
	[p182] [nvarchar](200) NULL,
	[p183] [nvarchar](200) NULL,
	[p184] [nvarchar](200) NULL,
	[p185] [nvarchar](200) NULL,
	[p186] [nvarchar](200) NULL,
	[p187] [nvarchar](200) NULL,
	[p188] [nvarchar](200) NULL,
	[p189] [nvarchar](200) NULL,
	[p190] [nvarchar](200) NULL,
	[p191] [nvarchar](200) NULL,
	[p192] [nvarchar](200) NULL,
	[p193] [nvarchar](200) NULL,
	[p194] [nvarchar](200) NULL,
	[p195] [nvarchar](200) NULL,
	[p196] [nvarchar](200) NULL,
	[p197] [nvarchar](200) NULL,
	[p198] [nvarchar](200) NULL,
	[p199] [nvarchar](200) NULL,
	[p200] [nvarchar](200) NULL,
	[p201] [nvarchar](200) NULL,
	[p202] [nvarchar](200) NULL,
	[p203] [nvarchar](200) NULL,
	[p204] [nvarchar](200) NULL,
	[p205] [nvarchar](200) NULL,
	[p206] [nvarchar](200) NULL,
	[p207] [nvarchar](200) NULL,
	[p208] [nvarchar](200) NULL,
	[p209] [nvarchar](200) NULL,
	[p210] [nvarchar](200) NULL,
	[p211] [nvarchar](200) NULL,
	[p212] [nvarchar](200) NULL,
	[p213] [nvarchar](200) NULL,
	[p214] [nvarchar](200) NULL,
	[p215] [nvarchar](200) NULL,
	[p216] [nvarchar](200) NULL,
	[p217] [nvarchar](200) NULL,
	[p218] [nvarchar](200) NULL,
	[p219] [nvarchar](200) NULL,
	[p220] [nvarchar](200) NULL,
	[p221] [nvarchar](200) NULL,
	[p222] [nvarchar](200) NULL,
	[p223] [nvarchar](200) NULL,
	[p224] [nvarchar](200) NULL,
	[p225] [nvarchar](200) NULL,
	[p226] [nvarchar](200) NULL,
	[p227] [nvarchar](200) NULL,
	[p228] [nvarchar](200) NULL,
	[p229] [nvarchar](200) NULL,
	[p230] [nvarchar](200) NULL,
	[p231] [nvarchar](200) NULL,
	[p232] [nvarchar](200) NULL,
	[p233] [nvarchar](200) NULL,
	[p234] [nvarchar](200) NULL,
	[p235] [nvarchar](200) NULL,
	[p236] [nvarchar](200) NULL,
	[p237] [nvarchar](200) NULL,
	[p238] [nvarchar](200) NULL,
	[p239] [nvarchar](200) NULL,
	[p240] [nvarchar](200) NULL,
	[p241] [nvarchar](200) NULL,
	[p242] [nvarchar](200) NULL,
	[p243] [nvarchar](200) NULL,
	[p244] [nvarchar](200) NULL,
	[p245] [nvarchar](200) NULL,
	[p246] [nvarchar](200) NULL,
	[p247] [nvarchar](200) NULL,
	[p248] [nvarchar](200) NULL,
	[p249] [nvarchar](200) NULL,
	[p250] [nvarchar](200) NULL,
	[p251] [nvarchar](200) NULL,
	[p252] [nvarchar](200) NULL,
	[p253] [nvarchar](200) NULL,
	[p254] [nvarchar](200) NULL,
	[p255] [nvarchar](200) NULL,
	[p256] [nvarchar](200) NULL,
	[p257] [nvarchar](200) NULL,
	[p258] [nvarchar](200) NULL,
	[p259] [nvarchar](200) NULL,
	[p260] [nvarchar](200) NULL,
	[p261] [nvarchar](200) NULL,
	[p262] [nvarchar](200) NULL,
	[p263] [nvarchar](200) NULL,
	[p264] [nvarchar](200) NULL,
	[p265] [nvarchar](200) NULL,
	[p266] [nvarchar](200) NULL,
	[p267] [nvarchar](200) NULL,
	[p268] [nvarchar](200) NULL,
	[p269] [nvarchar](200) NULL,
	[p270] [nvarchar](200) NULL,
	[p271] [nvarchar](200) NULL,
	[p272] [nvarchar](200) NULL,
	[p273] [nvarchar](200) NULL,
	[p274] [nvarchar](200) NULL,
	[p275] [nvarchar](200) NULL,
	[p276] [nvarchar](200) NULL,
	[p277] [nvarchar](200) NULL,
	[p278] [nvarchar](200) NULL,
	[p279] [nvarchar](200) NULL,
	[p280] [nvarchar](200) NULL,
	[p281] [nvarchar](200) NULL,
	[p282] [nvarchar](200) NULL,
	[p283] [nvarchar](200) NULL,
	[p284] [nvarchar](200) NULL,
	[p285] [nvarchar](200) NULL,
	[p286] [nvarchar](200) NULL,
	[p287] [nvarchar](200) NULL,
	[p288] [nvarchar](200) NULL,
	[p289] [nvarchar](200) NULL,
	[p290] [nvarchar](200) NULL,
	[p291] [nvarchar](200) NULL,
	[p292] [nvarchar](200) NULL,
	[p293] [nvarchar](200) NULL,
	[p294] [nvarchar](200) NULL,
	[p295] [nvarchar](200) NULL,
	[p296] [nvarchar](200) NULL,
	[p297] [nvarchar](200) NULL,
	[p298] [nvarchar](200) NULL,
	[p299] [nvarchar](200) NULL,
	[p300] [nvarchar](200) NULL,
 CONSTRAINT [PK_ath_carpropeties] PRIMARY KEY CLUSTERED 
(
	[carid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ath_newcarcatalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ath_newcarcatalog](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogid] [int] NULL,
	[fatherid] [int] NULL,
	[catalogname] [nvarchar](200) NULL,
	[baoid] [int] NULL,
 CONSTRAINT [PK_ath_newcarcatalog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ath_properties]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ath_properties](
	[id] [int] NOT NULL,
	[paramid] [int] NOT NULL,
	[paramname] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_ath_properties] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ath_updatedata]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ath_updatedata](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carcatalogid] [int] NOT NULL,
	[oldfatherid] [int] NOT NULL,
	[newfatherid] [int] NOT NULL,
	[optiontype] [int] NOT NULL,
	[dealstat] [int] NOT NULL,
	[pathlevel] [int] NOT NULL,
	[oldname] [nvarchar](200) NULL,
	[newname] [nvarchar](200) NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_ath_updatedata] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aut_content]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aut_content](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[pname] [nvarchar](50) NOT NULL,
	[place] [nvarchar](50) NOT NULL,
	[isdelete] [int] NULL,
	[lastvisittime] [datetime] NULL,
 CONSTRAINT [PK_aut_content_1] PRIMARY KEY CLUSTERED 
(
	[pname] ASC,
	[place] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aut_data]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aut_data](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[sid] [int] NOT NULL,
	[place] [int] NOT NULL,
	[title] [nvarchar](2000) NULL,
	[content] [ntext] NULL,
	[pic] [nvarchar](500) NULL,
	[link] [nvarchar](400) NULL,
	[ctitle] [nvarchar](2000) NULL,
	[clink] [nvarchar](400) NULL,
	[color] [nvarchar](50) NULL,
	[bold] [int] NULL,
	[adddate] [datetime] NULL,
	[isdelete] [int] NULL,
	[sortId] [int] NULL,
	[isad] [tinyint] NOT NULL,
 CONSTRAINT [PK_aut_data_1] PRIMARY KEY CLUSTERED 
(
	[sid] ASC,
	[place] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[aut_usingcontent]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aut_usingcontent](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[usingid] [int] NULL,
 CONSTRAINT [PK_aut_usingcontent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bao_main]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bao_main](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[sdesc] [nvarchar](500) NULL,
	[url] [nvarchar](500) NULL,
	[ohtml] [ntext] NULL,
 CONSTRAINT [PK_bao_main] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bao_project]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bao_project](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[pname] [nvarchar](100) NULL,
 CONSTRAINT [PK_bao_project] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bao_projectprice]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bao_projectprice](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[pid] [int] NULL,
	[baoid] [int] NULL,
	[price] [int] NULL,
 CONSTRAINT [PK_bao_projectprice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bao_record]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bao_record](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[baoid] [int] NULL,
	[pid] [int] NULL,
	[distance] [int] NULL,
	[monthcyc] [int] NULL,
	[btype] [int] NULL,
 CONSTRAINT [PK_bao_record] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_ActiveField]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_ActiveField](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[fieldType] [int] NOT NULL,
	[isRecruitTopic] [int] NOT NULL,
	[isJoinTopic] [int] NOT NULL,
	[neccessary] [int] NULL,
	[isHidden] [int] NULL,
 CONSTRAINT [PK_ma_ActiveField] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_Actives]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_Actives](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[topicid] [int] NOT NULL,
	[ActiveFieldIds] [nvarchar](200) NOT NULL,
	[begintime] [datetime] NOT NULL,
	[endtime] [datetime] NULL,
	[operator] [nvarchar](50) NULL,
 CONSTRAINT [PK_ma_Actives] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_ActivesUser]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_ActivesUser](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[topicid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[ActiveFieldId] [int] NOT NULL,
	[content] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_ma_ActivesUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_Adminipaccess]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_Adminipaccess](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ip] [nvarchar](200) NOT NULL,
	[EffectiveDate] [datetime] NULL,
 CONSTRAINT [PK_bbs_Adminipaccess] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_AppCarSerialNum]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_AppCarSerialNum](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [nvarchar](200) NOT NULL,
	[type] [int] NOT NULL,
	[serialnum] [nvarchar](50) NULL,
	[truename] [nvarchar](200) NULL,
	[gender] [int] NULL,
	[mobile] [nvarchar](50) NULL,
	[telephone] [nvarchar](50) NULL,
	[cartype] [nvarchar](200) NULL,
	[caroutput] [nvarchar](200) NULL,
	[color] [nvarchar](50) NULL,
	[carmark] [nvarchar](50) NULL,
	[buydate] [datetime] NULL,
	[address] [nvarchar](200) NULL,
	[appdate] [datetime] NULL,
	[isdelete] [int] NULL,
	[nickname] [nvarchar](200) NULL,
	[mailbox] [nvarchar](100) NULL,
	[recommendedby] [nvarchar](100) NULL,
	[code] [int] NOT NULL,
	[recodedate] [datetime] NULL,
 CONSTRAINT [PK_bbs_AppCarSerialNum] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_AppCarSignNumSet]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_AppCarSignNumSet](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[startnum] [int] NOT NULL,
	[endnum] [int] NOT NULL,
	[isdelete] [bigint] NOT NULL,
	[adddate] [datetime] NOT NULL,
 CONSTRAINT [PK_bbs_AppCarSignNumSet] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_GetMphoneName]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_GetMphoneName](
	[mpGetID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[getState] [tinyint] NOT NULL,
	[applyTime] [datetime] NOT NULL,
	[dealTime] [datetime] NULL,
 CONSTRAINT [PK__GetMphoneName__42ACE4D4] PRIMARY KEY CLUSTERED 
(
	[mpGetID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_keyuser]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_keyuser](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [nvarchar](200) NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_bbs_keyuser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_MenPaiCatalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_MenPaiCatalog](
	[M_ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[M_Name] [nvarchar](50) NOT NULL,
	[M_Descript] [nvarchar](500) NOT NULL,
	[M_Flat] [nvarchar](50) NOT NULL,
	[M_Creater] [nvarchar](50) NOT NULL,
	[M_CreateTime] [int] NOT NULL,
	[M_CreateClass] [tinyint] NOT NULL,
	[M_AppState] [tinyint] NOT NULL,
 CONSTRAINT [PK__MenPaiCatalog__28ED12D1] PRIMARY KEY CLUSTERED 
(
	[M_Name] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_MobilePhone]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_MobilePhone](
	[mphoneID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[mphoneNumber] [nvarchar](50) NOT NULL,
	[mpGetCid] [int] NOT NULL,
	[JoinTime] [datetime] NOT NULL,
	[confrimTime] [datetime] NULL,
 CONSTRAINT [PK__MobilePhone__6D9742D9] PRIMARY KEY CLUSTERED 
(
	[mphoneNumber] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_NickNameHistory]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_NickNameHistory](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userid] [int] NULL,
	[nickname] [nvarchar](200) NULL,
	[modifytime] [datetime] NULL,
 CONSTRAINT [PK_bbs_NickNameHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_PropUseHistory]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_PropUseHistory](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[topicid] [int] NOT NULL,
	[postid] [int] NOT NULL,
	[propid] [int] NOT NULL,
	[usetime] [datetime] NOT NULL,
	[userid] [int] NOT NULL,
	[nickname] [nvarchar](200) NULL,
	[AccepterId] [int] NULL,
	[AccepterNickName] [nvarchar](200) NULL,
 CONSTRAINT [PK_ma_PropUseHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_PropUseHistory_bak]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_PropUseHistory_bak](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[topicid] [int] NOT NULL,
	[postid] [int] NOT NULL,
	[propid] [int] NOT NULL,
	[usetime] [datetime] NOT NULL,
	[userid] [int] NOT NULL,
	[nickname] [nvarchar](200) NULL,
	[AccepterId] [int] NULL,
	[AccepterNickName] [nvarchar](200) NULL,
 CONSTRAINT [PK_bbs_PropUseHistory_bak] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_TopicScore]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_TopicScore](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[tid] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[score] [int] NOT NULL,
 CONSTRAINT [PK_bbs_TopicScore] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_user]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_user](
	[UserID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[nation] [nvarchar](50) NULL,
	[cardNum] [nvarchar](50) NULL,
	[animalYear] [nvarchar](50) NULL,
	[starInfor] [nvarchar](50) NULL,
	[height] [int] NULL,
	[weight] [int] NULL,
	[bloodType] [nvarchar](50) NULL,
	[selfIntroduce] [nvarchar](150) NULL,
	[phone] [nvarchar](20) NULL,
	[mobilephone] [nvarchar](20) NULL,
	[address] [nvarchar](50) NULL,
	[postNums] [nvarchar](10) NULL,
	[userPhoto] [ntext] NULL,
	[clickNum] [int] NULL,
	[voteNum] [int] NULL,
	[regDate] [datetime] NULL,
	[isdelete] [int] NULL,
	[authentication] [int] NULL,
	[isJoinBaobei] [int] NULL,
	[sanWei] [nvarchar](20) NULL,
	[teChang] [nvarchar](50) NULL,
	[rsGeyan] [ntext] NULL,
	[chexin] [nvarchar](20) NULL,
	[sadevent] [ntext] NULL,
	[happyevent] [ntext] NULL,
	[myLover] [ntext] NULL,
	[myflove] [ntext] NULL,
	[M_Name] [nvarchar](50) NULL,
	[M_Career] [nvarchar](50) NULL,
	[M_AppState] [tinyint] NULL,
	[M_JoinTime] [datetime] NULL,
	[sortId] [int] NULL,
	[carSerialNum] [int] NOT NULL,
	[areaNum] [int] NOT NULL,
	[carmodelid] [int] NOT NULL,
 CONSTRAINT [PK_s_user] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bbs_visitRecord]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bbs_visitRecord](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[hostuserid] [int] NOT NULL,
	[visiterid] [int] NOT NULL,
 CONSTRAINT [PK_bbs_visitRecord] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cah_helper]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cah_helper](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[cachename] [nvarchar](max) NOT NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_cah_helper] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cah_manage]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cah_manage](
	[cachename] [nvarchar](max) NOT NULL,
	[adddate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_AttentionSerial]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_AttentionSerial](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid1] [int] NOT NULL,
	[carid2] [int] NOT NULL,
 CONSTRAINT [PK_car_AttentionSerial] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_autohomeprop]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_autohomeprop](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NULL,
	[autohomecarid] [int] NULL,
	[bid] [int] NULL,
	[p1] [nvarchar](200) NULL,
	[p2] [nvarchar](200) NULL,
	[p3] [nvarchar](200) NULL,
	[p4] [nvarchar](200) NULL,
	[p5] [nvarchar](200) NULL,
	[p6] [nvarchar](200) NULL,
	[p7] [nvarchar](200) NULL,
	[p8] [nvarchar](200) NULL,
	[p9] [nvarchar](200) NULL,
	[p10] [nvarchar](200) NULL,
	[p11] [nvarchar](200) NULL,
	[p12] [nvarchar](200) NULL,
	[p13] [nvarchar](200) NULL,
	[p14] [nvarchar](200) NULL,
	[p15] [nvarchar](200) NULL,
	[p16] [nvarchar](200) NULL,
	[p17] [nvarchar](200) NULL,
	[p18] [nvarchar](200) NULL,
	[p19] [nvarchar](200) NULL,
	[p20] [nvarchar](200) NULL,
	[p21] [nvarchar](200) NULL,
	[p22] [nvarchar](200) NULL,
	[p23] [nvarchar](200) NULL,
	[p24] [nvarchar](200) NULL,
	[p25] [nvarchar](200) NULL,
	[p26] [nvarchar](200) NULL,
	[p27] [nvarchar](200) NULL,
	[p28] [nvarchar](200) NULL,
	[p29] [nvarchar](200) NULL,
	[p30] [nvarchar](200) NULL,
	[p31] [nvarchar](200) NULL,
	[p32] [nvarchar](200) NULL,
	[p33] [nvarchar](200) NULL,
	[p34] [nvarchar](200) NULL,
	[p35] [nvarchar](200) NULL,
	[p36] [nvarchar](200) NULL,
	[p37] [nvarchar](200) NULL,
	[p38] [nvarchar](200) NULL,
	[p39] [nvarchar](200) NULL,
	[p40] [nvarchar](200) NULL,
	[p41] [nvarchar](200) NULL,
	[p42] [nvarchar](200) NULL,
	[p43] [nvarchar](200) NULL,
	[p44] [nvarchar](200) NULL,
	[p45] [nvarchar](200) NULL,
	[p46] [nvarchar](200) NULL,
	[p47] [nvarchar](200) NULL,
	[p48] [nvarchar](200) NULL,
	[p49] [nvarchar](200) NULL,
	[p50] [nvarchar](200) NULL,
	[p51] [nvarchar](200) NULL,
	[p52] [nvarchar](200) NULL,
	[p53] [nvarchar](200) NULL,
	[p54] [nvarchar](200) NULL,
	[p55] [nvarchar](200) NULL,
	[p56] [nvarchar](200) NULL,
	[p57] [nvarchar](200) NULL,
	[p58] [nvarchar](200) NULL,
	[p59] [nvarchar](200) NULL,
	[p60] [nvarchar](200) NULL,
	[p61] [nvarchar](200) NULL,
	[p62] [nvarchar](200) NULL,
	[p63] [nvarchar](200) NULL,
	[p64] [nvarchar](200) NULL,
	[p65] [nvarchar](200) NULL,
	[p66] [nvarchar](200) NULL,
	[p67] [nvarchar](200) NULL,
	[p68] [nvarchar](200) NULL,
	[p69] [nvarchar](200) NULL,
	[p70] [nvarchar](200) NULL,
	[p71] [nvarchar](200) NULL,
	[p72] [nvarchar](200) NULL,
	[p73] [nvarchar](200) NULL,
	[p74] [nvarchar](200) NULL,
	[p75] [nvarchar](200) NULL,
	[p76] [nvarchar](200) NULL,
	[p77] [nvarchar](200) NULL,
	[p78] [nvarchar](200) NULL,
	[p79] [nvarchar](200) NULL,
	[p80] [nvarchar](200) NULL,
	[p81] [nvarchar](200) NULL,
	[p82] [nvarchar](200) NULL,
	[p83] [nvarchar](200) NULL,
	[p84] [nvarchar](200) NULL,
	[p85] [nvarchar](200) NULL,
	[p86] [nvarchar](200) NULL,
	[p87] [nvarchar](200) NULL,
	[p88] [nvarchar](200) NULL,
	[p89] [nvarchar](200) NULL,
	[p90] [nvarchar](200) NULL,
	[p91] [nvarchar](200) NULL,
	[p92] [nvarchar](200) NULL,
	[p93] [nvarchar](200) NULL,
	[p94] [nvarchar](200) NULL,
	[p95] [nvarchar](200) NULL,
	[p96] [nvarchar](200) NULL,
	[p97] [nvarchar](200) NULL,
	[p98] [nvarchar](200) NULL,
	[p99] [nvarchar](200) NULL,
	[p100] [nvarchar](200) NULL,
	[p101] [nvarchar](200) NULL,
	[p102] [nvarchar](200) NULL,
	[p103] [nvarchar](200) NULL,
	[p104] [nvarchar](200) NULL,
	[p105] [nvarchar](200) NULL,
	[p106] [nvarchar](200) NULL,
	[p107] [nvarchar](200) NULL,
	[p108] [nvarchar](200) NULL,
	[p109] [nvarchar](200) NULL,
	[p110] [nvarchar](200) NULL,
	[p111] [nvarchar](200) NULL,
	[p112] [nvarchar](200) NULL,
	[p113] [nvarchar](200) NULL,
	[p114] [nvarchar](200) NULL,
	[p115] [nvarchar](200) NULL,
	[p116] [nvarchar](200) NULL,
	[p117] [nvarchar](200) NULL,
	[p118] [nvarchar](200) NULL,
	[p119] [nvarchar](200) NULL,
	[p120] [nvarchar](200) NULL,
	[p121] [nvarchar](200) NULL,
	[p122] [nvarchar](200) NULL,
	[p123] [nvarchar](200) NULL,
	[p124] [nvarchar](200) NULL,
	[p125] [nvarchar](200) NULL,
	[p126] [nvarchar](200) NULL,
	[p127] [nvarchar](200) NULL,
	[p128] [nvarchar](200) NULL,
	[p129] [nvarchar](200) NULL,
	[p130] [nvarchar](200) NULL,
	[p131] [nvarchar](200) NULL,
	[p132] [nvarchar](200) NULL,
	[p133] [nvarchar](200) NULL,
	[p134] [nvarchar](200) NULL,
	[p135] [nvarchar](200) NULL,
	[p136] [nvarchar](200) NULL,
	[p137] [nvarchar](200) NULL,
	[p138] [nvarchar](200) NULL,
	[p139] [nvarchar](200) NULL,
	[p140] [nvarchar](200) NULL,
	[p141] [nvarchar](200) NULL,
	[p142] [nvarchar](200) NULL,
	[p143] [nvarchar](200) NULL,
	[p144] [nvarchar](200) NULL,
	[p145] [nvarchar](200) NULL,
	[p146] [nvarchar](200) NULL,
	[p147] [nvarchar](200) NULL,
	[p148] [nvarchar](200) NULL,
	[p149] [nvarchar](200) NULL,
	[p150] [nvarchar](200) NULL,
	[p151] [nvarchar](200) NULL,
	[p152] [nvarchar](200) NULL,
	[p153] [nvarchar](200) NULL,
	[p154] [nvarchar](200) NULL,
	[p155] [nvarchar](200) NULL,
	[p156] [nvarchar](200) NULL,
	[p157] [nvarchar](200) NULL,
	[p158] [nvarchar](200) NULL,
	[p159] [nvarchar](200) NULL,
	[p160] [nvarchar](200) NULL,
	[p161] [nvarchar](200) NULL,
	[p162] [nvarchar](200) NULL,
	[p163] [nvarchar](200) NULL,
	[p164] [nvarchar](200) NULL,
	[p165] [nvarchar](200) NULL,
	[p166] [nvarchar](200) NULL,
	[p167] [nvarchar](200) NULL,
	[p168] [nvarchar](200) NULL,
	[p169] [nvarchar](200) NULL,
	[p170] [nvarchar](200) NULL,
	[p171] [nvarchar](200) NULL,
	[p172] [nvarchar](200) NULL,
	[p173] [nvarchar](200) NULL,
	[p174] [nvarchar](200) NULL,
	[p175] [nvarchar](200) NULL,
	[p176] [nvarchar](200) NULL,
	[p177] [nvarchar](200) NULL,
	[p178] [nvarchar](200) NULL,
	[p179] [nvarchar](200) NULL,
	[p180] [nvarchar](200) NULL,
	[p181] [nvarchar](200) NULL,
	[p182] [nvarchar](200) NULL,
	[p183] [nvarchar](200) NULL,
	[p184] [nvarchar](200) NULL,
	[p185] [nvarchar](200) NULL,
	[p186] [nvarchar](200) NULL,
	[p187] [nvarchar](200) NULL,
	[p188] [nvarchar](200) NULL,
	[p189] [nvarchar](200) NULL,
	[p190] [nvarchar](200) NULL,
	[p191] [nvarchar](200) NULL,
	[p192] [nvarchar](200) NULL,
	[p193] [nvarchar](200) NULL,
	[p194] [nvarchar](200) NULL,
	[p195] [nvarchar](200) NULL,
	[p196] [nvarchar](200) NULL,
	[p197] [nvarchar](200) NULL,
	[p198] [nvarchar](200) NULL,
	[p199] [nvarchar](200) NULL,
	[p200] [nvarchar](4000) NULL,
	[p201] [nvarchar](200) NULL,
	[p202] [nvarchar](200) NULL,
	[p203] [nvarchar](200) NULL,
	[p204] [nvarchar](200) NULL,
	[p205] [nvarchar](200) NULL,
	[p206] [nvarchar](200) NULL,
	[p207] [nvarchar](200) NULL,
	[p208] [nvarchar](200) NULL,
	[p209] [nvarchar](200) NULL,
	[p210] [nvarchar](200) NULL,
	[p211] [nvarchar](200) NULL,
	[p212] [nvarchar](200) NULL,
	[p213] [nvarchar](200) NULL,
	[p214] [nvarchar](200) NULL,
	[p215] [nvarchar](200) NULL,
	[p216] [nvarchar](200) NULL,
	[p217] [nvarchar](200) NULL,
	[p218] [nvarchar](200) NULL,
	[p219] [nvarchar](200) NULL,
	[p220] [nvarchar](200) NULL,
	[p221] [nvarchar](200) NULL,
	[p222] [nvarchar](200) NULL,
	[p223] [nvarchar](200) NULL,
	[p224] [nvarchar](200) NULL,
	[p225] [nvarchar](200) NULL,
	[p226] [nvarchar](200) NULL,
	[p227] [nvarchar](200) NULL,
	[p228] [nvarchar](200) NULL,
	[p229] [nvarchar](200) NULL,
	[p230] [nvarchar](200) NULL,
	[p231] [nvarchar](200) NULL,
	[p232] [nvarchar](200) NULL,
	[p233] [nvarchar](200) NULL,
	[p234] [nvarchar](200) NULL,
	[p235] [nvarchar](200) NULL,
	[p236] [nvarchar](200) NULL,
	[p237] [nvarchar](200) NULL,
	[p238] [nvarchar](200) NULL,
	[p239] [nvarchar](200) NULL,
	[p240] [nvarchar](200) NULL,
	[p241] [nvarchar](200) NULL,
	[p242] [nvarchar](200) NULL,
	[p243] [nvarchar](200) NULL,
	[p244] [nvarchar](200) NULL,
	[p245] [nvarchar](200) NULL,
	[p246] [nvarchar](200) NULL,
	[p247] [nvarchar](200) NULL,
	[p248] [nvarchar](200) NULL,
	[p249] [nvarchar](200) NULL,
	[p250] [nvarchar](200) NULL,
	[p251] [nvarchar](200) NULL,
	[p252] [nvarchar](200) NULL,
	[p253] [nvarchar](200) NULL,
	[p254] [nvarchar](200) NULL,
	[p255] [nvarchar](200) NULL,
	[p256] [nvarchar](200) NULL,
	[p257] [nvarchar](200) NULL,
	[p258] [nvarchar](200) NULL,
	[p259] [nvarchar](200) NULL,
	[p260] [nvarchar](200) NULL,
	[p261] [nvarchar](200) NULL,
	[p262] [nvarchar](200) NULL,
	[p263] [nvarchar](200) NULL,
	[p264] [nvarchar](200) NULL,
	[p265] [nvarchar](200) NULL,
	[p266] [nvarchar](200) NULL,
	[p267] [nvarchar](200) NULL,
	[p268] [nvarchar](200) NULL,
	[p269] [nvarchar](200) NULL,
	[p270] [nvarchar](200) NULL,
	[p271] [nvarchar](200) NULL,
	[p272] [nvarchar](200) NULL,
	[p273] [nvarchar](200) NULL,
	[p274] [nvarchar](200) NULL,
	[p275] [nvarchar](200) NULL,
	[p276] [nvarchar](200) NULL,
	[p277] [nvarchar](200) NULL,
	[p278] [nvarchar](200) NULL,
	[p279] [nvarchar](200) NULL,
	[p280] [nvarchar](200) NULL,
	[p281] [nvarchar](200) NULL,
	[p282] [nvarchar](200) NULL,
	[p283] [nvarchar](200) NULL,
	[p284] [nvarchar](200) NULL,
	[p285] [nvarchar](200) NULL,
	[p286] [nvarchar](200) NULL,
	[p287] [nvarchar](200) NULL,
	[p288] [nvarchar](200) NULL,
	[p289] [nvarchar](200) NULL,
	[p290] [nvarchar](200) NULL,
	[p291] [nvarchar](200) NULL,
	[p292] [nvarchar](200) NULL,
	[p293] [nvarchar](200) NULL,
	[p294] [nvarchar](200) NULL,
	[p295] [nvarchar](200) NULL,
	[p296] [nvarchar](200) NULL,
	[p297] [nvarchar](200) NULL,
	[p298] [nvarchar](200) NULL,
	[p299] [nvarchar](200) NULL,
	[p300] [nvarchar](200) NULL,
	[isupdate] [int] NOT NULL,
 CONSTRAINT [PK_car_autohomeprop] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_autoMaintainProp]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_autoMaintainProp](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[autohomecarid] [int] NOT NULL,
	[p1] [nvarchar](100) NULL,
	[p2] [nvarchar](100) NULL,
	[p3] [nvarchar](100) NULL,
	[p4] [nvarchar](100) NULL,
	[p5] [nvarchar](100) NULL,
	[p6] [nvarchar](100) NULL,
	[p7] [nvarchar](100) NULL,
	[p8] [nvarchar](100) NULL,
	[p9] [nvarchar](100) NULL,
	[p10] [nvarchar](100) NULL,
 CONSTRAINT [PK_car_autoMaintainProp] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_baikeRefrence]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_baikeRefrence](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[baikeid] [int] NULL,
	[link] [nvarchar](200) NULL,
	[isdelete] [tinyint] NULL,
 CONSTRAINT [PK_car_baikeContent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_baikeRelatedmodel]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_baikeRelatedmodel](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[modelid] [int] NULL,
	[baikeid] [int] NULL,
	[isdelete] [tinyint] NULL,
 CONSTRAINT [PK_car_baikeRelatedmodel] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_baikeTitle]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_baikeTitle](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[hascontent] [tinyint] NOT NULL,
	[isdelete] [tinyint] NOT NULL,
	[addtime] [datetime] NULL,
	[uptime] [datetime] NULL,
	[title] [nvarchar](200) NULL,
	[photourl] [nvarchar](400) NULL,
	[baikecontent] [ntext] NULL,
	[hotlevel] [int] NOT NULL,
 CONSTRAINT [PK_car_baikeTitle] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_baikeTitleFromUserAdvice]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_baikeTitleFromUserAdvice](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[title] [nvarchar](200) NULL,
	[addtime] [datetime] NULL,
 CONSTRAINT [PK_car_baikeTitleFromUserAdvice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_brandmanage]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_brandmanage](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[brandid] [int] NOT NULL,
	[groupid] [int] NOT NULL,
 CONSTRAINT [PK_car_brandmanage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_cacc]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[car_cacc](
	[catalogid] [int] NOT NULL,
	[catalogname] [nvarchar](200) NULL,
	[fatherid] [int] NOT NULL,
	[byName] [nvarchar](200) NULL,
	[path] [nvarchar](1000) NULL,
	[isLive] [int] NULL,
	[photo] [nvarchar](100) NULL,
	[newsid] [int] NULL,
	[isdelete] [int] NULL,
	[adddate] [datetime] NULL,
	[lastupdate] [datetime] NULL,
	[addAdmin] [nvarchar](50) NULL,
	[updateAdmin] [nvarchar](50) NULL,
	[delAdmin] [nvarchar](50) NULL,
	[sortId] [int] NULL,
	[factorytel] [nvarchar](20) NULL,
	[carkey] [nvarchar](40) NULL,
	[backename] [nvarchar](40) NULL,
	[maincatalogid] [int] NULL,
	[englishname] [nvarchar](40) NOT NULL,
	[ishaverelation] [int] NULL,
	[LName] [char](4) NULL,
	[pathlevel] [int] NOT NULL,
	[hotlevel] [int] NOT NULL,
 CONSTRAINT [PK_car_cacc] PRIMARY KEY CLUSTERED 
(
	[catalogid] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[car_carkoubei]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_carkoubei](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[price] [numeric](18, 2) NULL,
	[buydate] [datetime] NULL,
	[eid] [int] NOT NULL,
	[space] [int] NOT NULL,
	[power] [int] NOT NULL,
	[Maneuverability] [int] NOT NULL,
	[OilConsumption] [int] NULL,
	[Comfortableness] [int] NULL,
	[Apperance] [int] NULL,
	[Internal] [int] NULL,
	[CostEfficient] [int] NULL,
	[Satisfaction] [int] NULL,
	[Purposeval] [nvarchar](50) NULL,
	[ActualOilConsumption] [numeric](18, 2) NULL,
	[DrivenKiloms] [numeric](18, 2) NULL,
	[feeling0] [nvarchar](500) NULL,
	[feeling1] [nvarchar](500) NULL,
	[feeling2] [nvarchar](500) NULL,
	[feeling3] [nvarchar](500) NULL,
	[feeling4] [nvarchar](500) NULL,
	[feeling5] [nvarchar](500) NULL,
	[feeling6] [nvarchar](500) NULL,
	[feeling7] [nvarchar](500) NULL,
	[feeling8] [nvarchar](500) NULL,
	[feeling9] [nvarchar](500) NULL,
	[feeling10] [nvarchar](500) NULL,
	[isdelete] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
	[carid] [int] NOT NULL,
	[carpic] [nvarchar](4000) NULL,
	[areaid] [int] NOT NULL,
	[ename] [nvarchar](200) NULL,
	[static] [int] NOT NULL,
	[kan_giftreqId] [int] NOT NULL,
	[support] [int] NOT NULL,
	[oppose] [int] NOT NULL,
 CONSTRAINT [PK_car_carkoubei] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_carkoubeicomment]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_carkoubeicomment](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[message] [nvarchar](1000) NOT NULL,
	[koubeiid] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
	[isdelete] [int] NOT NULL,
	[support] [int] NOT NULL,
	[oppose] [int] NOT NULL,
 CONSTRAINT [PK_car_carkoubeicomment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_catalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[car_catalog](
	[catalogid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogname] [nvarchar](200) NULL,
	[fatherid] [int] NOT NULL,
	[byName] [nvarchar](200) NULL,
	[path] [nvarchar](1000) NULL,
	[isLive] [int] NULL,
	[photo] [nvarchar](100) NULL,
	[newsid] [int] NULL,
	[isdelete] [int] NULL,
	[adddate] [datetime] NULL,
	[lastupdate] [datetime] NULL,
	[addAdmin] [nvarchar](50) NULL,
	[updateAdmin] [nvarchar](50) NULL,
	[delAdmin] [nvarchar](50) NULL,
	[sortId] [int] NULL,
	[factorytel] [nvarchar](20) NULL,
	[carkey] [nvarchar](40) NULL,
	[englishname] [nvarchar](40) NULL,
	[backename] [nvarchar](40) NULL,
	[maincatalogid] [int] NULL,
	[mainenglishname] [nvarchar](40) NOT NULL,
	[ishaverelation] [int] NULL,
	[LName] [char](4) NULL,
	[pathlevel] [int] NOT NULL,
	[hotlevel] [int] NOT NULL,
 CONSTRAINT [PK_car_catalog] PRIMARY KEY CLUSTERED 
(
	[catalogid] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[car_catalognew]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[car_catalognew](
	[catalogid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogname] [nvarchar](200) NULL,
	[fatherid] [int] NOT NULL,
	[byName] [nvarchar](200) NULL,
	[path] [nvarchar](1000) NULL,
	[isLive] [int] NULL,
	[onSale] [int] NULL,
	[iyear] [int] NULL,
	[iway] [nvarchar](50) NULL,
	[madein] [int] NULL,
	[xiangti] [int] NULL,
	[jibie] [int] NULL,
	[leixing] [int] NULL,
	[bsq] [int] NULL,
	[pailiang] [int] NULL,
	[photo] [nvarchar](100) NULL,
	[serialname] [nvarchar](200) NULL,
	[newsid] [int] NULL,
	[isdelete] [int] NULL,
	[adddate] [datetime] NULL,
	[lastupdate] [datetime] NULL,
	[addAdmin] [nvarchar](50) NULL,
	[updateAdmin] [nvarchar](50) NULL,
	[delAdmin] [nvarchar](50) NULL,
	[sortId] [int] NULL,
	[factorytel] [nvarchar](20) NULL,
	[carkey] [nvarchar](40) NULL,
	[englishname] [nvarchar](40) NULL,
	[maincatalogid] [int] NULL,
	[ishaverelation] [int] NULL,
	[LName] [char](4) NULL,
	[pathlevel] [int] NOT NULL,
	[hotlevel] [int] NOT NULL,
	[fadongji] [int] NULL,
	[baoyangfeiyong] [int] NOT NULL,
	[pengzhuanglevel] [int] NOT NULL,
	[guanurl] [nvarchar](500) NULL,
 CONSTRAINT [PK_car_catalognew] PRIMARY KEY CLUSTERED 
(
	[catalogid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[car_comment]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[car_comment](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[msgtype] [int] NOT NULL,
	[isbright] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[postername] [nvarchar](200) NOT NULL,
	[message] [nvarchar](1000) NULL,
	[adddate] [datetime] NULL,
	[sortid] [int] NOT NULL,
	[nickname] [nvarchar](200) NULL,
	[isaccess] [int] NOT NULL,
	[support] [int] NOT NULL,
	[oppose] [int] NOT NULL,
	[isdisplay] [int] NOT NULL,
	[IP] [varchar](20) NULL,
	[city] [nvarchar](50) NULL,
	[hascookie] [int] NOT NULL,
 CONSTRAINT [PK_car_comment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[car_comparecomment]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_comparecomment](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[comparecarid] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[postname] [nvarchar](200) NOT NULL,
	[message] [nvarchar](1000) NULL,
	[adddate] [datetime] NULL,
	[sortid] [int] NOT NULL,
	[nickname] [nvarchar](200) NULL,
	[isaccess] [int] NOT NULL,
 CONSTRAINT [PK_car_comparecomment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_comparevote]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_comparevote](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[comparecarid] [int] NOT NULL,
	[votenum1] [int] NOT NULL,
	[votenum2] [int] NOT NULL,
 CONSTRAINT [PK_car_comparevote] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_ctemp]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_ctemp](
	[oid] [int] NULL,
	[nid] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_ctemp2]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_ctemp2](
	[oid] [int] NULL,
	[nid] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_detialnews]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_detialnews](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[serialid] [int] NOT NULL,
	[detailtype] [int] NOT NULL,
	[relatedcarModel] [int] NOT NULL,
	[refertitle] [nvarchar](400) NULL,
	[referlink] [nvarchar](400) NULL,
	[adddate] [datetime] NULL,
	[contentstr] [ntext] NULL,
 CONSTRAINT [PK_car_detialnews] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_forums]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_forums](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[serialid] [int] NULL,
	[forumsid] [int] NULL,
 CONSTRAINT [PK_car_forums] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_group]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_group](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[groupName] [nvarchar](200) NOT NULL,
	[isabroad] [int] NOT NULL,
	[photo] [nvarchar](100) NOT NULL,
	[intro] [nvarchar](1000) NOT NULL,
	[englishname] [nvarchar](200) NULL,
 CONSTRAINT [PK_car_group] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_Info]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_Info](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogid] [int] NOT NULL,
	[introduction] [nchar](1000) NULL,
	[advantage] [nchar](1000) NULL,
	[disadvantage] [nchar](1000) NULL,
 CONSTRAINT [PK_car_Info] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_iway]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_iway](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[brandid] [int] NOT NULL,
	[iway] [nvarchar](50) NOT NULL,
	[guanurl] [nvarchar](500) NULL,
 CONSTRAINT [PK_car_iway] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_newproattention]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_newproattention](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[autohomecarid] [int] NOT NULL,
	[state] [tinyint] NOT NULL,
	[uptime] [datetime] NULL,
 CONSTRAINT [PK_car_newproattention] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_newproperty]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_newproperty](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[type] [nvarchar](200) NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[sort] [int] NULL,
	[level] [int] NULL,
	[explain] [ntext] NULL,
 CONSTRAINT [PK_car_newproperty] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_newtypeproperty]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_newtypeproperty](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[typeid] [int] NOT NULL,
	[content] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_car_newtypeproperty] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_odata]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[car_odata](
	[id] [int] NOT NULL,
	[ob] [varchar](50) NULL,
	[obid] [int] NULL,
	[nb] [varchar](50) NULL,
	[nbid] [int] NULL,
	[ns] [varchar](50) NULL,
	[nsid] [int] NULL,
	[na] [varchar](50) NULL,
	[os] [varchar](50) NULL,
	[osid] [int] NULL,
	[m] [varchar](500) NULL,
	[mid] [int] NULL,
	[iyear] [varchar](50) NULL,
	[iproduct] [varchar](50) NULL,
	[pstate] [varchar](50) NULL,
	[sstate] [varchar](50) NULL,
	[qudao] [varchar](50) NULL,
	[jiegou] [varchar](50) NULL,
	[jibie] [varchar](50) NULL,
	[leixing] [varchar](50) NULL,
	[pailian] [varchar](50) NULL,
	[bsq] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[car_otherSiteCatalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_otherSiteCatalog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[brandId] [int] NOT NULL,
	[serialId] [int] NOT NULL,
	[modelId] [int] NOT NULL,
	[website] [tinyint] NOT NULL,
	[isChina] [tinyint] NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[selfcarid] [int] NOT NULL,
 CONSTRAINT [PK_car_otherSiteCatalog] PRIMARY KEY CLUSTERED 
(
	[website] ASC,
	[brandId] ASC,
	[serialId] ASC,
	[modelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_PostKeyWords]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_PostKeyWords](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keywords] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_car_PostKeyWords] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_propertyExplain]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_propertyExplain](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[explain] [ntext] NOT NULL,
 CONSTRAINT [PK_car_propertyExplain] PRIMARY KEY CLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_secondCarsInfo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_secondCarsInfo](
	[id] [int] NOT NULL,
	[brandName] [nvarchar](50) NULL,
	[serialName] [nvarchar](50) NULL,
	[modelName] [nvarchar](100) NULL,
	[price] [numeric](18, 2) NOT NULL,
	[carAreaId] [int] NOT NULL,
	[newCarPrice] [nvarchar](50) NULL,
	[buyDuty] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[carDesc] [nvarchar](1000) NULL,
	[pailiang] [nvarchar](50) NULL,
	[biansuxiang] [nvarchar](50) NULL,
	[cheti] [nvarchar](50) NULL,
	[color] [nvarchar](50) NULL,
	[BXLC] [int] NOT NULL,
	[PZType] [nvarchar](50) NULL,
	[XSZ] [nvarchar](50) NULL,
	[CLGZFJS] [nvarchar](50) NULL,
	[GCFP] [nvarchar](50) NULL,
	[QHCP] [nvarchar](50) NULL,
	[CK] [nvarchar](50) NULL,
	[SPRQ] [nvarchar](50) NULL,
	[BXYXRQ] [nvarchar](50) NULL,
	[YLFYXRQ] [nvarchar](50) NULL,
	[DJRQ] [nvarchar](50) NULL,
	[GCRQ] [nvarchar](50) NULL,
	[FBRQ] [datetime] NULL,
	[carPic] [nvarchar](1000) NULL,
	[serialId] [int] NOT NULL,
	[nianfen] [int] NOT NULL,
	[isdelete] [int] NULL,
 CONSTRAINT [PK_car_secondCarsInfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_serialNews]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_serialNews](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[newscontent] [nvarchar](1000) NULL,
	[link] [nvarchar](200) NULL,
	[clink] [nvarchar](200) NULL,
	[ctitle] [nvarchar](200) NULL,
	[pic] [nvarchar](200) NULL,
	[adddate] [datetime] NOT NULL,
	[sortId] [int] NOT NULL,
 CONSTRAINT [PK_car_serialNews] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[car_serialpeizhides]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[car_serialpeizhides](
	[serialid] [int] NOT NULL,
	[link1] [nvarchar](500) NULL,
	[link2] [nvarchar](500) NULL,
	[link3] [nvarchar](500) NULL,
	[link4] [nvarchar](500) NULL,
	[link5] [nvarchar](500) NULL,
	[adddate] [datetime] NULL,
	[updatetime] [datetime] NULL,
	[isdelete] [int] NOT NULL,
 CONSTRAINT [PK_car_serialpeizhides] PRIMARY KEY CLUSTERED 
(
	[serialid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[che315wx_actionrecord]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[che315wx_actionrecord](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pubwxaid] [int] NOT NULL,
	[openid] [varchar](512) NOT NULL,
	[actiontype] [int] NOT NULL,
	[tdcodeId] [int] NULL,
	[inputText] [varchar](512) NULL,
	[eventKey] [varchar](512) NULL,
	[isreplied] [int] NOT NULL,
	[addtime] [datetime] NOT NULL,
 CONSTRAINT [PK_che315wx_eventRecord] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[che315wx_intmsg]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[che315wx_intmsg](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Keywords] [varchar](256) NOT NULL,
	[MsgType] [varchar](32) NOT NULL,
	[MsgContent] [varchar](1024) NOT NULL,
	[AddDate] [datetime] NOT NULL,
	[LastUpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_che315wx_intmsg] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[che315wx_pubwxaccount]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[che315wx_pubwxaccount](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](512) NOT NULL,
	[appid] [varchar](512) NOT NULL,
	[appsecret] [varchar](512) NOT NULL,
	[access_token] [varchar](512) NOT NULL,
	[tokenexpiretime] [datetime] NULL,
	[isdelete] [int] NULL,
 CONSTRAINT [PK_che315wx_pubwxaccount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[che315wx_tdcode]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[che315wx_tdcode](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pubwxaid] [int] NOT NULL,
	[sceneid] [int] NOT NULL,
	[scenename] [varchar](512) NOT NULL,
	[scenedescription] [varchar](512) NOT NULL,
	[ticket] [varchar](512) NOT NULL,
	[imgurl] [varchar](512) NULL,
	[isstopped] [int] NOT NULL,
 CONSTRAINT [PK_che315wx_tdcode] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[contract_Manage]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contract_Manage](
	[id] [int] NOT NULL,
	[siteName] [nvarchar](50) NULL,
	[admId] [int] NULL,
	[guidang] [int] NULL,
	[contractNum] [nvarchar](50) NULL,
	[adType] [int] NULL,
	[custormer] [nvarchar](100) NULL,
	[iway] [nvarchar](50) NULL,
	[signingtime] [datetime] NULL,
	[mediaType] [int] NULL,
	[place] [nvarchar](100) NULL,
	[days] [int] NULL,
	[contractValue] [nvarchar](50) NULL,
	[rebate] [nvarchar](50) NULL,
	[realityVale] [nvarchar](50) NULL,
	[style] [int] NULL,
	[implement] [int] NULL,
	[implementValue] [nvarchar](50) NULL,
	[rebatetime] [datetime] NULL,
	[rebated] [nvarchar](50) NULL,
	[InvoiceDate] [datetime] NULL,
	[InvoiceValue] [nvarchar](50) NULL,
	[paymentData] [datetime] NULL,
	[paymentValue] [nvarchar](50) NULL,
	[paymentplace] [nvarchar](50) NULL,
	[cutValue] [nvarchar](50) NULL,
	[noInvoiceValue] [nvarchar](50) NULL,
	[Receivables] [nvarchar](50) NULL,
	[isdelete] [int] NULL,
	[implementDate] [nvarchar](50) NULL,
	[paiqi] [nvarchar](200) NULL,
	[imgpath] [nvarchar](500) NULL,
	[addDate] [datetime] NULL,
	[editDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[crm_baoming]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[crm_baoming](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[isdelete] [int] NOT NULL,
	[sex] [nvarchar](20) NOT NULL,
	[hasbuy] [nvarchar](20) NOT NULL,
	[activetype] [nvarchar](40) NOT NULL,
	[paymonth] [nvarchar](40) NOT NULL,
	[phonearea] [nvarchar](40) NULL,
	[area] [nvarchar](40) NULL,
	[buytimeinmind] [nvarchar](40) NULL,
	[birthday] [nvarchar](40) NULL,
	[phone] [nvarchar](40) NULL,
	[username] [nvarchar](100) NULL,
	[carinmind] [nvarchar](200) NULL,
	[comefrominfo] [nvarchar](200) NULL,
	[address] [nvarchar](400) NULL,
	[baomingdate] [datetime] NULL,
	[adddate] [datetime] NULL,
	[folllowlog] [ntext] NULL,
 CONSTRAINT [PK_crm_baoming] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[css_2014]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[css_2014](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[contents] [nvarchar](max) NULL,
	[description] [nvarchar](50) NULL,
	[adddate] [datetime] NULL,
	[addadmin] [nvarchar](50) NULL,
	[lastadddate] [datetime] NULL,
	[lastadmin] [nvarchar](50) NULL,
	[isdelete] [int] NULL,
 CONSTRAINT [PK_css_2014] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_appclick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_appclick](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[clicktype] [int] NULL,
	[deaid] [int] NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea_appclick] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_backdayclick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_backdayclick](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[clicktype] [int] NULL,
	[deaid] [int] NULL,
	[clickCount] [int] NOT NULL,
	[adddate] [nvarchar](12) NULL,
 CONSTRAINT [PK_dea_backdayclick] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_bbsposts1]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_bbsposts1](
	[pid] [int] NOT NULL,
	[eid] [int] NOT NULL,
	[tid] [int] NOT NULL,
	[layer] [int] NOT NULL,
	[parentid] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[posterid] [int] NOT NULL,
	[posternickname] [nvarchar](200) NOT NULL,
	[title] [nvarchar](200) NULL,
	[lastedit] [nvarchar](200) NULL,
	[ip] [nvarchar](50) NULL,
	[postdatetime] [datetime] NULL,
	[message] [ntext] NULL,
	[fromphone] [int] NOT NULL,
 CONSTRAINT [pid] PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_bbspostsid]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_bbspostsid](
	[pid] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[postdatetime] [datetime] NULL,
 CONSTRAINT [PK_dea_bbspostsid] PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_bbstopics]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_bbstopics](
	[tid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NOT NULL,
	[views] [int] NOT NULL,
	[replies] [int] NOT NULL,
	[highlight] [int] NOT NULL,
	[jinghua] [int] NOT NULL,
	[displayorder] [int] NOT NULL,
	[typeid] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[posterid] [int] NOT NULL,
	[lastposterid] [int] NOT NULL,
	[contentpid] [int] NOT NULL,
	[isimg] [int] NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[posternickname] [nvarchar](200) NOT NULL,
	[lastposternickname] [nvarchar](200) NOT NULL,
	[postdatetime] [datetime] NULL,
	[lastpostdatetime] [datetime] NULL,
	[fromphone] [int] NOT NULL,
 CONSTRAINT [tid] PRIMARY KEY CLUSTERED 
(
	[tid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_bbsuser]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_bbsuser](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NOT NULL,
	[uid] [int] NOT NULL,
 CONSTRAINT [PK_dea_bbsuser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_bitautoprice]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_bitautoprice](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[ename] [nvarchar](200) NULL,
	[bitautoid] [int] NULL,
	[bitautoname] [nvarchar](200) NULL,
	[price] [nvarchar](50) NULL,
	[carid] [int] NULL,
	[carname] [nvarchar](200) NULL,
	[pricedate] [nvarchar](50) NULL,
 CONSTRAINT [PK_dea_bitautoprice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_bymodel]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_bymodel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NULL,
	[modelname] [nvarchar](50) NULL,
	[modelplace] [nvarchar](500) NULL,
	[modelzhekou] [nvarchar](500) NULL,
	[modelcontent] [nvarchar](500) NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea_bymodel] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_byschedule]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_byschedule](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NOT NULL,
	[places] [int] NOT NULL,
	[zhekou] [nvarchar](50) NULL,
	[bydate] [datetime] NOT NULL,
	[remarks] [nvarchar](500) NULL,
	[isdelete] [bit] NOT NULL,
 CONSTRAINT [PK_dea_byschedule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_byschedulesenior]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_byschedulesenior](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NULL,
	[time] [nvarchar](5) NULL,
	[bydate] [datetime] NULL,
	[places] [int] NULL,
	[zhekou] [nvarchar](50) NULL,
	[adddate] [datetime] NULL,
	[note] [nvarchar](500) NULL,
	[isdelete] [bit] NOT NULL,
 CONSTRAINT [PK_dea_byschedulesenior] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_byyuyue]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_byyuyue](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NOT NULL,
	[placeid] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[dealstate] [int] NOT NULL,
	[userid] [int] NOT NULL,
	[zhekou] [nvarchar](8) NOT NULL,
	[realname] [nvarchar](200) NULL,
	[phone] [nvarchar](50) NOT NULL,
	[carcode] [nvarchar](50) NOT NULL,
	[adddate] [datetime] NULL,
	[dealmessage] [nvarchar](1000) NULL,
	[qujian] [int] NULL,
	[openid] [nvarchar](200) NULL,
	[fromsource] [int] NULL,
	[licheng] [nvarchar](300) NULL,
	[issenior] [int] NOT NULL,
 CONSTRAINT [PK_dea_byyuyue] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_click]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_click](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[clicktype] [int] NULL,
	[deaid] [int] NULL,
	[adddate] [datetime] NULL,
	[clickCount] [int] NOT NULL,
 CONSTRAINT [PK_dea_click] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_contact]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_contact](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[name] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[url] [nvarchar](100) NULL,
	[source] [nvarchar](200) NULL,
	[isdelete] [int] NULL,
	[adddate] [datetime] NULL,
	[state] [int] NULL,
 CONSTRAINT [PK_dea_contact] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_custom_price]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_custom_price](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[areaid] [int] NULL,
	[mid] [int] NULL,
	[zdprice] [bigint] NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea_custom_price] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_dayclick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_dayclick](
	[id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[clicktype] [int] NULL,
	[deaid] [int] NULL,
	[clickCount] [int] NOT NULL,
	[adddate] [nvarchar](12) NULL,
 CONSTRAINT [PK_dea_dayclick] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_dealerinfo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_dealerinfo](
	[infoid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[isdelete] [tinyint] NULL,
	[address] [nvarchar](1000) NULL,
	[intro] [nvarchar](4000) NULL,
	[zipcode] [nvarchar](8) NULL,
	[faq] [nvarchar](40) NULL,
	[webaddress] [nvarchar](200) NULL,
	[email] [nvarchar](200) NULL,
	[salephone] [nvarchar](200) NULL,
	[traffic] [nvarchar](1000) NULL,
	[speech] [nvarchar](1000) NULL,
	[honor] [nvarchar](1000) NULL,
	[mapinfo] [nvarchar](200) NULL,
	[h_lat] [nvarchar](200) NOT NULL,
	[h_lng] [nvarchar](200) NOT NULL,
	[qq] [nvarchar](100) NULL,
	[wangwang] [nvarchar](100) NULL,
	[sinaweibo] [nvarchar](200) NULL,
	[afterphone] [nvarchar](200) NULL,
	[helpphone] [nvarchar](200) NULL,
	[navurl] [nvarchar](800) NULL,
 CONSTRAINT [PK_dea_dealerinfo] PRIMARY KEY CLUSTERED 
(
	[infoid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_dealers]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_dealers](
	[eid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[paylevel] [int] NULL,
	[areaid] [int] NULL,
	[modelid] [int] NULL,
	[shortename] [nvarchar](16) NULL,
	[mainbrand] [nvarchar](400) NULL,
	[username] [nvarchar](100) NULL,
	[ename] [nvarchar](200) NOT NULL,
	[domain] [nvarchar](200) NULL,
	[indexhotnewssetting] [tinyint] NULL,
	[isdelete] [tinyint] NULL,
	[adddate] [datetime] NOT NULL,
	[areaIds] [nvarchar](1000) NULL,
	[telephone] [nvarchar](40) NULL,
	[ExpirationDate] [datetime] NULL,
	[isbitauto] [int] NOT NULL,
	[is4s] [tinyint] NULL,
	[isbitautoprice] [int] NULL,
	[seposttableid] [int] NOT NULL,
	[address] [nvarchar](1000) NULL,
	[addbbs] [int] NOT NULL,
	[maxpushid] [int] NOT NULL,
	[pushdate] [datetime] NULL,
	[bmbasiccount] [int] NOT NULL,
	[iway] [nvarchar](1000) NULL,
	[issenior] [int] NULL,
	[remarks] [nvarchar](max) NULL,
 CONSTRAINT [PK_dea_dealers] PRIMARY KEY CLUSTERED 
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_DZShownews]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_DZShownews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[newsid] [int] NULL,
	[context] [ntext] NULL,
	[title] [nvarchar](200) NULL,
	[adddate] [datetime] NULL,
	[isdelete] [int] NULL,
	[newstype] [int] NULL,
	[summary] [varchar](500) NULL,
	[keyword] [varchar](50) NULL,
	[click] [int] NULL,
	[coverpic] [varchar](200) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_employee]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_employee](
	[empid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[sortid] [int] NULL,
	[empname] [nvarchar](40) NULL,
	[plane] [nvarchar](40) NULL,
	[phone] [nvarchar](40) NULL,
	[duty] [nvarchar](100) NULL,
	[avatar] [nvarchar](200) NULL,
	[adddate] [datetime] NULL,
	[isdelete] [tinyint] NULL,
	[servicetype] [int] NOT NULL,
 CONSTRAINT [PK_dea_employee] PRIMARY KEY CLUSTERED 
(
	[empid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_focusimg]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_focusimg](
	[imgid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[placeid] [int] NULL,
	[path] [nvarchar](400) NULL,
	[title] [nvarchar](200) NULL,
	[link] [nvarchar](200) NULL,
	[isdelete] [tinyint] NULL,
	[adddate] [datetime] NULL,
	[updatetime] [datetime] NULL,
 CONSTRAINT [PK_dea_focusimg] PRIMARY KEY CLUSTERED 
(
	[imgid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_frequentlyUseMenu]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_frequentlyUseMenu](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[menuId] [int] NOT NULL,
	[eid] [int] NOT NULL,
 CONSTRAINT [PK_dea_frequentlyUseMenu] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_helpphone]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_helpphone](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](50) NOT NULL,
	[adddate] [datetime] NOT NULL,
	[Pic] [nvarchar](max) NULL,
 CONSTRAINT [PK_dea_helpphone] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_hqnews]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_hqnews](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[des] [nvarchar](300) NULL,
	[serialid] [int] NOT NULL,
	[carids] [nvarchar](200) NOT NULL,
	[starttime] [datetime] NOT NULL,
	[endtime] [datetime] NOT NULL,
	[salemessage] [nvarchar](300) NULL,
	[bigpic] [nvarchar](200) NOT NULL,
	[pic1] [nvarchar](200) NULL,
	[pic2] [nvarchar](200) NULL,
	[pic3] [nvarchar](200) NULL,
	[pic4] [nvarchar](200) NULL,
	[isaddress] [int] NOT NULL,
	[ismap] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
	[newid] [int] NOT NULL,
	[saleprice] [numeric](18, 2) NOT NULL,
	[eid] [int] NOT NULL,
	[isaddphone] [int] NOT NULL,
	[news315] [int] NOT NULL,
 CONSTRAINT [PK_dea_hqnews] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_hqnewsTo315]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_hqnewsTo315](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[hqid] [int] NOT NULL,
	[newsadmin] [nvarchar](50) NULL,
 CONSTRAINT [PK_dea_hqnewsTo315] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_hqprice]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_hqprice](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[hqid] [int] NOT NULL,
	[carid] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
	[isdelete] [int] NOT NULL,
	[eid] [int] NOT NULL,
	[facprice] [numeric](18, 2) NOT NULL,
	[price] [numeric](18, 2) NOT NULL,
	[lowprice] [numeric](18, 2) NOT NULL,
 CONSTRAINT [id] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_menurelated]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_menurelated](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[menuid] [int] NULL,
	[modelid] [int] NULL,
 CONSTRAINT [PK_dea_menurelated] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_menusetting]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_menusetting](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[menuid] [int] NULL,
	[sortid] [int] NULL,
	[showname] [nchar](4) NULL,
	[delState] [int] NOT NULL,
 CONSTRAINT [PK_dea_menusetting] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_message]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_message](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[question] [nvarchar](1000) NOT NULL,
	[adddate] [datetime] NOT NULL,
	[eid] [int] NOT NULL,
	[answer] [nvarchar](1000) NULL,
	[isdelete] [int] NULL,
	[answerDate] [datetime] NULL,
 CONSTRAINT [PK_dea_message] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_mphone]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_mphone](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NOT NULL,
	[mphone] [nvarchar](50) NOT NULL,
	[adddate] [datetime] NOT NULL,
	[dealstate] [int] NOT NULL,
 CONSTRAINT [PK_dea_mphone] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_news]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_news](
	[newsid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[typeid] [int] NULL,
	[views] [int] NULL,
	[hotsortid] [int] NULL,
	[adddate] [datetime] NULL,
	[publishdate] [datetime] NULL,
	[hotdate] [datetime] NULL,
	[isdelete] [tinyint] NULL,
	[ishot] [tinyint] NULL,
	[title] [nvarchar](40) NULL,
	[newscontent] [nvarchar](40) NULL,
	[bbstopicpostid] [int] NULL,
 CONSTRAINT [PK_dea_news] PRIMARY KEY CLUSTERED 
(
	[newsid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_opertions]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_opertions](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NOT NULL,
	[scores] [int] NOT NULL,
	[type] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
 CONSTRAINT [PK_dea_opertions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_ordercar]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_ordercar](
	[orderid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[carid] [int] NULL,
	[orderdate] [datetime] NULL,
	[phone] [nvarchar](40) NULL,
	[customername] [nvarchar](80) NULL,
	[email] [nvarchar](200) NULL,
	[supplement] [nvarchar](400) NULL,
	[state] [int] NULL,
	[ordertype] [tinyint] NULL,
	[isdelete] [tinyint] NULL,
	[areaId] [int] NOT NULL,
	[presices] [nvarchar](400) NULL,
	[userid] [int] NOT NULL,
	[fromsource] [int] NULL,
 CONSTRAINT [PK_dea_ordercar] PRIMARY KEY CLUSTERED 
(
	[orderid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_pagemenu]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_pagemenu](
	[pid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[partname] [nvarchar](40) NULL,
	[fatherid] [int] NULL,
	[isdelete] [tinyint] NULL,
	[adddate] [datetime] NULL,
	[sortid] [int] NOT NULL,
 CONSTRAINT [PK_dea_pagemenu] PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_pagemodel]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_pagemodel](
	[mid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[modeltitle] [nvarchar](40) NULL,
	[pic] [nvarchar](200) NULL,
	[adddate] [datetime] NULL,
	[isdelete] [tinyint] NULL,
 CONSTRAINT [PK_dea_pagemodel] PRIMARY KEY CLUSTERED 
(
	[mid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_phonedealrecord]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_phonedealrecord](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[uid] [int] NULL,
	[orderid] [int] NULL,
	[type] [int] NULL,
	[chulitype] [int] NULL,
	[beizhu] [nvarchar](500) NULL,
	[dealtime] [datetime] NULL,
 CONSTRAINT [PK_dea_phonedealrecord] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_phonemanage]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_phonemanage](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[phone] [nvarchar](200) NULL,
	[password] [nvarchar](200) NULL,
	[temppassword] [nvarchar](200) NULL,
	[realname] [nvarchar](200) NULL,
	[adddate] [datetime] NULL,
	[wxcode] [int] NULL,
	[wxopenid] [nvarchar](400) NULL,
	[startWork] [int] NULL,
	[job] [int] NULL,
 CONSTRAINT [PK_dea_phonemanage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_phonemsg]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_phonemsg](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NOT NULL,
	[uid] [int] NOT NULL,
	[admintype] [int] NOT NULL,
	[itype] [int] NOT NULL,
	[reid] [int] NOT NULL,
	[startdate] [datetime] NOT NULL,
	[msg] [nvarchar](1000) NOT NULL,
	[adddate] [datetime] NOT NULL,
	[isdelete] [int] NOT NULL,
 CONSTRAINT [PK_dea_phonemsg] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_phoneshare]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_phoneshare](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[uid] [int] NULL,
	[eid] [int] NULL,
	[type] [int] NULL,
	[orderid] [int] NULL,
	[touid] [int] NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea_phoneshare] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_prizeInfo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_prizeInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Aid] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Count] [int] NULL,
	[Url] [nvarchar](200) NULL,
	[chance] [decimal](18, 2) NULL,
 CONSTRAINT [PK_dea_prizeInfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_progess]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_progess](
	[eid] [int] NOT NULL,
	[progess] [int] NOT NULL,
 CONSTRAINT [PK_dea_progess] PRIMARY KEY CLUSTERED 
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_pushmessage]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_pushmessage](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NOT NULL,
	[message] [nvarchar](500) NOT NULL,
	[pushdate] [datetime] NOT NULL,
	[adddate] [datetime] NOT NULL,
 CONSTRAINT [PK_dea_pushmessage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_pushtocustomcrm]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_pushtocustomcrm](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NULL,
	[orderid] [int] NULL,
	[pushdate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_qaonline]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_qaonline](
	[qaid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[carid] [int] NULL,
	[quesdate] [datetime] NULL,
	[answerdate] [datetime] NULL,
	[askername] [nvarchar](200) NULL,
	[question] [nvarchar](1000) NULL,
	[answer] [nvarchar](1000) NULL,
	[state] [tinyint] NULL,
	[isdelete] [tinyint] NULL,
	[areaId] [int] NOT NULL,
	[ischeck] [tinyint] NULL,
	[markers] [tinyint] NULL,
	[phone] [nvarchar](50) NULL,
	[email] [nvarchar](100) NULL,
	[userip] [nvarchar](50) NULL,
	[hascookie] [int] NOT NULL,
	[addbbs] [int] NOT NULL,
 CONSTRAINT [PK_dea_qaonline] PRIMARY KEY CLUSTERED 
(
	[qaid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_SCBussinessInfo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_SCBussinessInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[pid] [varchar](200) NOT NULL,
	[paykey] [varchar](200) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_SCcommodity]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_SCcommodity](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NULL,
	[model] [nvarchar](50) NULL,
	[price] [float] NULL,
	[type] [int] NULL,
	[cartype] [nvarchar](max) NULL,
	[Isinstallation] [int] NULL,
	[discount] [float] NULL,
	[starttime] [datetime] NULL,
	[discription] [ntext] NULL,
	[adddate] [datetime] NULL,
	[eid] [int] NULL,
	[endtime] [datetime] NULL,
	[totalnum] [int] NULL,
	[TotalSaleNum] [int] NULL,
	[isPush] [int] NULL,
	[isDelete] [int] NULL,
	[PushInfo] [varchar](500) NULL,
	[taobaoid] [varchar](200) NULL,
	[nprice] [float] NULL,
 CONSTRAINT [PK_dea_SCcommodity] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_SCcommodityByArea]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_SCcommodityByArea](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taobaoid] [nvarchar](200) NULL,
	[price] [float] NULL,
	[nprice] [float] NULL,
	[title] [nvarchar](200) NULL,
	[model] [nvarchar](50) NULL,
	[cartype] [nvarchar](max) NULL,
	[type] [int] NULL,
	[Isinstallation] [int] NULL,
	[discription] [ntext] NULL,
	[rid] [int] NULL,
	[adddate] [datetime] NULL,
	[dzrid] [nvarchar](50) NULL,
 CONSTRAINT [PK_dea_SCcommodityByArea] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_scoresSort]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_scoresSort](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NOT NULL,
	[scores] [int] NOT NULL,
	[datestr] [nvarchar](100) NOT NULL,
	[sdate] [datetime] NOT NULL,
	[edate] [datetime] NOT NULL,
	[brandSort] [int] NOT NULL,
	[areaSort] [int] NOT NULL,
	[brandAndAreaSort] [int] NOT NULL,
	[sortid] [int] NOT NULL,
 CONSTRAINT [PK_dea_scoresSort] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_SCPic]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_SCPic](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NULL,
	[url] [nvarchar](max) NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea_SCPic] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_SCPicByArea]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_SCPicByArea](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[url] [nvarchar](max) NULL,
	[taobaoid] [nvarchar](200) NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea_SCPicByArea] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_SCsignature]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_SCsignature](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cid] [int] NULL,
	[sncode] [nvarchar](50) NULL,
	[status] [int] NULL,
	[isdone] [int] NULL,
	[pickup] [int] NULL,
	[adddate] [datetime] NULL,
	[eid] [int] NULL,
	[username] [nvarchar](50) NULL,
	[userphone] [nvarchar](50) NULL,
	[openid] [nvarchar](50) NULL,
	[Num] [int] NULL,
	[IsValidate] [int] NULL,
	[MessageTime] [int] NULL,
	[address] [nvarchar](500) NULL,
 CONSTRAINT [PK_dea_SCsignature] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_SCTradeRecords]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_SCTradeRecords](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NOT NULL,
	[out_trade_no] [varchar](200) NOT NULL,
	[trade_no] [varchar](200) NOT NULL,
	[trade_status] [varchar](200) NOT NULL,
	[seller_id] [varchar](200) NOT NULL,
	[subject] [varchar](200) NOT NULL,
	[total_fee] [varchar](200) NOT NULL,
	[seller_email] [varchar](200) NOT NULL,
	[buyer_email] [varchar](200) NOT NULL,
	[buyer_id] [varchar](200) NOT NULL,
	[gmt_create] [datetime] NOT NULL,
	[gmt_payment] [datetime] NOT NULL,
	[gmt_close] [datetime] NOT NULL,
	[returnurl] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_smsnotice]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_smsnotice](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](50) NULL,
	[eid] [int] NULL,
	[adddate] [datetime] NULL,
	[isdelete] [int] NULL,
	[number] [nvarchar](30) NULL,
	[type] [int] NOT NULL,
	[yewu] [int] NULL,
 CONSTRAINT [PK_dea_smsnotice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_storedisplay]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_storedisplay](
	[picid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[sortid] [int] NULL,
	[title] [nvarchar](40) NULL,
	[path] [nvarchar](200) NULL,
	[isdelete] [tinyint] NULL,
	[eid] [int] NOT NULL,
	[link] [nvarchar](500) NULL,
 CONSTRAINT [PK_dea_storedisplay] PRIMARY KEY CLUSTERED 
(
	[picid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_temphqcontent]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_temphqcontent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[adddate] [datetime] NOT NULL,
	[hqcontent] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_topicimg]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_topicimg](
	[eid] [int] NOT NULL,
	[indexpic1] [nvarchar](200) NULL,
	[indexpic2] [nvarchar](200) NULL,
	[indexpic3] [nvarchar](200) NULL,
	[indexpic4] [nvarchar](200) NULL,
	[pricepic] [nvarchar](200) NULL,
	[entinfopic] [nvarchar](200) NULL,
	[newspic] [nvarchar](200) NULL,
	[contactpic] [nvarchar](200) NULL,
	[carpic] [nvarchar](200) NULL,
	[servicepic] [nvarchar](200) NULL,
 CONSTRAINT [PK_dea_topicimg] PRIMARY KEY CLUSTERED 
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_userexpenses]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_userexpenses](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[uid] [int] NOT NULL,
	[price] [numeric](18, 2) NOT NULL,
	[isdelete] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
 CONSTRAINT [PK_dea_userexpenses] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_useroil]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_useroil](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[uid] [int] NOT NULL,
	[oil] [numeric](18, 2) NOT NULL,
	[carid] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
 CONSTRAINT [PK_dea_useroil] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_userques]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_userques](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[msg] [nvarchar](200) NOT NULL,
	[uid] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
	[isdelete] [int] NOT NULL,
	[dealstate] [int] NOT NULL,
	[eid] [int] NOT NULL,
	[bbsid] [int] NOT NULL,
 CONSTRAINT [PK_dea_userques] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_users]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_users](
	[uid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [nvarchar](100) NOT NULL,
	[password] [nvarchar](200) NOT NULL,
	[joindate] [datetime] NULL,
	[isdelete] [tinyint] NULL,
	[lastlogindate] [datetime] NULL,
	[lastloginip] [nchar](16) NULL,
 CONSTRAINT [PK_dea_users] PRIMARY KEY CLUSTERED 
(
	[uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxaccesslog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_wxaccesslog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[openid] [varchar](128) NULL,
	[accdate] [int] NULL,
	[eid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_wxaccount]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_wxaccount](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[wx_name] [nvarchar](200) NULL,
	[wx_pwd] [nvarchar](200) NULL,
	[wx_account] [nvarchar](200) NULL,
	[wx_ok] [int] NULL,
	[wx_qrurl] [nvarchar](500) NULL,
	[adddate] [datetime] NULL,
	[last_update] [datetime] NULL,
	[appid] [varchar](128) NULL,
	[appsecret] [varchar](128) NULL,
	[is_service] [int] NULL,
	[bizuin] [nvarchar](100) NULL,
	[slave_user] [nvarchar](200) NULL,
	[slave_sid] [nvarchar](500) NULL,
	[wtoken] [nvarchar](200) NULL,
	[checktime] [datetime] NULL,
	[cookiecheckdate] [datetime] NULL,
	[hasMenu] [int] NULL,
	[zhuti] [int] NULL,
	[apiday] [int] NULL,
	[menu_status] [int] NULL,
	[isAskingOpen] [int] NULL,
	[statdate] [int] NULL,
	[update_interval] [int] NULL,
	[loginerror] [int] NULL,
	[hasrouter] [int] NULL,
	[issvw] [int] NULL,
 CONSTRAINT [PK_ent_wx] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_wxactbm]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_wxactbm](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[sex] [int] NULL,
	[job] [nvarchar](50) NULL,
	[account] [nvarchar](200) NULL,
	[article] [nvarchar](max) NULL,
	[things] [nvarchar](max) NULL,
	[yesorno] [int] NULL,
	[addtime] [datetime] NULL,
	[eid] [int] NULL,
	[age] [int] NULL,
	[phone] [varchar](50) NULL,
 CONSTRAINT [PK_dea_wxactbm] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_wxActivities]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_wxActivities](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Type] [int] NULL,
	[Intro] [nvarchar](1000) NULL,
	[Eid] [int] NULL,
	[Stime] [datetime] NULL,
	[Etime] [datetime] NULL,
	[AddTime] [datetime] NULL,
	[url] [nvarchar](500) NULL,
	[key] [nvarchar](100) NULL,
	[state] [int] NULL,
	[count] [int] NULL,
 CONSTRAINT [PK_dea_wxActivities] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxactjoin]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_wxactjoin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Openid] [nvarchar](200) NULL,
	[Pid] [int] NULL,
	[Aid] [int] NULL,
	[AddDate] [datetime] NULL,
	[count] [int] NULL,
 CONSTRAINT [PK_dea_wxactjoin] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxadminpushmsg]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_wxadminpushmsg](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[name] [nvarchar](50) NULL,
	[phone] [nvarchar](100) NULL,
	[carname] [nvarchar](300) NULL,
	[wxflag] [int] NULL,
	[adddate] [datetime] NULL,
	[type] [int] NULL,
 CONSTRAINT [PK_dea_wxadminpushmsg] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxAicheClass]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_wxAicheClass](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ctitle] [varchar](500) NOT NULL,
	[ctime] [datetime] NOT NULL,
	[caddress] [varchar](200) NOT NULL,
	[cadddate] [datetime] NOT NULL,
	[ispush] [int] NOT NULL,
	[eid] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_wxAiCheUser]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_wxAiCheUser](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[phone] [varchar](100) NOT NULL,
	[openid] [varchar](200) NOT NULL,
	[eid] [int] NOT NULL,
	[content] [varchar](500) NOT NULL,
	[adddate] [datetime] NOT NULL,
	[classid] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_wxbyyypushmsg]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_wxbyyypushmsg](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NULL,
	[name] [nvarchar](50) NULL,
	[phone] [nvarchar](100) NULL,
	[zhekou] [nvarchar](100) NULL,
	[ordertime] [datetime] NULL,
	[carcode] [nvarchar](50) NULL,
	[wxflag] [int] NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxershouche]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_wxershouche](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NULL,
	[modelid] [int] NULL,
	[carid] [int] NULL,
	[willprice] [nvarchar](50) NULL,
	[land] [nvarchar](50) NULL,
	[color] [int] NULL,
	[sptime] [nvarchar](50) NULL,
	[nexttime] [nvarchar](50) NULL,
	[czname] [nvarchar](50) NULL,
	[czphone] [nvarchar](50) NULL,
	[czwant] [text] NULL,
	[addtime] [datetime] NULL,
	[isdone] [int] NULL,
	[CarType] [nvarchar](200) NULL,
 CONSTRAINT [PK_dea_wxershouche] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxfootball]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_wxfootball](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NULL,
	[openid] [nvarchar](200) NULL,
	[usrname] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[result1] [nchar](10) NULL,
	[result2] [nchar](10) NULL,
	[result3] [nchar](10) NULL,
	[adddate] [int] NULL,
	[status] [int] NULL,
 CONSTRAINT [PK_dea_wxfootball] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_WXHongBao]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_WXHongBao](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Eid] [int] NULL,
	[UserName] [nvarchar](50) NULL,
	[UserPhone] [nvarchar](50) NULL,
	[OrderDate] [datetime] NULL,
	[LotteryPrice] [int] NULL,
	[ExchangeCode] [nvarchar](100) NULL,
	[IsGet] [int] NULL,
	[ExchangeDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxintmsg]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_wxintmsg](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NOT NULL,
	[keyword] [varchar](128) NOT NULL,
	[msg_type] [varchar](50) NULL,
	[msg_content] [ntext] NOT NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea_wxintmsg] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_wxmsg]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_wxmsg](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[msg_content] [ntext] NULL,
	[msg_type] [varchar](50) NULL,
	[msg_srl] [varchar](20) NULL,
	[change_time] [varchar](15) NULL,
	[msg_status] [int] NULL,
	[retry_num] [int] NULL,
	[eid] [int] NULL,
	[adddate] [datetime] NULL,
	[newsid] [int] NULL,
	[newscontent] [nvarchar](40) NULL,
	[title] [nvarchar](100) NULL,
	[from_type] [int] NULL,
 CONSTRAINT [PK_WX_MESSAGE_GROUP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_wxpay]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_wxpay](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[eid] [int] NULL,
	[wxpay] [int] NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea_wxpay] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxrecord]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_wxrecord](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[openid] [nvarchar](1000) NULL,
	[addtime] [datetime] NULL,
 CONSTRAINT [PK_dea_wxrecord] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxservice]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_wxservice](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Eid] [int] NULL,
	[Openid] [nvarchar](200) NULL,
	[Stars] [int] NULL,
	[Comment] [nvarchar](2000) NULL,
	[AddDate] [datetime] NULL,
	[ComType] [int] NULL,
	[placeid] [int] NULL,
 CONSTRAINT [PK_dea_wxservice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxuser]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_wxuser](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Openid] [nvarchar](200) NULL,
	[Type] [int] NULL,
	[AddDate] [datetime] NULL,
	[Phone] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[CarNo] [nvarchar](50) NULL,
	[Eid] [int] NULL,
	[NextBaoyang] [datetime] NULL,
	[NextNianjian] [datetime] NULL,
	[OilShare] [decimal](18, 2) NULL,
	[PriceShare] [decimal](18, 2) NULL,
	[userprevoper] [varchar](128) NULL,
	[userprevopertm] [datetime] NULL,
	[ComScore] [int] NULL,
	[wx_name] [nvarchar](200) NULL,
	[IsSendMes] [int] NULL,
	[RealCarNo] [nvarchar](50) NULL,
	[LastLogin] [datetime] NULL,
	[CarVin] [nvarchar](50) NULL,
	[address] [nvarchar](500) NULL,
 CONSTRAINT [PK_dea_wxuser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_wxzhuti]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_wxzhuti](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cssurl] [nvarchar](500) NULL,
	[title] [nvarchar](100) NULL,
	[imgurl] [nvarchar](200) NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea_wxzhuti] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_wxzplist]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dea_wxzplist](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NULL,
	[aid] [int] NULL,
	[name] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[url1] [nvarchar](max) NULL,
	[url2] [nvarchar](max) NULL,
	[url3] [nvarchar](max) NULL,
	[url4] [nvarchar](max) NULL,
	[url5] [nvarchar](max) NULL,
	[ucontent] [nvarchar](max) NULL,
	[adddate] [datetime] NULL,
	[isok] [int] NOT NULL,
	[curridx] [int] NULL,
	[type1] [int] NULL,
	[type2] [int] NULL,
	[type3] [int] NULL,
	[type4] [int] NULL,
	[type5] [int] NULL,
	[openid] [varchar](128) NULL,
	[chexing] [varchar](128) NULL,
 CONSTRAINT [PK_dea_wxzplist] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dea_youhui]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_youhui](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[des] [nvarchar](500) NULL,
	[path] [nvarchar](200) NULL,
	[eid] [int] NOT NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dea_youhui] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dea_youhuibm]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dea_youhuibm](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](50) NOT NULL,
	[adddate] [datetime] NOT NULL,
	[dealstate] [int] NOT NULL,
	[youhid] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[uid] [int] NOT NULL,
 CONSTRAINT [PK_dea_youhuibm] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dealer_temp]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dealer_temp](
	[eid] [int] NULL,
	[mainbrand] [nvarchar](1000) NULL,
	[mk] [nvarchar](1000) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Dm_Mobile]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dm_Mobile](
	[ID] [int] NOT NULL,
	[MobileNumber] [nvarchar](20) NULL,
	[MobileArea] [nvarchar](50) NULL,
	[MobileType] [nvarchar](50) NULL,
	[AreaCode] [nvarchar](10) NULL,
	[PostCode] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dongyue_bmdata]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dongyue_bmdata](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[areaname] [nvarchar](50) NULL,
	[serialname] [nvarchar](50) NULL,
	[phonearea] [nvarchar](50) NULL,
	[areaid] [int] NOT NULL,
	[serialid] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
	[adduser] [nvarchar](50) NULL,
	[baomingdate] [nvarchar](50) NULL,
 CONSTRAINT [PK_dongyue_bmdata] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dongyue_user]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dongyue_user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[password] [nvarchar](200) NOT NULL,
	[adddate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[duihuaList]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[duihuaList](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[RobConfirmedNumb] [nvarchar](100) NULL,
	[goodsType] [nvarchar](50) NULL,
	[Intro] [nvarchar](500) NULL,
	[pic] [nvarchar](200) NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[dealExpenses] [nvarchar](50) NULL,
	[goodsNumb] [int] NULL,
	[onlinetime] [nvarchar](100) NULL,
	[isChouJiang] [nvarchar](50) NULL,
	[dealType] [nvarchar](50) NULL,
	[isvisual] [nvarchar](50) NULL,
	[danwei] [nvarchar](50) NULL,
	[probability] [nvarchar](50) NULL,
	[coin] [int] NULL,
	[huagoudian] [int] NULL,
	[maxtopic] [int] NULL,
	[maxnumb] [int] NULL,
	[adddate] [datetime] NOT NULL,
	[onlinetimestart] [datetime] NULL,
	[onlinetimeend] [datetime] NULL,
	[posttimestart] [datetime] NULL,
	[posttimeend] [datetime] NULL,
 CONSTRAINT [PK_duihuaList] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[duihuaPresent]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[duihuaPresent](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userid] [int] NOT NULL,
	[presentId] [int] NOT NULL,
	[isend] [int] NOT NULL,
	[company] [nvarchar](100) NULL,
	[sendid] [nvarchar](100) NULL,
	[adddate] [datetime] NOT NULL,
	[isdelete] [int] NOT NULL,
	[ptype] [int] NOT NULL,
	[presentname] [nvarchar](50) NULL,
	[username] [nvarchar](50) NULL,
	[truename] [nvarchar](50) NULL,
	[address] [nvarchar](200) NULL,
	[icard] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
 CONSTRAINT [PK_duihuaPresent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dwr_region]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dwr_region](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[regionname] [varchar](128) NULL,
	[remarks] [nvarchar](512) NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK__dwr_regi__3213E83FE243D406] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dwr_region_dealers]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dwr_region_dealers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[eid] [int] NULL,
	[adddate] [datetime] NULL,
	[statdate] [char](8) NULL,
 CONSTRAINT [PK__dwr_regi__3213E83FE20B5AA4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dwr_region_imgs]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dwr_region_imgs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[url] [nvarchar](300) NULL,
	[uid] [int] NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_dwr_region_imgs] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dwr_region_msgs]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dwr_region_msgs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[adddate] [datetime] NULL,
	[msgcontent] [ntext] NULL,
	[msgtitle] [ntext] NULL,
	[imgurl] [nvarchar](512) NULL,
 CONSTRAINT [PK__dwr_regi__3213E83F7640901D] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dwr_region_user]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dwr_region_user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[rid] [int] NULL,
	[username] [varchar](128) NULL,
	[userpassword] [varchar](128) NULL,
	[useralias] [nvarchar](128) NULL,
	[remarks] [nvarchar](512) NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK__dwr_regi__3213E83F280B8BFE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dwr_stat_daily]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dwr_stat_daily](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NULL,
	[statdate] [int] NULL,
	[fanstotal] [int] NULL,
	[fansnew] [int] NULL,
	[fanscancel] [int] NULL,
	[fansint] [int] NULL,
	[fansmsg] [int] NULL,
	[IntPageReadCount] [int] NULL,
	[IntPageReadUser] [int] NULL,
	[OriPageReadCount] [int] NULL,
	[OriPageReadUser] [int] NULL,
	[ShareCount] [int] NULL,
	[ShareUser] [int] NULL,
 CONSTRAINT [PK__dwr_stat__3213E83F23625B4B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dwr_stat_daily_20140330]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dwr_stat_daily_20140330](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[eid] [int] NULL,
	[statdate] [int] NULL,
	[fanstotal] [int] NULL,
	[fansnew] [int] NULL,
	[fanscancel] [int] NULL,
	[fansint] [int] NULL,
	[fansmsg] [int] NULL,
	[IntPageReadCount] [int] NULL,
	[IntPageReadUser] [int] NULL,
	[OriPageReadCount] [int] NULL,
	[OriPageReadUser] [int] NULL,
	[ShareCount] [int] NULL,
	[ShareUser] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ent_4s]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ent_4s](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[E_Name] [nvarchar](50) NOT NULL,
	[E_scale] [nvarchar](50) NULL,
	[E_Lperson] [nvarchar](50) NULL,
	[E_staff] [nvarchar](30) NULL,
	[E_Ymoney] [nvarchar](50) NULL,
	[E_address] [nvarchar](100) NULL,
	[E_Anums] [nvarchar](10) NULL,
	[E_phone] [nvarchar](30) NULL,
	[E_fax] [nvarchar](30) NULL,
	[E_Mobilephone] [nvarchar](20) NULL,
	[E_contactName] [nvarchar](20) NULL,
	[E_introduce] [ntext] NULL,
	[E_photo] [nvarchar](2000) NULL,
	[E_founddate] [datetime] NULL,
	[E_mail] [nvarchar](50) NULL,
	[E_url] [nvarchar](50) NULL,
	[isdelete] [int] NULL,
	[username] [nvarchar](200) NULL,
	[areaid] [int] NULL,
	[e_adddate] [datetime] NULL,
	[pay] [int] NULL,
	[px] [int] NULL,
	[py] [int] NULL,
	[mapAreaID] [int] NULL,
	[grade_id] [int] NULL,
	[sortId] [int] NULL,
	[style] [nvarchar](20) NULL,
	[E_Mbusiness] [nvarchar](200) NULL,
 CONSTRAINT [PK_ent_4s] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ent_DomainLogon]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ent_DomainLogon](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Uid] [int] NOT NULL,
	[OutTime] [datetime] NOT NULL,
	[LogonVerify] [bigint] NOT NULL,
	[LogonType] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Uid] ASC,
	[OutTime] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ent_ordercar]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ent_ordercar](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CarTypeName] [nchar](50) NOT NULL,
	[province] [nvarchar](20) NOT NULL,
	[city] [nvarchar](20) NOT NULL,
	[idcard] [nvarchar](50) NOT NULL,
	[email] [nvarchar](30) NOT NULL,
	[address] [nvarchar](50) NOT NULL,
	[userName] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](20) NOT NULL,
	[sex] [nvarchar](10) NOT NULL,
	[ordertime] [datetime] NOT NULL,
	[state] [nchar](10) NOT NULL,
	[isdelete] [int] NULL,
	[Eid] [int] NOT NULL,
	[hopetime] [datetime] NOT NULL,
	[carid] [int] NOT NULL,
 CONSTRAINT [PK_ent_ordercars] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ent_product]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ent_product](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[E_id] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[typeid] [int] NOT NULL,
	[type] [int] NOT NULL,
	[isRecommended] [int] NOT NULL,
	[pricesSort] [int] NOT NULL,
	[sortId] [int] NOT NULL,
	[price] [bigint] NOT NULL,
	[offersprice] [bigint] NOT NULL,
	[name] [nvarchar](400) NOT NULL,
	[photo] [nvarchar](1000) NULL,
	[adddate] [datetime] NULL,
	[updatedate] [datetime] NULL,
	[perunit] [nvarchar](10) NULL,
	[remarks] [nvarchar](50) NULL,
	[introduce] [ntext] NULL,
	[directions] [ntext] NULL,
	[standards] [ntext] NULL,
	[discountinfo] [nvarchar](20) NULL,
	[hotdate] [datetime] NULL,
	[isdiscountdef] [tinyint] NULL,
	[bitautoPrice] [bigint] NOT NULL,
 CONSTRAINT [PK_ent_product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ent_user]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ent_user](
	[UserID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[UserName] [nvarchar](200) NOT NULL,
	[UserPassword] [nvarchar](50) NOT NULL,
	[Usersex] [int] NULL,
	[RealName] [nvarchar](50) NULL,
	[UserQuestion] [nvarchar](50) NULL,
	[UserAnswer] [nvarchar](50) NULL,
	[UserEmail] [nvarchar](255) NULL,
	[f_position] [nvarchar](50) NULL,
	[RegDate] [datetime] NULL,
	[f_areaid] [nvarchar](50) NULL,
	[f_address] [nvarchar](100) NULL,
	[f_number] [nvarchar](50) NULL,
	[f_phone] [nvarchar](50) NULL,
	[f_mobilephone] [nvarchar](50) NULL,
	[f_fax] [nvarchar](50) NULL,
	[f_qq] [nvarchar](50) NULL,
	[isBlock] [int] NULL,
	[isDelete] [int] NULL,
	[sortId] [int] NULL,
 CONSTRAINT [PK_ent_user] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ent_vipdealer]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ent_vipdealer](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[oldid] [int] NULL,
	[newid] [int] NULL,
 CONSTRAINT [PK_ent_vipdealer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[img_catalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[img_catalog](
	[catalogid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogname] [nvarchar](200) NULL,
	[fatherid] [int] NOT NULL,
	[byName] [nvarchar](200) NULL,
	[path] [nvarchar](1000) NULL,
	[isdelete] [int] NULL,
	[adddate] [datetime] NULL,
	[sortId] [int] NULL,
	[LName] [char](4) NULL,
	[pathlevel] [int] NOT NULL,
 CONSTRAINT [PK_img_catalog] PRIMARY KEY CLUSTERED 
(
	[catalogid] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[img_content]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[img_content](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[titleId] [int] NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[keywords] [nvarchar](200) NULL,
	[path] [varchar](200) NOT NULL,
	[addDate] [datetime] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[sortId] [int] NOT NULL,
	[isDelete] [tinyint] NOT NULL,
	[contentPage] [int] NOT NULL,
	[serialType] [bigint] NOT NULL,
	[totopdate] [bigint] NOT NULL,
	[catalogid] [int] NOT NULL,
	[type] [int] NOT NULL,
	[backcatalogid] [int] NULL,
	[comefrom] [nvarchar](400) NULL,
 CONSTRAINT [PK_img_content] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[img_newCatalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[img_newCatalog](
	[catalogid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogname] [nvarchar](200) NULL,
	[fatherid] [int] NOT NULL,
	[byName] [nvarchar](200) NULL,
	[path] [nvarchar](1000) NULL,
	[isdelete] [int] NULL,
	[adddate] [datetime] NULL,
	[sortId] [int] NULL,
	[LName] [char](4) NULL,
	[pathlevel] [int] NOT NULL,
 CONSTRAINT [PK_img_newCatalog] PRIMARY KEY CLUSTERED 
(
	[catalogid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[img_newContent]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[img_newContent](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[titleId] [int] NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[keywords] [nvarchar](200) NULL,
	[path] [varchar](200) NOT NULL,
	[addDate] [datetime] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[sortId] [int] NOT NULL,
	[isDelete] [tinyint] NOT NULL,
 CONSTRAINT [PK_img_newContent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[img_newTitle]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[img_newTitle](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogId] [int] NOT NULL,
	[toTop] [int] NOT NULL,
	[toSink] [int] NOT NULL,
	[topTime] [datetime] NOT NULL,
	[sinkTime] [datetime] NOT NULL,
	[contentId] [int] NOT NULL,
	[qqCatalogId] [int] NOT NULL,
	[type] [tinyint] NOT NULL,
	[isDelete] [tinyint] NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[keywords] [nvarchar](200) NULL,
	[addAdmin] [nvarchar](50) NULL,
	[updateAdmin] [nvarchar](50) NULL,
	[delAdmin] [nvarchar](50) NULL,
	[addDate] [datetime] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
 CONSTRAINT [PK_img_newTitle] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[img_title]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[img_title](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogId] [int] NOT NULL,
	[qqCatalogId] [int] NOT NULL,
	[type] [tinyint] NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[keywords] [nvarchar](200) NULL,
	[addAdmin] [nvarchar](50) NULL,
	[updateAdmin] [nvarchar](50) NULL,
	[delAdmin] [nvarchar](50) NULL,
	[addDate] [datetime] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[isDelete] [tinyint] NOT NULL,
	[backcatalogid] [int] NULL,
	[niankuan] [int] NULL,
	[pailiang] [int] NULL,
	[xiangti] [int] NULL,
	[biansu] [int] NULL,
	[color] [nvarchar](50) NULL,
 CONSTRAINT [PK_img_title] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[job_catalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[job_catalog](
	[catalogId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogName] [nvarchar](200) NULL,
	[fatherId] [int] NULL,
	[byName] [nvarchar](200) NULL,
	[isDelete] [int] NULL,
	[path] [nvarchar](500) NULL,
	[sortId] [int] NULL,
	[LName] [char](4) NULL,
	[pathlevel] [int] NOT NULL,
 CONSTRAINT [PK_job_catalog] PRIMARY KEY CLUSTERED 
(
	[catalogId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[job_content]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_content](
	[jobid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogid] [int] NOT NULL,
	[publishDate] [int] NULL,
	[isDelete] [int] NULL,
	[sortId] [int] NULL,
	[effectiveDate] [int] NULL,
	[area] [nvarchar](100) NULL,
	[mainduty] [nvarchar](2000) NULL,
	[careersreQuest] [nvarchar](2000) NULL,
	[jobtype] [tinyint] NULL,
 CONSTRAINT [PK_job_content] PRIMARY KEY CLUSTERED 
(
	[jobid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[job_resume]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[job_resume](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[jobid] [int] NOT NULL,
	[birthday] [int] NULL,
	[isDelete] [int] NULL,
	[username] [nvarchar](50) NULL,
	[nation] [nvarchar](50) NULL,
	[graduateSchool] [nvarchar](200) NULL,
	[major] [nvarchar](200) NULL,
	[phone] [nvarchar](20) NULL,
	[email] [nvarchar](20) NULL,
	[biography] [nvarchar](2000) NULL,
	[expertise] [nvarchar](2000) NULL,
	[hobbies] [nvarchar](2000) NULL,
	[adddate] [datetime] NULL,
	[sortId] [int] NULL,
	[sex] [tinyint] NULL,
	[isProcessed] [tinyint] NULL,
 CONSTRAINT [PK_job_resume] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_active]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_active](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[hdtitle] [nvarchar](200) NULL,
	[photourl] [nvarchar](400) NULL,
	[addadmin] [nvarchar](200) NULL,
	[upadmin] [nvarchar](200) NULL,
	[hdcontent] [ntext] NULL,
	[hdcity] [int] NULL,
	[hdkanbrand] [int] NULL,
	[hdkanserial] [int] NULL,
	[isdelete] [int] NULL,
	[addtime] [datetime] NULL,
	[uptime] [datetime] NULL,
	[starttime] [datetime] NULL,
	[endtime] [datetime] NULL,
 CONSTRAINT [PK_kan_active] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_bbshistory]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_bbshistory](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userid] [int] NULL,
	[carinmind] [nvarchar](200) NULL,
	[address] [nvarchar](200) NULL,
	[baomingdate] [datetime] NULL,
 CONSTRAINT [PK_kan_bbshistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_bmtodealer]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_bmtodealer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[kcbmid] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
	[dealstate] [int] NOT NULL,
	[pushtime] [datetime] NOT NULL,
	[eid] [int] NOT NULL,
	[followlog] [nvarchar](400) NULL,
 CONSTRAINT [PK_kan_bmtodealer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_bmtopingan]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_bmtopingan](
	[id] [int] NOT NULL,
	[phonearea] [nvarchar](40) NULL,
	[phone] [nvarchar](40) NULL,
	[phonestate] [int] NULL,
	[username] [nvarchar](100) NULL,
	[baomingdate] [datetime2](3) NULL,
	[planstate] [int] NULL,
	[plandate] [datetime2](3) NULL,
	[buydate] [datetime2](3) NULL,
	[areaid] [int] NULL,
	[brandid] [int] NULL,
	[serialid] [int] NULL,
	[ismark] [int] NULL,
	[mainid] [int] NULL,
	[isjoin] [int] NULL,
	[kanchedate] [datetime2](3) NULL,
	[mainserver] [int] NULL,
	[again] [int] NULL,
	[isdelete] [int] NULL,
	[buystate] [int] NULL,
	[salerid] [int] NULL,
	[oldbrandid] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_BMVisitHistory]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_BMVisitHistory](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[visitContent] [nvarchar](300) NOT NULL,
	[visitor] [nvarchar](50) NOT NULL,
	[visitdate] [datetime] NOT NULL,
	[baomingId] [int] NOT NULL,
 CONSTRAINT [PK_kan_BMVisitHistory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_citybrand]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_citybrand](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[bid] [int] NOT NULL,
	[cityid] [int] NOT NULL,
	[sortid] [int] NOT NULL,
 CONSTRAINT [PK_kan_citybrand] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_giftreq]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_giftreq](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [nvarchar](100) NULL,
	[mobile] [nvarchar](40) NULL,
	[carnum] [nvarchar](100) NULL,
	[address] [nvarchar](1000) NULL,
	[giftpic] [nvarchar](400) NULL,
	[buycarpic] [nvarchar](400) NULL,
	[drivepic] [nvarchar](400) NULL,
	[idcardpic] [nvarchar](400) NULL,
	[contentstr] [nvarchar](4000) NULL,
	[state] [int] NOT NULL,
	[adddate] [datetime] NULL,
	[gift] [nvarchar](200) NULL,
	[drlidate] [datetime] NULL,
	[buycardate] [datetime] NULL,
 CONSTRAINT [PK_kan_giftreq] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_groupbuy]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_groupbuy](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[serialid] [int] NULL,
	[name] [nvarchar](20) NULL,
	[tel] [nvarchar](50) NULL,
	[applydate] [nvarchar](50) NULL,
	[addtime] [datetime] NULL,
 CONSTRAINT [PK_kan_groupbuy] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_kanchebrand]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_kanchebrand](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](50) NULL,
	[brandid] [int] NULL,
	[relabrandids] [nvarchar](500) NULL,
	[sortid] [int] NULL,
	[description] [nvarchar](1000) NULL,
	[baominginf] [nvarchar](2000) NULL,
	[chengdusortid] [int] NOT NULL,
	[pic] [nvarchar](500) NULL,
 CONSTRAINT [PK_kan_kanchebrand] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_keyword]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_keyword](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyword] [nvarchar](200) NULL,
	[Relatedcar] [int] NULL,
	[type] [int] NULL,
 CONSTRAINT [PK_kan_keyword] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_push]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_push](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](50) NULL,
	[phone] [nvarchar](20) NULL,
	[phonearea] [nvarchar](50) NULL,
	[areaid] [int] NULL,
	[brandid] [int] NULL,
	[serialid] [int] NULL,
	[type] [int] NULL,
	[address] [nvarchar](100) NULL,
	[baomingdate] [datetime] NULL,
	[entids] [int] NULL,
 CONSTRAINT [PK_kan_push] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_qqgroupid]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[kan_qqgroupid](
	[id] [int] NOT NULL,
	[brandid] [int] NOT NULL,
	[qqgroupid] [varchar](50) NOT NULL,
	[brandname] [nvarchar](50) NULL,
 CONSTRAINT [PK_kan_qqgroupid] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[kan_serial]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_serial](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NULL,
	[brandid] [int] NULL,
	[isuse] [tinyint] NULL,
 CONSTRAINT [PK_kan_serial] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_tempbm]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_tempbm](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [nvarchar](100) NULL,
	[testdrivecity] [nvarchar](400) NULL,
	[mobile] [nvarchar](20) NULL,
	[stat] [int] NOT NULL,
	[testdrivedealer] [nvarchar](200) NULL,
 CONSTRAINT [PK_kan_tempbm] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_tempkeyword]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_tempkeyword](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyword] [nvarchar](200) NULL,
	[times] [int] NULL,
	[isdelete] [int] NULL,
 CONSTRAINT [PK_kan_tempkeyword] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[kan_totalbaoming]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kan_totalbaoming](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[activetype] [nvarchar](40) NOT NULL,
	[sex] [nvarchar](4) NULL,
	[hasbuy] [nvarchar](20) NULL,
	[paymonth] [nvarchar](40) NULL,
	[phonearea] [nvarchar](40) NULL,
	[area] [nvarchar](40) NULL,
	[buytimeinmind] [nvarchar](40) NULL,
	[birthday] [nvarchar](40) NULL,
	[phone] [nvarchar](40) NULL,
	[username] [nvarchar](100) NULL,
	[carinmind] [nvarchar](200) NULL,
	[comefrominfo] [nvarchar](200) NULL,
	[address] [nvarchar](400) NULL,
	[followlog] [nvarchar](400) NULL,
	[baomingdate] [datetime] NULL,
	[isdelete] [tinyint] NOT NULL,
	[state] [tinyint] NULL,
	[areaid] [int] NOT NULL,
	[brandid] [int] NOT NULL,
	[buymodel] [nvarchar](200) NULL,
	[serialid] [int] NOT NULL,
 CONSTRAINT [PK_kan_totalbaoming] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[key_answer]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[key_answer](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[questionid] [int] NULL,
	[userid] [int] NULL,
	[acheck] [tinyint] NULL,
	[isdelete] [tinyint] NULL,
	[IP] [nvarchar](50) NULL,
	[nickname] [nvarchar](50) NULL,
	[addtime] [datetime] NULL,
	[username] [nvarchar](200) NOT NULL,
	[Acontent] [nvarchar](max) NULL,
	[isshielded] [int] NOT NULL,
	[support] [int] NULL,
	[oppose] [int] NULL,
	[city] [nvarchar](50) NULL,
	[hascookie] [int] NOT NULL,
 CONSTRAINT [PK_key_answer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[key_InteractiveZt]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[key_InteractiveZt](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[content] [nvarchar](4000) NOT NULL,
 CONSTRAINT [PK_key_InteractiveZt] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[key_keyhot]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[key_keyhot](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ctse] [int] NOT NULL,
	[canquestions] [tinyint] NOT NULL,
	[keyword] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_key_keyhot] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[key_keyrule]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[key_keyrule](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyrule] [nvarchar](200) NULL,
	[rserial] [int] NULL,
	[rkey] [int] NULL,
	[state] [int] NULL,
	[isdelete] [int] NULL,
	[maxserial] [int] NULL,
 CONSTRAINT [PK_key_keyrule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[key_NewsZt]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[key_NewsZt](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyID] [int] NOT NULL,
	[newsID] [nvarchar](4000) NULL,
	[serialID] [nvarchar](4000) NULL,
	[isPublish] [tinyint] NOT NULL,
	[updateAdmin] [nvarchar](50) NULL,
 CONSTRAINT [PK_key_NewsZt] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[key_questions]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[key_questions](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyid] [int] NOT NULL,
	[serialid] [int] NOT NULL,
	[state] [tinyint] NOT NULL,
	[qcheck] [tinyint] NOT NULL,
	[isdelete] [tinyint] NOT NULL,
	[nickname] [nvarchar](20) NULL,
	[qcontent] [nvarchar](1000) NULL,
	[addtime] [datetime] NULL,
	[browses] [int] NOT NULL,
	[username] [nvarchar](200) NOT NULL,
	[formatqcontent] [nvarchar](1000) NULL,
	[answerCount] [int] NULL,
	[answertime] [datetime] NULL,
	[anickname] [nvarchar](50) NULL,
 CONSTRAINT [PK_key_questions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[key_relatedsearch]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[key_relatedsearch](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[dealstate] [int] NULL,
	[issearched] [int] NOT NULL,
	[hascontent] [int] NOT NULL,
	[keywords] [nvarchar](40) NOT NULL,
	[childids] [nvarchar](400) NULL,
	[path] [nvarchar](400) NOT NULL,
	[adddate] [datetime] NULL,
	[updatetime] [datetime] NULL,
	[serialid] [int] NOT NULL,
	[rulekeyid] [int] NOT NULL,
	[playlevel] [int] NOT NULL,
	[infnexttime] [datetime] NULL,
	[autonexttime] [datetime] NULL,
	[bbsnexttime] [datetime] NULL,
	[wwwnexttime] [datetime] NULL,
	[viewCount] [int] NOT NULL,
	[yesterdayCount] [int] NOT NULL,
	[todayCount] [int] NOT NULL,
	[viewDate] [datetime] NULL,
 CONSTRAINT [PK_key_relatedsearch] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[key_searchcontent]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[key_searchcontent](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[newsid] [int] NOT NULL,
	[keywords] [nvarchar](40) NOT NULL,
	[title] [nvarchar](200) NULL,
	[link] [nvarchar](200) NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_key_searchcontent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Lib_linkData]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lib_linkData](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[link] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_Lib_linkData] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[m315_bug]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[m315_bug](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contact] [nvarchar](50) NULL,
	[ucontent] [nvarchar](200) NULL,
	[webtype] [int] NULL,
	[adddate] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mbg_content]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mbg_content](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[uid] [int] NOT NULL,
	[replyid] [int] NULL,
	[forwardroot] [int] NULL,
	[forwardform] [int] NULL,
	[addtime] [datetime] NULL,
	[type] [int] NULL,
 CONSTRAINT [PK_mbg_content] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mbg_followinfo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mbg_followinfo](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[uid] [int] NOT NULL,
	[fansuid] [int] NOT NULL,
	[followtime] [datetime] NULL,
 CONSTRAINT [PK_mbg_followinfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mbg_mentions]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mbg_mentions](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[mentioneduid] [int] NOT NULL,
	[contentid] [int] NOT NULL,
 CONSTRAINT [PK_mbg_mentions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mbg_online]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mbg_online](
	[userid] [int] NOT NULL,
	[time] [datetime] NULL,
 CONSTRAINT [PK_mbg_online] PRIMARY KEY CLUSTERED 
(
	[userid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mbg_temp]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mbg_temp](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[blogid] [int] NULL,
	[content] [nvarchar](1000) NULL,
 CONSTRAINT [PK_mbg_temp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[mbg_users]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mbg_users](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[usertype] [int] NOT NULL,
	[keyid] [int] NOT NULL,
	[nickname] [nvarchar](256) NOT NULL,
	[avatar] [nvarchar](512) NULL,
 CONSTRAINT [PK_mbg_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[msg_1]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msg_1](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyid] [int] NOT NULL,
	[posterid] [int] NOT NULL,
	[msgstate] [int] NOT NULL,
	[sortid] [int] NOT NULL,
	[expandkey] [nvarchar](40) NOT NULL,
	[nickname] [nvarchar](200) NOT NULL,
	[message] [nvarchar](2000) NOT NULL,
	[adddate] [datetime] NULL,
	[hascookie] [int] NOT NULL,
 CONSTRAINT [PK_msg_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[msg_2]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msg_2](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyid] [int] NOT NULL,
	[posterid] [int] NOT NULL,
	[msgstate] [int] NOT NULL,
	[sortid] [int] NOT NULL,
	[expandkey] [nvarchar](40) NOT NULL,
	[nickname] [nvarchar](200) NOT NULL,
	[message] [nvarchar](2000) NOT NULL,
	[adddate] [datetime] NULL,
	[userip] [nvarchar](50) NULL,
	[hascookie] [int] NOT NULL,
 CONSTRAINT [PK_msg_2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[msg_3]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msg_3](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyid] [int] NOT NULL,
	[posterid] [int] NOT NULL,
	[msgstate] [int] NOT NULL,
	[sortid] [int] NOT NULL,
	[expandkey] [nvarchar](40) NOT NULL,
	[nickname] [nvarchar](200) NOT NULL,
	[message] [nvarchar](2000) NOT NULL,
	[adddate] [datetime] NULL,
	[userip] [nvarchar](50) NULL,
	[hascookie] [int] NOT NULL,
 CONSTRAINT [PK_msg_3] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[msg_4]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msg_4](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyid] [int] NOT NULL,
	[posterid] [int] NOT NULL,
	[msgstate] [int] NOT NULL,
	[sortid] [int] NOT NULL,
	[expandkey] [nvarchar](40) NOT NULL,
	[nickname] [nvarchar](200) NOT NULL,
	[message] [nvarchar](2000) NOT NULL,
	[adddate] [datetime] NULL,
	[hascookie] [int] NOT NULL,
 CONSTRAINT [PK_msg_4] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[msg_jiucuo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msg_jiucuo](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[content] [ntext] NOT NULL,
	[qq] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[username] [nvarchar](50) NULL,
	[fatherid] [int] NULL,
	[addtime] [datetime] NULL,
	[answer] [nvarchar](500) NULL,
	[ip] [nvarchar](50) NULL,
	[jiucuoym] [nvarchar](100) NULL,
	[answertime] [datetime] NULL,
 CONSTRAINT [PK_msg_jiucuo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[new_cache]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[new_cache](
	[newsid] [int] NOT NULL,
	[carcatalogid] [int] NOT NULL,
	[newscatalogid] [int] NOT NULL,
	[carpath] [nvarchar](50) NULL,
	[newspath] [nvarchar](50) NULL,
	[brandid] [int] NOT NULL,
 CONSTRAINT [PK_news_cache] PRIMARY KEY CLUSTERED 
(
	[newsid] ASC,
	[carcatalogid] ASC,
	[newscatalogid] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[new_catalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[new_catalog](
	[catalogId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogName] [nvarchar](200) NULL,
	[fatherId] [int] NULL,
	[byName] [nvarchar](200) NULL,
	[navName] [nvarchar](50) NULL,
	[havedir] [int] NULL,
	[ClassId] [int] NULL,
	[isDelete] [int] NULL,
	[path] [nvarchar](500) NULL,
	[newsHtml] [nvarchar](600) NULL,
	[sortId] [int] NULL,
	[LName] [char](4) NULL,
	[pathlevel] [int] NOT NULL,
 CONSTRAINT [PK_new_catalog] PRIMARY KEY CLUSTERED 
(
	[catalogId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[new_content]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[new_content](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[newsId] [int] NOT NULL,
	[areaId] [int] NULL,
	[carcatalogId] [int] NULL,
	[newsTitle] [nvarchar](200) NOT NULL,
	[newsKeywords] [nvarchar](200) NULL,
	[newsContent] [nvarchar](50) NULL,
	[addDate] [datetime] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[sortId] [int] NOT NULL,
	[isDelete] [tinyint] NOT NULL,
	[titleImgPath] [nvarchar](50) NULL,
	[serialid] [int] NOT NULL,
 CONSTRAINT [PK_new_content] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[new_keychangeRec]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[new_keychangeRec](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[newsid] [int] NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_new_keychangeRec] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[new_keylibrary]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[new_keylibrary](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keywords] [nvarchar](200) NULL,
	[url] [nvarchar](1000) NULL,
	[baikeid] [int] NULL,
	[backurl] [nvarchar](1000) NULL,
	[serialid] [int] NOT NULL,
 CONSTRAINT [PK_new_keylibrary] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[new_keywordindex]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[new_keywordindex](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[keyid] [int] NOT NULL,
	[newsid] [int] NOT NULL,
	[contentid] [int] NOT NULL,
 CONSTRAINT [PK_new_keywordindex] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[new_news]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[new_news](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[newsCatalogId] [int] NOT NULL,
	[areaId] [int] NULL,
	[carcatalogId] [int] NULL,
	[newsTitle] [nvarchar](200) NOT NULL,
	[newsKeywords] [nvarchar](200) NULL,
	[titlePhoto] [nvarchar](500) NULL,
	[newsEditor] [nvarchar](200) NULL,
	[addAdmin] [nvarchar](50) NULL,
	[updateAdmin] [nvarchar](50) NULL,
	[delAdmin] [nvarchar](50) NULL,
	[toTop] [int] NOT NULL,
	[toSink] [int] NOT NULL,
	[gradeId1] [int] NOT NULL,
	[gradeId2] [int] NOT NULL,
	[gradeId3] [int] NOT NULL,
	[gradeId4] [int] NOT NULL,
	[gradeId5] [int] NOT NULL,
	[addDate] [datetime] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[isDelete] [tinyint] NOT NULL,
	[sortId] [int] NULL,
	[isPhoto] [tinyint] NOT NULL,
	[description] [nvarchar](400) NULL,
	[isOriginal] [tinyint] NOT NULL,
	[topTime] [datetime] NULL,
	[sinkTime] [datetime] NULL,
	[reLink] [varchar](256) NULL,
	[IsImgNews] [int] NOT NULL,
	[pricedown] [int] NOT NULL,
	[carslevel] [nvarchar](50) NULL,
	[serialid] [int] NOT NULL,
	[shortTitle] [nvarchar](200) NULL,
	[chktitlephoto] [int] NOT NULL,
	[chkdescription] [int] NOT NULL,
	[islook] [int] NOT NULL,
 CONSTRAINT [PK_new_news] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[new_pricecomment]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[new_pricecomment](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[price] [int] NULL,
	[contents] [ntext] NULL,
	[addtime] [datetime] NULL,
	[username] [nvarchar](50) NULL,
 CONSTRAINT [PK_new_pricecomment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[new_publishTime]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[new_publishTime](
	[id] [int] NOT NULL,
	[publishTime] [datetime] NOT NULL,
 CONSTRAINT [PK_new_publishTime] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[new_recommended]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[new_recommended](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogId] [int] NOT NULL,
	[newsId] [int] NOT NULL,
	[newsTitle] [nvarchar](200) NOT NULL,
	[addAdmin] [nvarchar](50) NULL,
	[updateAdmin] [nvarchar](50) NULL,
	[delAdmin] [nvarchar](50) NULL,
	[addDate] [datetime] NULL,
	[isDelete] [tinyint] NOT NULL,
	[sortId] [int] NOT NULL,
 CONSTRAINT [PK_new_recommended] PRIMARY KEY CLUSTERED 
(
	[catalogId] ASC,
	[newsId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[new_related]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[new_related](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[contentId] [int] NOT NULL,
	[url] [varchar](200) NOT NULL,
	[title] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_new_related_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[new_source]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[new_source](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[newsEditor] [varchar](200) NULL,
	[url] [varchar](400) NULL,
 CONSTRAINT [PK_new_source] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[news_cuxiaonews]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[news_cuxiaonews](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[newsid] [int] NOT NULL,
 CONSTRAINT [PK_news_cuxiaonews] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[news_preference]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[news_preference](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userid] [int] NULL,
	[pluginid] [nvarchar](500) NULL,
	[Newscata] [nvarchar](500) NULL,
 CONSTRAINT [PK_news_preference] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[news_quickrule]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[news_quickrule](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[userid] [int] NOT NULL,
	[plugid] [int] NOT NULL,
	[quickrule] [nvarchar](500) NULL,
	[ruleresult] [nvarchar](500) NULL,
 CONSTRAINT [PK_news_quickrule] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[userid] ASC,
	[plugid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pagetitlectr]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pagetitlectr](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NULL,
	[pagetitle] [nvarchar](100) NULL,
	[adddate] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.pagetitlectr] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pk_voteCount]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pk_voteCount](
	[ztid] [int] NOT NULL,
	[voteApp1Count] [int] NULL,
	[voteApp2Count] [int] NULL,
	[voteSeat1Count] [int] NULL,
	[voteSeat2Count] [int] NULL,
	[voteCtrl1Count] [int] NULL,
	[voteCtrl2Count] [int] NULL,
 CONSTRAINT [PK_pk_voteCount] PRIMARY KEY CLUSTERED 
(
	[ztid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pkzt_info]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pkzt_info](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid1] [int] NOT NULL,
	[carid2] [int] NOT NULL,
	[prefacetitle] [nvarchar](100) NULL,
	[prefacecontent] [nvarchar](2000) NULL,
	[apptitle] [nvarchar](100) NULL,
	[appcontent1] [nvarchar](2000) NULL,
	[appcontent2] [nvarchar](2000) NULL,
	[appimgpath11] [nvarchar](200) NULL,
	[appimgpath12] [nvarchar](200) NULL,
	[appimgpath13] [nvarchar](200) NULL,
	[appimgpath14] [nvarchar](200) NULL,
	[appimgpath15] [nvarchar](200) NULL,
	[appimgpath21] [nvarchar](200) NULL,
	[appimgpath22] [nvarchar](200) NULL,
	[appimgpath23] [nvarchar](200) NULL,
	[appimgpath24] [nvarchar](200) NULL,
	[appimgpath25] [nvarchar](200) NULL,
	[seattitle] [nvarchar](100) NULL,
	[seatcontent1] [nvarchar](2000) NULL,
	[seatcontent2] [nvarchar](2000) NULL,
	[seatimgpath11] [nvarchar](200) NULL,
	[seatimgpath12] [nvarchar](200) NULL,
	[seatimgpath13] [nvarchar](200) NULL,
	[seatimgpath14] [nvarchar](200) NULL,
	[seatimgpath15] [nvarchar](200) NULL,
	[seatimgpath21] [nvarchar](200) NULL,
	[seatimgpath22] [nvarchar](200) NULL,
	[seatimgpath23] [nvarchar](200) NULL,
	[seatimgpath24] [nvarchar](200) NULL,
	[seatimgpath25] [nvarchar](200) NULL,
	[ctrltitle] [nvarchar](100) NULL,
	[ctrlcontent1] [nvarchar](2000) NULL,
	[ctrlcontent2] [nvarchar](2000) NULL,
	[ctrlimgpath11] [nvarchar](200) NULL,
	[ctrlimgpath12] [nvarchar](200) NULL,
	[ctrlimgpath21] [nvarchar](200) NULL,
	[ctrlimgpath22] [nvarchar](200) NULL,
	[summarytitle] [nvarchar](100) NULL,
	[summarycontent] [nvarchar](2000) NULL,
	[adddate] [datetime] NULL,
	[uptime] [datetime] NULL,
	[isdelete] [tinyint] NOT NULL,
 CONSTRAINT [PK_pkzt_info] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[prd_proxy]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prd_proxy](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[port] [int] NOT NULL,
	[enable] [int] NOT NULL,
	[proxy] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_prd_proxy] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[prd_relatedcarid]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prd_relatedcarid](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[selfcarid] [int] NOT NULL,
	[disselfcarid] [int] NOT NULL,
	[webid] [int] NOT NULL,
	[lastsearchdate] [datetime] NOT NULL,
	[nextsearchdate] [datetime] NOT NULL,
 CONSTRAINT [PK_prd_relatedcarid] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[prd_webrule]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prd_webrule](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[webtype] [int] NOT NULL,
	[hasprice] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[totalsearchcount] [int] NOT NULL,
	[priceurl] [nvarchar](200) NOT NULL,
	[priceregex] [nvarchar](4000) NOT NULL,
 CONSTRAINT [PK_prd_webrule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pro_carindex]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pro_carindex](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[polycarid] [int] NOT NULL,
	[autohomecarid] [int] NULL,
	[che168carid] [int] NULL,
	[cheshicarid] [int] NULL,
	[xcarcarid] [int] NULL,
	[pcautocarid] [int] NULL,
	[bitautocarid] [int] NULL,
	[isdelete] [int] NOT NULL,
	[polycarname] [nvarchar](200) NOT NULL,
	[autohomecarname] [nvarchar](200) NULL,
	[che168carname] [nvarchar](200) NULL,
	[cheshicarname] [nvarchar](200) NULL,
	[xcarcarname] [nvarchar](200) NULL,
	[pcautocarname] [nvarchar](200) NULL,
	[bitautocarname] [nvarchar](200) NULL,
 CONSTRAINT [PK_pro_carindex] PRIMARY KEY CLUSTERED 
(
	[polycarid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_ad]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_ad](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[typeName] [nvarchar](50) NULL,
	[upload] [nvarchar](400) NULL,
	[frequency] [int] NULL,
	[showcount] [int] NULL,
	[type] [int] NULL,
	[place] [int] NULL,
	[isDelete] [int] NULL,
	[url] [nvarchar](512) NULL,
	[content] [ntext] NULL,
	[adwidth] [int] NULL,
	[adheight] [int] NULL,
	[isshow] [int] NULL,
	[upload2] [nvarchar](400) NULL,
	[url2] [nvarchar](50) NULL,
	[closeTime] [int] NULL,
	[sortId] [int] NULL,
	[isDefault] [int] NULL,
	[areakeyid] [int] NOT NULL,
	[isverify] [int] NULL,
 CONSTRAINT [PK_pub_ad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_AdClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_AdClick](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[sid] [int] NOT NULL,
	[url] [nvarchar](1000) NULL,
	[adddate] [datetime] NULL,
	[isVisitCount] [int] NOT NULL,
 CONSTRAINT [PK_pub_AdClick] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_AdClickAuto]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_AdClickAuto](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[sid] [int] NOT NULL,
	[url] [nvarchar](1000) NULL,
	[adddate] [datetime] NULL,
	[isVisitCount] [int] NOT NULL,
 CONSTRAINT [PK_pub_AdClickAuto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_AdClickhand]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_AdClickhand](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[sid] [int] NOT NULL,
	[url] [nvarchar](1000) NULL,
	[adddate] [datetime] NULL,
	[isVisitCount] [int] NOT NULL,
 CONSTRAINT [PK_pub_AdClickhand] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_adCount]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_adCount](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[sid] [int] NULL,
	[realurl] [nvarchar](400) NULL,
	[admin] [nvarchar](100) NULL,
	[click] [int] NOT NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_pub_adCount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_adSchedule]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_adSchedule](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[aid] [int] NULL,
	[sdate] [datetime] NULL,
	[edate] [datetime] NULL,
 CONSTRAINT [PK_pub_adSchedule] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_beautyweb]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_beautyweb](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[typeid] [int] NOT NULL,
	[dataid] [int] NOT NULL,
 CONSTRAINT [PK_pub_beautyweb] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_blockipug]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_blockipug](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [int] NULL,
	[cont] [nvarchar](500) NULL,
	[adddate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_defad]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_defad](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[upload] [nvarchar](400) NULL,
	[adwidth] [int] NULL,
	[adheight] [int] NULL,
	[sortId] [tinyint] NOT NULL,
	[isDelete] [int] NULL,
	[url] [nvarchar](200) NULL,
 CONSTRAINT [PK_pub_defad] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_editorTemplate]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_editorTemplate](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[isDelete] [tinyint] NOT NULL,
	[name] [nvarchar](32) NOT NULL,
	[html] [ntext] NOT NULL,
 CONSTRAINT [PK_pub_editorTemplate] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_emailsend]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_emailsend](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[isdelete] [int] NOT NULL,
	[sendtime] [int] NOT NULL,
	[adddate] [datetime] NULL,
	[email] [nvarchar](400) NULL,
	[title] [nvarchar](400) NULL,
	[body] [ntext] NULL,
 CONSTRAINT [PK_pub_emailsend] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_formitpost]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pub_formitpost](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ip] [varchar](16) NULL,
	[addtime] [datetime] NULL,
 CONSTRAINT [PK_pub_formitpost] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[pub_ipdata]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[pub_ipdata](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ipnumstart] [bigint] NOT NULL,
	[ipnumend] [bigint] NOT NULL,
	[areaid] [int] NOT NULL,
	[startip] [char](16) NOT NULL,
	[endip] [char](16) NOT NULL,
	[areainfo] [nvarchar](400) NULL,
	[haschecked] [tinyint] NOT NULL,
 CONSTRAINT [PK_pub_ipdata] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[pub_message]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_message](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[content] [nvarchar](200) NULL,
	[tid] [int] NULL,
	[username] [nvarchar](50) NULL,
	[adddate] [datetime] NULL,
	[isdelete] [int] NULL,
	[class] [int] NULL,
	[reply] [nvarchar](200) NULL,
	[sortId] [int] NULL,
	[replyTime] [datetime] NULL,
	[hdExperts] [nvarchar](50) NULL,
	[checkstat] [int] NOT NULL,
	[isBright] [tinyint] NOT NULL,
	[realUserName] [nvarchar](50) NOT NULL,
	[brightPkZtid] [int] NOT NULL,
	[topCount] [int] NOT NULL,
	[support] [int] NOT NULL,
	[oppose] [int] NOT NULL,
 CONSTRAINT [PK_pub_message] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_pinganbaoming]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_pinganbaoming](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[cityname] [nvarchar](50) NULL,
	[licenseno] [nvarchar](50) NULL,
	[price] [nvarchar](50) NULL,
	[mobile] [nvarchar](50) NULL,
	[username] [nvarchar](50) NULL,
	[mediasourse] [nvarchar](50) NULL,
	[email] [nvarchar](200) NULL,
	[adddate] [datetime] NULL,
	[refer] [nvarchar](500) NULL,
	[url] [nvarchar](500) NULL,
	[pagetitle] [nvarchar](200) NULL,
 CONSTRAINT [PK_pub_pinganbaoming] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_pinganprice]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_pinganprice](
	[id] [int] NOT NULL,
	[catalogid] [int] NULL,
	[areaid] [int] NULL,
	[price] [nvarchar](200) NULL,
 CONSTRAINT [PK_pub_pinganprice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_smsdata]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_smsdata](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[mobilestr] [nvarchar](4000) NULL,
	[mcontent] [nvarchar](500) NULL,
	[eid] [int] NULL,
	[sendtime] [int] NULL,
	[adddate] [datetime] NULL,
	[itype] [int] NULL,
 CONSTRAINT [PK_pub_smsdata] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_smsdatabak]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_smsdatabak](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[mobilestr] [nvarchar](4000) NULL,
	[mcontent] [nvarchar](500) NULL,
	[eid] [int] NULL,
	[sendtime] [int] NULL,
	[adddate] [datetime] NULL,
	[itype] [int] NULL,
 CONSTRAINT [PK_pub_smsdatabak] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_tablecatalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_tablecatalog](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[subjectname] [nvarchar](200) NULL,
	[optionname] [nvarchar](200) NULL,
	[isforcount] [int] NULL,
	[isdelete] [int] NOT NULL,
 CONSTRAINT [PK_pub_tablecatalog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_tablecontent]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_tablecontent](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[subjectname] [nvarchar](200) NOT NULL,
	[datastr] [nvarchar](1000) NOT NULL,
	[isdelete] [int] NOT NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_pub_tablecontent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_temp]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_temp](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[type] [int] NOT NULL,
	[data] [int] NOT NULL,
	[description] [nvarchar](50) NULL,
 CONSTRAINT [PK_pub_temp] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pub_urlredirect]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pub_urlredirect](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[inurl] [nvarchar](400) NOT NULL,
	[outurl] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_pub_urlredirect] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pzt_carinfo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pzt_carinfo](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[XNjiasu100] [nvarchar](100) NULL,
	[XNjiasu400] [nvarchar](100) NULL,
	[XNzhidong100] [nvarchar](100) NULL,
	[XNcaokong18] [nvarchar](100) NULL,
	[XNshushi60] [nvarchar](100) NULL,
	[XNshushi80] [nvarchar](100) NULL,
	[XNranyouzonghe] [nvarchar](100) NULL,
	[XNranyouguanfang] [nvarchar](100) NULL,
	[KJftoubu] [nvarchar](100) NULL,
	[KJfzuoyi] [nvarchar](100) NULL,
	[KJbtoubu] [nvarchar](100) NULL,
	[KJbzuoyi] [nvarchar](100) NULL,
	[KJbtuibu] [nvarchar](100) NULL,
	[KJfbeijia] [nvarchar](100) NULL,
	[KJfchuwuge] [nvarchar](100) NULL,
	[KJbchuwuge] [nvarchar](100) NULL,
	[KJbzuoyifangdao] [nvarchar](100) NULL,
	[KJhoubeixian] [nvarchar](100) NULL,
	[AQanquandai] [nvarchar](100) NULL,
	[AQanquanqinao] [nvarchar](100) NULL,
	[AQanquanzhuangzhi] [nvarchar](100) NULL,
	[AQcncap] [nvarchar](100) NULL,
	[AQencap] [nvarchar](100) NULL,
 CONSTRAINT [PK_pzt_carinfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pzt_comment]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pzt_comment](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[carid] [int] NOT NULL,
	[msgtype] [int] NOT NULL,
	[isBright] [int] NOT NULL,
	[isdelete] [int] NOT NULL,
	[message] [nvarchar](max) NULL,
	[username] [nvarchar](50) NULL,
	[adddate] [datetime] NULL,
	[sortid] [int] NOT NULL,
	[nickname] [nvarchar](200) NULL,
 CONSTRAINT [PK_pzt_comment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rne_catalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[rne_catalog](
	[catalogId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogName] [nvarchar](200) NULL,
	[fatherId] [int] NULL,
	[byName] [nvarchar](200) NULL,
	[ClassId] [int] NULL,
	[isDelete] [int] NULL,
	[path] [nvarchar](500) NULL,
	[newsHtml] [nvarchar](600) NULL,
	[sortId] [int] NULL,
	[LName] [char](4) NULL,
	[pathlevel] [int] NOT NULL,
 CONSTRAINT [PK_rne_catalog] PRIMARY KEY CLUSTERED 
(
	[catalogId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sho_userinfo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sho_userinfo](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [varchar](200) NOT NULL,
	[carmodel] [varchar](200) NOT NULL,
	[phone] [varchar](100) NOT NULL,
	[cardnum] [varchar](100) NOT NULL,
	[ticketnum] [varchar](100) NOT NULL,
	[adddate] [datetime] NULL,
 CONSTRAINT [PK_sho_userinfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sit_catalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sit_catalog](
	[catalogid] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogname] [nvarchar](200) NULL,
	[fatherid] [int] NOT NULL,
	[byName] [nvarchar](200) NULL,
	[path] [nvarchar](1000) NULL,
	[title] [nvarchar](1000) NULL,
	[keywords] [nvarchar](1000) NULL,
	[descr] [nvarchar](1000) NULL,
	[havedir] [bit] NULL,
	[isenable] [bit] NULL,
	[isdelete] [int] NULL,
	[LName] [char](4) NULL,
	[pathlevel] [int] NOT NULL,
 CONSTRAINT [PK_sit_catalog] PRIMARY KEY CLUSTERED 
(
	[catalogid] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[skn_ctrl]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[skn_ctrl](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[skin] [ntext] NULL,
	[preskin] [ntext] NULL,
	[isdelete] [int] NULL,
	[updatetime] [datetime] NULL,
 CONSTRAINT [PK_skn_ctrl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[skn_page]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[skn_page](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](200) NOT NULL,
	[skin] [ntext] NULL,
	[preskin] [ntext] NULL,
	[isdelete] [int] NULL,
	[updatetime] [datetime] NULL,
 CONSTRAINT [PK_skn_page] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sub_content]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sub_content](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[pname] [nvarchar](50) NOT NULL,
	[place] [nvarchar](50) NOT NULL,
	[stype] [int] NOT NULL,
	[htmlname] [nvarchar](600) NULL,
	[isdelete] [int] NULL,
	[lastvisittime] [datetime] NULL,
 CONSTRAINT [PK_sub_content] PRIMARY KEY CLUSTERED 
(
	[pname] ASC,
	[place] ASC,
	[stype] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sub_data]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sub_data](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[sid] [int] NULL,
	[title] [nvarchar](2000) NULL,
	[content] [ntext] NULL,
	[pic] [nvarchar](500) NULL,
	[link] [nvarchar](400) NULL,
	[ctitle] [nvarchar](2000) NULL,
	[clink] [nvarchar](400) NULL,
	[color] [nvarchar](50) NULL,
	[bold] [int] NULL,
	[adddate] [datetime] NULL,
	[isdelete] [int] NULL,
	[sortId] [int] NULL,
	[link_back] [nvarchar](400) NULL,
	[clink_back] [nvarchar](400) NULL,
	[isad] [tinyint] NOT NULL,
 CONSTRAINT [PK_sub_data] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sub_usingcontent]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sub_usingcontent](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[usingid] [int] NULL,
 CONSTRAINT [PK_sub_usingcontent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[T_dealerWXTJ]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[T_dealerWXTJ](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ClickNum] [int] NOT NULL,
	[ReleaseNum] [int] NOT NULL,
	[ReadNum] [int] NOT NULL,
	[ReprintNum] [int] NOT NULL,
	[AskNum] [int] NOT NULL,
	[PreMain] [int] NOT NULL,
	[PreDrive] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
	[isdelete] [int] NOT NULL,
	[TDate] [int] NOT NULL,
	[RID] [int] NOT NULL,
 CONSTRAINT [PK_T_dealerWXTJ] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TCDayClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCDayClick](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[BrandId] [int] NOT NULL,
	[adddate] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TCDayClick] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TClick](
	[id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[type] [int] NOT NULL,
	[tid] [int] NOT NULL,
	[ip] [nvarchar](50) NULL,
	[addtime] [datetime] NOT NULL,
 CONSTRAINT [PK_TClick] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TCMonClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCMonClick](
	[BrandId] [int] NOT NULL,
	[addmonth] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TCMonClick] PRIMARY KEY CLUSTERED 
(
	[BrandId] ASC,
	[addmonth] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TCWekClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TCWekClick](
	[BrandId] [int] NOT NULL,
	[addweek] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TCWekClick] PRIMARY KEY CLUSTERED 
(
	[BrandId] ASC,
	[addweek] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TDayClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TDayClick](
	[type] [int] NOT NULL,
	[tid] [int] NOT NULL,
	[adddate] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TDayClick] PRIMARY KEY CLUSTERED 
(
	[type] ASC,
	[tid] ASC,
	[adddate] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TFUDayClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFUDayClick](
	[adminid] [int] NOT NULL,
	[adddate] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TFUDayClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[adddate] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TFUMonClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFUMonClick](
	[adminid] [int] NOT NULL,
	[addmonth] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TFUMonClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[addmonth] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TFUWekClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFUWekClick](
	[adminid] [int] NOT NULL,
	[addweek] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TFUWekClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[addweek] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TFUZDayClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFUZDayClick](
	[adminid] [int] NOT NULL,
	[adddate] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TFUZDayClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[adddate] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TFUZMonClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFUZMonClick](
	[adminid] [int] NOT NULL,
	[addmonth] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TFUZMonClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[addmonth] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TFUZWekClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TFUZWekClick](
	[adminid] [int] NOT NULL,
	[addweek] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TFUZWekClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[addweek] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TMonClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMonClick](
	[type] [int] NOT NULL,
	[tid] [int] NOT NULL,
	[addmonth] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TMonClick] PRIMARY KEY CLUSTERED 
(
	[type] ASC,
	[tid] ASC,
	[addmonth] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tmp_2014count]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_2014count](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[adddate] [datetime] NULL,
	[url] [nvarchar](max) NULL,
	[ip] [nvarchar](50) NULL,
	[tourl] [nvarchar](max) NULL,
 CONSTRAINT [PK_tmp_2014count] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TNewsEditorClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TNewsEditorClick](
	[id] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[tid] [int] NOT NULL,
	[addtime] [datetime] NULL,
 CONSTRAINT [PK_TNewsEditorClick] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tousu_check]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tousu_check](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[questionid] [int] NOT NULL,
	[selecttype] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
 CONSTRAINT [PK_tousu_check] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TPDayClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPDayClick](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ChannelId] [int] NOT NULL,
	[adddate] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TPDayClick] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TPMonClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPMonClick](
	[ChannelId] [int] NOT NULL,
	[addmonth] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TPMonClick] PRIMARY KEY CLUSTERED 
(
	[ChannelId] ASC,
	[addmonth] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TPWekClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TPWekClick](
	[ChannelId] [int] NOT NULL,
	[addweek] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TPWekClick] PRIMARY KEY CLUSTERED 
(
	[ChannelId] ASC,
	[addweek] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tuan_baoming]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tuan_baoming](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [nvarchar](50) NOT NULL,
	[phone] [nvarchar](50) NOT NULL,
	[serialid] [int] NOT NULL,
	[buytype] [nvarchar](50) NOT NULL,
	[buytime] [nvarchar](50) NOT NULL,
	[tuanid] [int] NOT NULL,
	[brandid] [int] NOT NULL,
	[iway] [nvarchar](50) NULL,
	[adddate] [datetime] NOT NULL,
	[isdelete] [int] NOT NULL,
	[dealstate] [int] NOT NULL,
 CONSTRAINT [PK_tuan_baoming] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tuan_brand]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tuan_brand](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[brandid] [int] NOT NULL,
	[serialids] [nvarchar](500) NULL,
	[iway] [nvarchar](50) NULL,
	[areaid] [int] NOT NULL,
	[address] [nvarchar](1000) NULL,
	[message] [nvarchar](1000) NULL,
	[consultphone] [nvarchar](500) NULL,
	[QQ] [nvarchar](12) NULL,
	[bmcount] [int] NOT NULL,
	[pic] [nvarchar](500) NULL,
	[huaxupic] [nvarchar](500) NULL,
	[starttime] [datetime] NOT NULL,
	[endtime] [datetime] NOT NULL,
	[bbstopicid1] [int] NOT NULL,
	[bbstopicid2] [int] NOT NULL,
	[adddate] [datetime] NOT NULL,
	[isdelete] [int] NOT NULL,
	[price] [int] NOT NULL,
	[fatherid] [int] NULL,
	[carid] [int] NULL,
	[activityessence] [nvarchar](1000) NULL,
 CONSTRAINT [PK_tuan_brand] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TUDayClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUDayClick](
	[adminid] [int] NOT NULL,
	[adddate] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TUDayClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[adddate] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TUMonClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUMonClick](
	[adminid] [int] NOT NULL,
	[addmonth] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TUMonClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[addmonth] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TUWekClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUWekClick](
	[adminid] [int] NOT NULL,
	[addweek] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TUWekClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[addweek] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TUZDayClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUZDayClick](
	[adminid] [int] NOT NULL,
	[adddate] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TUZDayClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[adddate] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TUZMonClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUZMonClick](
	[adminid] [int] NOT NULL,
	[addmonth] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TUZMonClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[addmonth] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TUZWekClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TUZWekClick](
	[adminid] [int] NOT NULL,
	[addweek] [int] NOT NULL,
	[su] [int] NULL,
	[click] [int] NULL,
 CONSTRAINT [PK_TUZWekClick] PRIMARY KEY CLUSTERED 
(
	[adminid] ASC,
	[addweek] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[vot_Option]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vot_Option](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SubjectId] [int] NOT NULL,
	[OptionContent] [ntext] NULL,
	[sortindex] [int] NULL,
	[OptionTitle] [nvarchar](800) NULL,
	[photo] [nvarchar](600) NULL,
	[link] [nvarchar](1000) NULL,
	[basenum] [int] NOT NULL,
 CONSTRAINT [PK_vot_Option] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[vot_Reply]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[vot_Reply](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[username] [nvarchar](200) NOT NULL,
	[SubjectId] [int] NOT NULL,
	[OptionId] [int] NOT NULL,
	[VoteTime] [datetime] NULL,
	[mobile] [nvarchar](50) NULL,
	[voteIp] [char](30) NOT NULL,
 CONSTRAINT [PK_vot_Reply] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vot_Subject]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vot_Subject](
	[Id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ActiveName] [nvarchar](200) NULL,
	[SubjectName] [nvarchar](800) NULL,
	[state] [int] NULL,
	[sortindex] [int] NULL,
 CONSTRAINT [PK_vot_Subject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[vote_phone]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vote_phone](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[phone] [nvarchar](50) NULL,
	[adddate] [datetime] NOT NULL,
	[voteid] [int] NOT NULL,
	[username] [nvarchar](50) NULL,
 CONSTRAINT [PK_vote_phone] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[vote_pingxuan]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vote_pingxuan](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[votename] [nvarchar](200) NOT NULL,
	[votecount] [int] NOT NULL,
	[type] [int] NOT NULL,
 CONSTRAINT [PK_vote_pingxuan] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[zht_admin]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zht_admin](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ztid] [int] NULL,
	[adminid] [nvarchar](50) NULL,
 CONSTRAINT [PK_zht_admin] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[zht_brightMessageToTop]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[zht_brightMessageToTop](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[mid] [int] NOT NULL,
	[topTime] [datetime] NOT NULL,
	[topIp] [char](30) NOT NULL,
 CONSTRAINT [PK_zht_brightMessageToTop] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[zht_brightUserInfo]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zht_brightUserInfo](
	[userName] [nvarchar](50) NOT NULL,
	[voteInfo] [nvarchar](2000) NOT NULL,
	[addDate] [datetime] NOT NULL,
	[isPrize] [tinyint] NOT NULL,
	[zid] [int] NOT NULL,
 CONSTRAINT [PK_zht_brightUserInfo] PRIMARY KEY CLUSTERED 
(
	[userName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[zht_content]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zht_content](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[catalogid] [int] NULL,
	[name] [nvarchar](50) NULL,
	[content] [ntext] NULL,
	[adddate] [datetime] NULL,
	[isdelete] [int] NULL,
	[isshow] [int] NULL,
	[titlephoto] [nvarchar](500) NULL,
	[type] [nvarchar](50) NULL,
	[keywords] [nvarchar](200) NULL,
	[descstr] [nvarchar](200) NULL,
	[addadmin] [nvarchar](200) NULL,
	[upadmin] [nvarchar](200) NULL,
	[lastup] [datetime] NULL,
	[rname] [nvarchar](200) NULL,
	[topid] [int] NULL,
	[sortId] [int] NULL,
	[isHead] [tinyint] NOT NULL,
	[lastCommentDate] [datetime] NOT NULL,
 CONSTRAINT [PK_new_zt] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[zht_pkShowComment]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zht_pkShowComment](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[leftComment] [nvarchar](400) NOT NULL,
	[rightComment] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_zht_pkShowComment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[zht_relatedSerial]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zht_relatedSerial](
	[serialId] [int] NOT NULL,
	[contentId] [int] NOT NULL,
 CONSTRAINT [PK_zht_relatedSerial] PRIMARY KEY CLUSTERED 
(
	[serialId] ASC,
	[contentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[zht_subtemplate]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zht_subtemplate](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[type] [int] NULL,
	[isdef] [int] NULL,
	[name] [nvarchar](200) NULL,
	[content] [ntext] NULL,
 CONSTRAINT [PK_zht_subtemplate] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[zht_template]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zht_template](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[name] [nvarchar](200) NULL,
	[content] [ntext] NULL,
	[pic] [nvarchar](200) NULL,
 CONSTRAINT [PK_zht_template] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[zht_Vote]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zht_Vote](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[type] [int] NOT NULL,
	[typeval] [int] NOT NULL,
 CONSTRAINT [PK_zht_Vote] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[car_livecatalog]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*在产表原则：1.品牌不是在产的，抛弃本身及其所有子;2.车系不是在产的，抛弃本身及其所有子;
实现：1.筛选出所有合格车系，作为子表;2.提取地域目录 or 合格车系的所属品牌 or 合格车系 or 合格车系的所有车型*/
CREATE VIEW [dbo].[car_livecatalog]
AS
SELECT TOP (100) PERCENT catalogid, catalogname, fatherid, byName, path, isLive, 
      onSale, iyear, iway, madein, xiangti, jibie, leixing, bsq, pailiang, photo, serialname, 
      newsid, sortId, factorytel, carkey, englishname, ishaverelation, LName, pathlevel, 
      hotlevel
FROM dbo.car_catalognew
WHERE (pathlevel = 3) AND (isLive > 0) OR
      (pathlevel = 2) AND (catalogid IN
          (SELECT fatherid
         FROM dbo.car_catalognew AS car_catalog_1
         WHERE (pathlevel = 3) AND (isLive > 0))) OR
      (pathlevel = 1) AND (catalogid IN
          (SELECT fatherid
         FROM dbo.car_catalognew AS car_catalog_2
         WHERE (pathlevel = 2) AND (catalogid IN
                   (SELECT fatherid
                  FROM dbo.car_catalognew AS car_catalog_3
                  WHERE (pathlevel = 3) AND (isLive > 0)))))

GO
/****** Object:  View [dbo].[car_normalprop]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[car_normalprop]
AS
SELECT   maxprice, (CASE WHEN minprice = 2147483646 THEN 0 ELSE minprice END) AS minprice, maxpailiang, 
                (CASE WHEN minpailiang = 2147483646 THEN 0 ELSE minpailiang END) AS minpailiang, maxoil, 
                (CASE WHEN minoil = 2147483646 THEN 0 ELSE minoil END) AS minoil, serialid
FROM      (SELECT   MAX(price) AS maxprice, MIN(CASE WHEN price = 0 THEN 2147483646 ELSE price END) AS minprice, 
                                 MAX(CASE WHEN pailiang >= 50 THEN pailiang ELSE pailiang * 1000 END) AS maxpailiang, 
                                 MIN(CASE WHEN pailiang >= 50 THEN pailiang WHEN pailiang = 0 THEN 2147483646 ELSE pailiang * 1000 END)
                                  AS minpailiang, MAX(oil) AS maxoil, MIN(CASE WHEN oil = 0 THEN 2147483646 ELSE oil END) AS minoil, 
                                 serialid
                 FROM      (SELECT   (CASE WHEN len(replace(replace(isnull(a.p2, ''), ' ', ''), '-', '')) 
                                                  = 0 THEN 0 ELSE CAST(a.p2 AS numeric(10, 2)) END) AS price, 
                                                  (CASE WHEN len(replace(replace(isnull(a.p30, ''), ' ', ''), '-', '')) 
                                                  = 0 THEN 0 ELSE CAST(a.p30 AS numeric(10, 2)) END) AS pailiang, 
                                                  (CASE WHEN len(replace(replace(replace(isnull(a.p193, ''), '工信部未公布', ''), ' ', ''), '-', '')) 
                                                  = 0 THEN 0 ELSE CAST(a.p193 AS numeric(10, 2)) END) AS oil, b.fatherid AS serialid
                                  FROM      dbo.car_autohomeprop AS a INNER JOIN
                                                  dbo.car_livecatalog AS b ON a.carid = b.catalogid
                                  WHERE   (b.pathlevel = 3) AND (b.isLive = 1)) AS tempa
                 GROUP BY serialid) AS tempb




GO
/****** Object:  View [dbo].[ViewTFUZMonClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create   view [dbo].[ViewTFUZMonClick]
as
select adminid,addmonth,sum(su)as su ,sum(click) as click from 
(
select * from TFUZMonClick  --temptable3

union all

SELECT adminid, addmonth, SUM(su) AS su, SUM(click) AS click   
from  

(

select adminid,adddate / 100 AS addmonth,su,click
from
(
select temptable1.adminid,temptable2.adddate,temptable2.su,temptable2.click from 
(select b.id as adminid,a.ztid from adm_zht a inner join adm_user b on a.adminid=b.username )temptable1
  inner join 
(select  * from dbo.TDayClick where type=6 ) temptable2
  on temptable1.ztid=temptable2.tid  -- temptable4
) temptable6

) DERIVEDTBL       
GROUP BY adminid, addmonth  



)temptable5 group by adminid,addmonth

GO
/****** Object:  View [dbo].[View_NewsGroupMonth]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------新闻组------------------
-----------每月的数据------------------
-----------------------------
CREATE           view [dbo].[View_NewsGroupMonth]
as 

select adminid,addmonth,sum(su) as su,sum(click) as click
from
(

	(select adminid ,addmonth,sum(su) as su,sum(click) as click  from ViewTFUZMonClick b where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

) group by adminid,addmonth)--专题
union all	
	
	(select * from TUMonClick where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

))--新闻

union all
	--频道
select adminid,addmonth,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.addmonth,b.su,b.click from 

	(select a.*,b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) a 
	inner join TPMonClick b on a.clickid=b.channelid)
 a group by adminid,addmonth



) temptable2 group by adminid,addmonth

GO
/****** Object:  View [dbo].[ViewTFUZWekClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[ViewTFUZWekClick]
as
select adminid,addweek,sum(su)as su ,sum(click) as click from 
(
select * from TFUZWekClick  --temptable3

union all


SELECT adminid, addweek, SUM(su) AS su, SUM(click) AS click      
FROM 
(
SELECT *, year(adate)*100+DATEPART(wk, adate) AS addweek      
        FROM 
(
SELECT *, CAST(CAST(adddate / 10000 AS varchar)       
                      + '-' + CAST((adddate - 10000 * (adddate / 10000)) / 100 AS varchar)       
                      + '-' + CAST(adddate - 100 * (adddate / 100) AS varchar)       
                      AS smalldatetime) AS adate      
                FROM 
(
select temptable1.adminid,temptable2.adddate,temptable2.su,temptable2.click from 
(select b.id as adminid,a.ztid from adm_zht a inner join adm_user b on a.adminid=b.username )temptable1
  inner join 
(select  * from dbo.TDayClick where type=6 ) temptable2
  on temptable1.ztid=temptable2.tid  -- temptable4
) temptable6
)temptable7
)temptable8
GROUP BY adminid, addweek 

)temptable5 group by adminid,addweek

GO
/****** Object:  View [dbo].[View_BrandGroupWeek]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------品牌组------------------
-----------每周的数据------------------
-----------------------------
CREATE        view [dbo].[View_BrandGroupWeek]
as 

select adminid,addweek,sum(su) as su,sum(click) as click from 
(

	(select adminid ,addweek,sum(su) as su,sum(click) as click  from ViewTFUZWekClick b where adminid in(select realid from 
(select b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) tempTable

) group by adminid,addweek)
union all

select adminid,addweek,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.addweek,b.su,b.click from (select a.*,b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) a inner join TCWekClick b on a.brandid=b.brandid)
 a group by adminid,addweek





)temptable2 group by adminid,addweek

GO
/****** Object:  View [dbo].[View_NewsGroupWeek]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------新闻组------------------
-----------每周的数据------------------
-----------------------------
CREATE           view [dbo].[View_NewsGroupWeek]
as 

select adminid,addweek,sum(su)as su,sum(click) as click
from
(

	(select adminid ,addweek,sum(su) as su,sum(click) as click  from ViewTFUZWekClick b where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

) group by adminid,addweek)--专题
union all	
	
	(select * from TUWekClick where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

))--新闻

union all
	--频道
select adminid,addweek,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.addweek,b.su,b.click from 

	(select a.*,b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) a 
	inner join TPWekClick b on a.clickid=b.channelid)
 a group by adminid,addweek


)temptable2 group by adminid,addweek

GO
/****** Object:  View [dbo].[ViewTFUZDayClick]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  view [dbo].[ViewTFUZDayClick]
as
select adminid,adddate,sum(su)as su ,sum(click) as click from 
(
select * from TFUZDayClick  --temptable3

union all
select temptable1.adminid,temptable2.adddate,temptable2.su,temptable2.click from 
(select b.id as adminid,a.ztid from adm_zht a inner join adm_user b on a.adminid=b.username )temptable1
  inner join 
(select  * from dbo.TDayClick where type=6 ) temptable2
  on temptable1.ztid=temptable2.tid  -- temptable4
)temptable5 group by adminid,adddate

GO
/****** Object:  View [dbo].[View_BrandGroupDay]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------品牌组------------------
-----------每天的数据------------------
-----------------------------
CREATE         view [dbo].[View_BrandGroupDay]
as 

select adminid,adddate,sum(su) as su,sum(click) as click
from
(


	(select adminid ,adddate,sum(su) as su,sum(click) as click  from  dbo.ViewTFUZDayClick b where adminid in(select realid from 
(select b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) tempTable

) 
 group by adminid,adddate)
union all

select adminid,adddate,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.adddate,b.su,b.click from (select a.*,b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) a inner join TCdayClick b on a.brandid=b.brandid)
 a group by adminid,adddate

)temptable2 group by adminid,adddate

GO
/****** Object:  View [dbo].[View_NewsGroupDay]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------新闻组------------------
-----------每天的数据------------------
-----------------------------
CREATE          view [dbo].[View_NewsGroupDay]
as 

select adminid,adddate,sum(su) as su,sum(click) as click
from
(

	(select adminid ,adddate,sum(su) as su,sum(click) as click  from ViewTFUZDayClick b where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

) group by adminid,adddate)--专题
union all	
	
	(select * from TUdayClick where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

))--新闻

union all
	--频道
select adminid,adddate,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.adddate,b.su,b.click from 

	(select a.*,b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) a 
	inner join TPDayClick b on a.clickid=b.channelid)
 a group by adminid,adddate


)temptable2 group by adminid,adddate

GO
/****** Object:  View [dbo].[View_BrandGroupMonth]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------品牌组------------------
-----------每月的数据------------------
-----------------------------
CREATE         view [dbo].[View_BrandGroupMonth]
as 

select adminid,addmonth,sum(su) as su,sum(click) as click
from
(

	(select adminid ,addmonth,sum(su) as su,sum(click) as click  from ViewTFUZMonClick b where adminid in(select realid from 
(select b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) tempTable

) group by adminid,addmonth)
union all

select adminid,addmonth,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.addmonth,b.su,b.click from (select a.*,b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) a inner join TCMonClick b on a.brandid=b.brandid)
 a group by adminid,addmonth

) temptable2 group by adminid,addmonth

GO
/****** Object:  View [dbo].[img_click]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[img_click]
AS
SELECT     TOP (100) PERCENT tid, COUNT(*) + ISNULL
                          ((SELECT     TOP (1) click
                              FROM         dbo.TDayClick
                              WHERE     (type = 18) AND (tid = dbo.TClick.tid) AND (adddate = YEAR(DATEADD(day, - 1, GETDATE())) * 10000 + MONTH(DATEADD(day, - 1, GETDATE())) 
                                                    * 100 + DAY(DATEADD(day, - 1, GETDATE())))), 0) AS cnum
FROM         dbo.TClick
WHERE     (type = 18)
GROUP BY tid
ORDER BY cnum DESC


GO
/****** Object:  View [dbo].[View_BrandGroupDay2]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------品牌组------------------
-----------每天的数据------------------
-----------专题的点击量，访客量只计算一次------------------
-----------------------------
Create          view [dbo].[View_BrandGroupDay2]
as 

select adminid,adddate,sum(su) as su,sum(click) as click
from
(


	(select adminid ,adddate,sum(su) as su,sum(click) as click  from  dbo.TFUZDayClick b where adminid in(select realid from 
(select b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) tempTable

) 
 group by adminid,adddate)
union all

select adminid,adddate,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.adddate,b.su,b.click from (select a.*,b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) a inner join TCdayClick b on a.brandid=b.brandid)
 a group by adminid,adddate

)temptable2 group by adminid,adddate

GO
/****** Object:  View [dbo].[View_BrandGroupMonth2]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------品牌组------------------
-----------每月的数据------------------
-----------专题的点击量，访客量只计算一次------------------
-----------------------------
Create          view [dbo].[View_BrandGroupMonth2]
as 

select adminid,addmonth,sum(su) as su,sum(click) as click
from
(

	(select adminid ,addmonth,sum(su) as su,sum(click) as click  from TFUZMonClick b where adminid in(select realid from 
(select b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) tempTable

) group by adminid,addmonth)
union all

select adminid,addmonth,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.addmonth,b.su,b.click from (select a.*,b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) a inner join TCMonClick b on a.brandid=b.brandid)
 a group by adminid,addmonth

) temptable2 group by adminid,addmonth

GO
/****** Object:  View [dbo].[View_BrandGroupWeek2]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------品牌组------------------
-----------每周的数据------------------
-----------专题的点击量，访客量只计算一次------------------
-----------------------------
create         view [dbo].[View_BrandGroupWeek2]
as 

select adminid,addweek,sum(su) as su,sum(click) as click from 
(

	(select adminid ,addweek,sum(su) as su,sum(click) as click  from TFUZWekClick b where adminid in(select realid from 
(select b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) tempTable

) group by adminid,addweek)
union all

select adminid,addweek,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.addweek,b.su,b.click from (select a.*,b.id as realid from adm_brand a inner join adm_user b on a.adminid=b.username) a inner join TCWekClick b on a.brandid=b.brandid)
 a group by adminid,addweek





)temptable2 group by adminid,addweek

GO
/****** Object:  View [dbo].[View_dea_ClickCount]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_dea_ClickCount]
AS
SELECT     TOP (1) clickCount
FROM         dbo.dea_dayclick
WHERE     (adddate = CONVERT(NVARCHAR(12), DATEADD(DD, - 1, GETDATE()), 102))

GO
/****** Object:  View [dbo].[View_key_userquestions]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_key_userquestions]
AS
SELECT     id, keyid, serialid, state, qcheck, isdelete, nickname, qcontent, addtime, browses, username, formatqcontent
FROM         dbo.key_questions
WHERE     (username <> '')

GO
/****** Object:  View [dbo].[View_NewsGroupDay2]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------新闻组------------------
-----------每天的数据------------------
-----------专题的点击量，访客量只计算一次------------------
-----------------------------
create           view [dbo].[View_NewsGroupDay2]
as 

select adminid,adddate,sum(su) as su,sum(click) as click
from
(

	(select adminid ,adddate,sum(su) as su,sum(click) as click  from TFUZDayClick b where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

) group by adminid,adddate)--专题
union all	
	
	(select * from TUdayClick where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

))--新闻

union all
	--频道
select adminid,adddate,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.adddate,b.su,b.click from 

	(select a.*,b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) a 
	inner join TPDayClick b on a.clickid=b.channelid)
 a group by adminid,adddate


)temptable2 group by adminid,adddate

GO
/****** Object:  View [dbo].[View_NewsGroupMonth2]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------新闻组------------------
-----------每月的数据------------------
-----------专题的点击量，访客量只计算一次------------------
-----------------------------
create            view [dbo].[View_NewsGroupMonth2]
as 

select adminid,addmonth,sum(su) as su,sum(click) as click
from
(

	(select adminid ,addmonth,sum(su) as su,sum(click) as click  from TFUZMonClick b where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

) group by adminid,addmonth)--专题
union all	
	
	(select * from TUMonClick where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

))--新闻

union all
	--频道
select adminid,addmonth,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.addmonth,b.su,b.click from 

	(select a.*,b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) a 
	inner join TPMonClick b on a.clickid=b.channelid)
 a group by adminid,addmonth



) temptable2 group by adminid,addmonth

GO
/****** Object:  View [dbo].[View_NewsGroupWeek2]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-----------------------------
-----------新闻组------------------
-----------每周的数据------------------
-----------专题的点击量，访客量只计算一次------------------
-----------------------------
create            view [dbo].[View_NewsGroupWeek2]
as 

select adminid,addweek,sum(su)as su,sum(click) as click
from
(

	(select adminid ,addweek,sum(su) as su,sum(click) as click  from TFUZWekClick b where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

) group by adminid,addweek)--专题
union all	
	
	(select * from TUWekClick where adminid in(select realid from 
(select b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) tempTable

))--新闻

union all
	--频道
select adminid,addweek,sum(su) as su,sum(click) as click from 
(select a.adminid as adminname,a.realid as adminid,b.addweek,b.su,b.click from 

	(select a.*,b.id as realid from adm_channel a inner join adm_user b on a.adminid=b.username) a 
	inner join TPWekClick b on a.clickid=b.channelid)
 a group by adminid,addweek


)temptable2 group by adminid,addweek

GO
/****** Object:  View [dbo].[view_sp_ClickCount]    Script Date: 2014/12/17 16:43:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_sp_ClickCount]
AS
SELECT     TOP (1) click
FROM         dbo.TDayClick
WHERE     (adddate = YEAR(DATEADD(DD, - 1, GETDATE())) * 10000 + MONTH(DATEADD(DD, - 1, GETDATE())) * 100 + DAY(DATEADD(DD, - 1, GETDATE())))


GO
/****** Object:  Index [_dta_index_ad_popadcarinfo_c_5_317048711__K4_K3_K2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE CLUSTERED INDEX [_dta_index_ad_popadcarinfo_c_5_317048711__K4_K3_K2] ON [dbo].[ad_popadcarinfo]
(
	[isdelete] ASC,
	[carid] ASC,
	[popaid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_car_autoMaintainProp_c_5_1973438650__K2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE CLUSTERED INDEX [_dta_index_car_autoMaintainProp_c_5_1973438650__K2] ON [dbo].[car_autoMaintainProp]
(
	[carid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_car_comparevote_c_5_413660967__K3_K2_4364]    Script Date: 2014/12/17 16:43:51 ******/
CREATE CLUSTERED INDEX [_dta_index_car_comparevote_c_5_413660967__K3_K2_4364] ON [dbo].[car_comparevote]
(
	[comparecarid] ASC,
	[carid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_kan_totalbaoming_c_5_753958308__K12]    Script Date: 2014/12/17 16:43:51 ******/
CREATE CLUSTERED INDEX [_dta_index_kan_totalbaoming_c_5_753958308__K12] ON [dbo].[kan_totalbaoming]
(
	[carinmind] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_key_NewsZt_c_5_1772389929__K2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE CLUSTERED INDEX [_dta_index_key_NewsZt_c_5_1772389929__K2] ON [dbo].[key_NewsZt]
(
	[keyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_new_keylibrary_c_5_1159479705__K4]    Script Date: 2014/12/17 16:43:51 ******/
CREATE CLUSTERED INDEX [_dta_index_new_keylibrary_c_5_1159479705__K4] ON [dbo].[new_keylibrary]
(
	[baikeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_pub_adSchedule_c_5_1915153868__K2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE CLUSTERED INDEX [_dta_index_pub_adSchedule_c_5_1915153868__K2] ON [dbo].[pub_adSchedule]
(
	[aid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_pub_smsdata_c_5_1403008625__K5_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE CLUSTERED INDEX [_dta_index_pub_smsdata_c_5_1403008625__K5_K1] ON [dbo].[pub_smsdata]
(
	[sendtime] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_id]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Table_id] ON [dbo].[ad_popad]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_isdelete]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_Table_isdelete] ON [dbo].[ad_popad]
(
	[isdelete] ASC,
	[remaintimes] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ad_popadcarinfo]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_ad_popadcarinfo] ON [dbo].[ad_popadcarinfo]
(
	[isdelete] ASC,
	[carid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ad_popadschedule]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_ad_popadschedule] ON [dbo].[ad_popadschedule]
(
	[isdelete] ASC,
	[popaid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_are_catalog_5_1765581328__K3]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_are_catalog_5_1765581328__K3] ON [dbo].[are_catalog]
(
	[fatherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_are_catalog]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_are_catalog] ON [dbo].[are_catalog]
(
	[catalogId] ASC,
	[fatherId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_are_mobile_5_619005832__K2_4]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_are_mobile_5_619005832__K2_4] ON [dbo].[are_mobile]
(
	[mobstart] ASC
)
INCLUDE ( 	[area1]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_bbs_ActivesUser_5_258099960__K2_K3_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_bbs_ActivesUser_5_258099960__K2_K3_1] ON [dbo].[bbs_ActivesUser]
(
	[topicid] ASC,
	[userid] ASC
)
INCLUDE ( 	[Id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_bbs_ActivesUser_5_258099960__K2_K4_K3_K1_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_bbs_ActivesUser_5_258099960__K2_K4_K3_K1_5] ON [dbo].[bbs_ActivesUser]
(
	[topicid] ASC,
	[ActiveFieldId] ASC,
	[userid] ASC,
	[Id] ASC
)
INCLUDE ( 	[content]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_bbs_AppCarSerialNum_5_197575742__K2_K16_1_3_4_5_6_7_8_9_10_11_12_13_14_15_17_18_19_20_21]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_bbs_AppCarSerialNum_5_197575742__K2_K16_1_3_4_5_6_7_8_9_10_11_12_13_14_15_17_18_19_20_21] ON [dbo].[bbs_AppCarSerialNum]
(
	[username] ASC,
	[isdelete] ASC
)
INCLUDE ( 	[id],
	[type],
	[serialnum],
	[truename],
	[gender],
	[mobile],
	[telephone],
	[cartype],
	[caroutput],
	[color],
	[carmark],
	[buydate],
	[address],
	[appdate],
	[nickname],
	[mailbox],
	[recommendedby],
	[code],
	[recodedate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_bbs_PropUseHistory_5_898102240__K5_K6_1_2_3_4_7_8_9]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_bbs_PropUseHistory_5_898102240__K5_K6_1_2_3_4_7_8_9] ON [dbo].[bbs_PropUseHistory]
(
	[usetime] ASC,
	[userid] ASC
)
INCLUDE ( 	[Id],
	[topicid],
	[postid],
	[propid],
	[nickname],
	[AccepterId],
	[AccepterNickName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_bbs_PropUseHistory]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_bbs_PropUseHistory] ON [dbo].[bbs_PropUseHistory]
(
	[topicid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_bbs_user]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_bbs_user] ON [dbo].[bbs_user]
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_houseid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_houseid] ON [dbo].[bbs_visitRecord]
(
	[hostuserid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_adddate]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_adddate] ON [dbo].[cah_manage]
(
	[adddate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_autohomeprop_5_296036486__K2_1_6_180]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_autohomeprop_5_296036486__K2_1_6_180] ON [dbo].[car_autohomeprop]
(
	[carid] ASC
)
INCLUDE ( 	[id],
	[p2],
	[p176]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_autohomeprop_5_296036486__K2_6_35_197]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_autohomeprop_5_296036486__K2_6_35_197] ON [dbo].[car_autohomeprop]
(
	[carid] ASC
)
INCLUDE ( 	[p2],
	[p31],
	[p193]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_car_autohomeprop_carid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_car_autohomeprop_carid] ON [dbo].[car_autohomeprop]
(
	[carid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_car_autohomeprop_id]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_car_autohomeprop_id] ON [dbo].[car_autohomeprop]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_car_baikeRefrence]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_car_baikeRefrence] ON [dbo].[car_baikeRefrence]
(
	[isdelete] ASC,
	[baikeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_car_baikeRelatedmodel]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_car_baikeRelatedmodel] ON [dbo].[car_baikeRelatedmodel]
(
	[isdelete] ASC,
	[baikeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_car_baikeTitle]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_car_baikeTitle] ON [dbo].[car_baikeTitle]
(
	[isdelete] ASC,
	[hascontent] ASC,
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_car_cacc_5_1605580758__K1_3]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_cacc_5_1605580758__K1_3] ON [dbo].[car_cacc]
(
	[catalogid] ASC
)
INCLUDE ( 	[fatherid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_cacc_5_1605580758__K1_K3_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_cacc_5_1605580758__K1_K3_5] ON [dbo].[car_cacc]
(
	[catalogid] ASC,
	[fatherid] ASC
)
INCLUDE ( 	[path]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_cacc_5_1605580758__K12_K32_1_2_5_20]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_cacc_5_1605580758__K12_K32_1_2_5_20] ON [dbo].[car_cacc]
(
	[isdelete] ASC,
	[pathlevel] ASC
)
INCLUDE ( 	[catalogid],
	[catalogname],
	[path],
	[carkey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_cacc_5_1605580758__K2_1_5_20]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_cacc_5_1605580758__K2_1_5_20] ON [dbo].[car_cacc]
(
	[catalogname] ASC
)
INCLUDE ( 	[catalogid],
	[path],
	[carkey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_cacc_5_1605580758__K3_K12_K1_2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_cacc_5_1605580758__K3_K12_K1_2] ON [dbo].[car_cacc]
(
	[fatherid] ASC,
	[isdelete] ASC,
	[catalogid] ASC
)
INCLUDE ( 	[catalogname]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [cc1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [cc1] ON [dbo].[car_cacc]
(
	[isLive] ASC,
	[pathlevel] ASC
)
INCLUDE ( 	[catalogid],
	[fatherid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_car_cacc]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_car_cacc] ON [dbo].[car_cacc]
(
	[catalogid] ASC,
	[fatherid] ASC,
	[isdelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_car_catalog_5_1605580758__K1_3]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_catalog_5_1605580758__K1_3] ON [dbo].[car_catalog]
(
	[catalogid] ASC
)
INCLUDE ( 	[fatherid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_catalog_5_1605580758__K1_K3_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_catalog_5_1605580758__K1_K3_5] ON [dbo].[car_catalog]
(
	[catalogid] ASC,
	[fatherid] ASC
)
INCLUDE ( 	[path]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_catalog_5_1605580758__K12_K32_1_2_5_20]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_catalog_5_1605580758__K12_K32_1_2_5_20] ON [dbo].[car_catalog]
(
	[isdelete] ASC,
	[pathlevel] ASC
)
INCLUDE ( 	[catalogid],
	[catalogname],
	[path],
	[carkey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_catalog_5_1605580758__K2_1_5_20]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_catalog_5_1605580758__K2_1_5_20] ON [dbo].[car_catalog]
(
	[catalogname] ASC
)
INCLUDE ( 	[catalogid],
	[path],
	[carkey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_catalog_5_1605580758__K3_K12_K1_2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_catalog_5_1605580758__K3_K12_K1_2] ON [dbo].[car_catalog]
(
	[fatherid] ASC,
	[isdelete] ASC,
	[catalogid] ASC
)
INCLUDE ( 	[catalogname]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [cc1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [cc1] ON [dbo].[car_catalog]
(
	[isLive] ASC,
	[pathlevel] ASC
)
INCLUDE ( 	[catalogid],
	[fatherid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_car_catalog]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_car_catalog] ON [dbo].[car_catalog]
(
	[catalogid] ASC,
	[fatherid] ASC,
	[isdelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_car_catalogtemp_5_1605580758__K1_3]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_catalogtemp_5_1605580758__K1_3] ON [dbo].[car_catalognew]
(
	[catalogid] ASC
)
INCLUDE ( 	[fatherid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_catalogtemp_5_1605580758__K1_K3_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_catalogtemp_5_1605580758__K1_K3_5] ON [dbo].[car_catalognew]
(
	[catalogid] ASC,
	[fatherid] ASC
)
INCLUDE ( 	[path]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_catalogtemp_5_1605580758__K12_K32_1_2_5_20]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_catalogtemp_5_1605580758__K12_K32_1_2_5_20] ON [dbo].[car_catalognew]
(
	[isdelete] ASC,
	[pathlevel] ASC
)
INCLUDE ( 	[catalogid],
	[catalogname],
	[path],
	[carkey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_catalogtemp_5_1605580758__K2_1_5_20]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_catalogtemp_5_1605580758__K2_1_5_20] ON [dbo].[car_catalognew]
(
	[catalogname] ASC
)
INCLUDE ( 	[catalogid],
	[path],
	[carkey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_catalogtemp_5_1605580758__K3_K12_K1_2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_catalogtemp_5_1605580758__K3_K12_K1_2] ON [dbo].[car_catalognew]
(
	[fatherid] ASC,
	[isdelete] ASC,
	[catalogid] ASC
)
INCLUDE ( 	[catalogname]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [cc3]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [cc3] ON [dbo].[car_catalognew]
(
	[iway] ASC,
	[pathlevel] ASC
)
INCLUDE ( 	[fatherid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ijibie]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [ijibie] ON [dbo].[car_catalognew]
(
	[jibie] ASC
)
INCLUDE ( 	[fatherid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ileixing]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [ileixing] ON [dbo].[car_catalognew]
(
	[leixing] ASC
)
INCLUDE ( 	[fatherid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ilivepathlevel]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [ilivepathlevel] ON [dbo].[car_catalognew]
(
	[isLive] ASC,
	[pathlevel] ASC
)
INCLUDE ( 	[catalogid],
	[fatherid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_car_catalogtemp]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_car_catalogtemp] ON [dbo].[car_catalognew]
(
	[catalogid] ASC,
	[fatherid] ASC,
	[isdelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_comment_5_1036895111__K2_K15_1_3_4_5_6_7_8_9_10_11_12_13_17]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_comment_5_1036895111__K2_K15_1_3_4_5_6_7_8_9_10_11_12_13_17] ON [dbo].[car_comment]
(
	[carid] ASC,
	[isdisplay] ASC
)
INCLUDE ( 	[id],
	[msgtype],
	[isbright],
	[isdelete],
	[postername],
	[message],
	[adddate],
	[sortid],
	[nickname],
	[isaccess],
	[support],
	[oppose],
	[city]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_comparecomment_5_493661252__K2_K3_K8_1_4_5_6_7_9_10]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_comparecomment_5_493661252__K2_K3_K8_1_4_5_6_7_9_10] ON [dbo].[car_comparecomment]
(
	[carid] ASC,
	[comparecarid] ASC,
	[sortid] ASC
)
INCLUDE ( 	[id],
	[isdelete],
	[postname],
	[message],
	[adddate],
	[nickname],
	[isaccess]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_car_detialnews]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_car_detialnews] ON [dbo].[car_detialnews]
(
	[serialid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_car_Info_5_1333579789__K2_1_3_4_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_car_Info_5_1333579789__K2_1_3_4_5] ON [dbo].[car_Info]
(
	[catalogid] ASC
)
INCLUDE ( 	[id],
	[introduction],
	[advantage],
	[disadvantage]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_car_propertyExplain]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_car_propertyExplain] ON [dbo].[car_propertyExplain]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [<Name of Missing Index, sysname,>]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [dbo].[dea_bbsposts1]
(
	[eid] ASC,
	[isdelete] ASC
)
INCLUDE ( 	[tid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [dbp1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [dbp1] ON [dbo].[dea_bbsposts1]
(
	[tid] ASC,
	[isdelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [dbt1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [dbt1] ON [dbo].[dea_bbstopics]
(
	[eid] ASC,
	[isdelete] ASC
)
INCLUDE ( 	[tid],
	[displayorder],
	[lastpostdatetime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [dbyy_i1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [dbyy_i1] ON [dbo].[dea_byyuyue]
(
	[eid] ASC,
	[isdelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dea_click]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_click] ON [dbo].[dea_click]
(
	[id] ASC,
	[clicktype] ASC,
	[deaid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dea_contact]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_contact] ON [dbo].[dea_contact]
(
	[id] ASC,
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_dea_dealerinfo_5_597433748__K2_K1_3_4]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_dealerinfo_5_597433748__K2_K1_3_4] ON [dbo].[dea_dealerinfo]
(
	[eid] ASC,
	[infoid] ASC
)
INCLUDE ( 	[isdelete],
	[address]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_dea_dealerinfo_5_597433748__K2_K1_3_4_10_1912]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_dealerinfo_5_597433748__K2_K1_3_4_10_1912] ON [dbo].[dea_dealerinfo]
(
	[eid] ASC,
	[infoid] ASC
)
INCLUDE ( 	[isdelete],
	[address],
	[salephone]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dea_dealerinfo]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_dealerinfo] ON [dbo].[dea_dealerinfo]
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_dea_dealers_5_151528169__K11_K1_K3]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_dealers_5_151528169__K11_K1_K3] ON [dbo].[dea_dealers]
(
	[isdelete] ASC,
	[eid] ASC,
	[areaid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_dea_dealers_5_151528169__K11_K2_K3_K1_6_17]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_dealers_5_151528169__K11_K2_K3_K1_6_17] ON [dbo].[dea_dealers]
(
	[isdelete] ASC,
	[paylevel] ASC,
	[areaid] ASC,
	[eid] ASC
)
INCLUDE ( 	[mainbrand],
	[is4s]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_dea_dealers_5_151528169__K11_K3_K1_K2_K17]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_dealers_5_151528169__K11_K3_K1_K2_K17] ON [dbo].[dea_dealers]
(
	[isdelete] ASC,
	[areaid] ASC,
	[eid] ASC,
	[paylevel] ASC,
	[is4s] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_dea_dealers_5_151528169__K17_K1_K11_K6]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_dealers_5_151528169__K17_K1_K11_K6] ON [dbo].[dea_dealers]
(
	[is4s] ASC,
	[eid] ASC,
	[isdelete] ASC,
	[mainbrand] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_dea_dealers_5_151528169__K3_K6_K1_2_8_11_14_17]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_dealers_5_151528169__K3_K6_K1_2_8_11_14_17] ON [dbo].[dea_dealers]
(
	[areaid] ASC,
	[mainbrand] ASC,
	[eid] ASC
)
INCLUDE ( 	[paylevel],
	[ename],
	[isdelete],
	[telephone],
	[is4s]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_dea_dealers_5_158480189__K11_1_8]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_dealers_5_158480189__K11_1_8] ON [dbo].[dea_dealers]
(
	[isdelete] ASC
)
INCLUDE ( 	[eid],
	[ename]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_dea_dealers_5_158480189__K11_K2_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_dealers_5_158480189__K11_K2_K1] ON [dbo].[dea_dealers]
(
	[isdelete] ASC,
	[paylevel] ASC,
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [dd2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [dd2] ON [dbo].[dea_dealers]
(
	[isdelete] ASC
)
INCLUDE ( 	[eid],
	[paylevel],
	[areaid],
	[mainbrand],
	[ename],
	[is4s]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [dea1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [dea1] ON [dbo].[dea_dealers]
(
	[isdelete] ASC
)
INCLUDE ( 	[eid],
	[bmbasiccount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dea_employee]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_employee] ON [dbo].[dea_employee]
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_eidplaceid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_Table_eidplaceid] ON [dbo].[dea_focusimg]
(
	[eid] ASC,
	[placeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dea_menurelated]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_menurelated] ON [dbo].[dea_menurelated]
(
	[menuid] ASC,
	[modelid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_dea_menusetting_5_165432209__K2_K1_K3_K4_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_menusetting_5_165432209__K2_K1_K3_K4_5] ON [dbo].[dea_menusetting]
(
	[eid] ASC,
	[id] ASC,
	[menuid] ASC,
	[sortid] ASC
)
INCLUDE ( 	[showname]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dea_menusetting]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_menusetting] ON [dbo].[dea_menusetting]
(
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_dea_news_5_2136915230__K2_K9_K1_K7_3_4_5_6_8_10_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_news_5_2136915230__K2_K9_K1_K7_3_4_5_6_8_10_11] ON [dbo].[dea_news]
(
	[eid] ASC,
	[isdelete] ASC,
	[newsid] ASC,
	[publishdate] ASC
)
INCLUDE ( 	[typeid],
	[views],
	[hotsortid],
	[adddate],
	[hotdate],
	[ishot],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_dea_news_5_2136915230__K9_K3_K7_1_2_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_news_5_2136915230__K9_K3_K7_1_2_11] ON [dbo].[dea_news]
(
	[isdelete] ASC,
	[typeid] ASC,
	[publishdate] ASC
)
INCLUDE ( 	[newsid],
	[eid],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [dn1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [dn1] ON [dbo].[dea_news]
(
	[eid] ASC,
	[isdelete] ASC
)
INCLUDE ( 	[newsid],
	[typeid],
	[views],
	[hotsortid],
	[adddate],
	[publishdate],
	[hotdate],
	[ishot],
	[title],
	[bbstopicpostid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dea_news]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_news] ON [dbo].[dea_news]
(
	[eid] ASC,
	[typeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dea_ordercar]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_ordercar] ON [dbo].[dea_ordercar]
(
	[eid] ASC,
	[ordertype] ASC,
	[carid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dea_qaonline]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_qaonline] ON [dbo].[dea_qaonline]
(
	[eid] ASC,
	[carid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_dea_scoresSort_5_1239532045__K2_6_7]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_scoresSort_5_1239532045__K2_6_7] ON [dbo].[dea_scoresSort]
(
	[eid] ASC
)
INCLUDE ( 	[sdate],
	[edate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_dea_smsnotice]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_smsnotice] ON [dbo].[dea_smsnotice]
(
	[id] ASC,
	[eid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_dea_storedisplay_5_1304912266__K6_K2_1_3_4_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_dea_storedisplay_5_1304912266__K6_K2_1_3_4_5] ON [dbo].[dea_storedisplay]
(
	[eid] ASC,
	[sortid] ASC
)
INCLUDE ( 	[picid],
	[title],
	[path],
	[isdelete]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_dea_namepass]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_dea_namepass] ON [dbo].[dea_users]
(
	[username] ASC,
	[password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [dwal_I1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [dwal_I1] ON [dbo].[dea_wxaccesslog]
(
	[accdate] ASC
)
INCLUDE ( 	[eid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [dsd_I1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [dsd_I1] ON [dbo].[dwr_stat_daily]
(
	[eid] ASC,
	[statdate] ASC
)
INCLUDE ( 	[ShareCount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_ent_product_5_40907763__K2_K3_K4_K5_K1_K14_6_7_8_9_10_11_12_13_20_21]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_ent_product_5_40907763__K2_K3_K4_K5_K1_K14_6_7_8_9_10_11_12_13_20_21] ON [dbo].[ent_product]
(
	[E_id] ASC,
	[isdelete] ASC,
	[typeid] ASC,
	[type] ASC,
	[id] ASC,
	[updatedate] ASC
)
INCLUDE ( 	[isRecommended],
	[pricesSort],
	[sortId],
	[price],
	[offersprice],
	[name],
	[photo],
	[adddate],
	[discountinfo],
	[hotdate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_ent_product_5_40907763__K2_K7_K1_4_6_9_12_13_14_20_21]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_ent_product_5_40907763__K2_K7_K1_4_6_9_12_13_14_20_21] ON [dbo].[ent_product]
(
	[E_id] ASC,
	[pricesSort] ASC,
	[id] ASC
)
INCLUDE ( 	[typeid],
	[isRecommended],
	[price],
	[photo],
	[adddate],
	[updatedate],
	[discountinfo],
	[hotdate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_ent_product_5_40907763__K4_K7_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_ent_product_5_40907763__K4_K7_K1] ON [dbo].[ent_product]
(
	[typeid] ASC,
	[pricesSort] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_ent_product_5_40907763__K4_K7_K1_K14_2_6_9]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_ent_product_5_40907763__K4_K7_K1_K14_2_6_9] ON [dbo].[ent_product]
(
	[typeid] ASC,
	[pricesSort] ASC,
	[id] ASC,
	[updatedate] ASC
)
INCLUDE ( 	[E_id],
	[isRecommended],
	[price]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_ent_product_5_40907763__K7_K8D_K2_1_4_9_10_11_12_13_14]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_ent_product_5_40907763__K7_K8D_K2_1_4_9_10_11_12_13_14] ON [dbo].[ent_product]
(
	[pricesSort] ASC,
	[sortId] DESC,
	[E_id] ASC
)
INCLUDE ( 	[id],
	[typeid],
	[price],
	[offersprice],
	[name],
	[photo],
	[adddate],
	[updatedate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ent_product_eid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_ent_product_eid] ON [dbo].[ent_product]
(
	[E_id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_ent_product_prices]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_ent_product_prices] ON [dbo].[ent_product]
(
	[pricesSort] ASC,
	[updatedate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_ent_product_typeid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_ent_product_typeid] ON [dbo].[ent_product]
(
	[typeid] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_content_5_2069582411__K12D_K1D_K13_K14_K9_2_3_5_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_content_5_2069582411__K12D_K1D_K13_K14_K9_2_3_5_11] ON [dbo].[img_content]
(
	[totopdate] DESC,
	[id] DESC,
	[catalogid] ASC,
	[type] ASC,
	[isDelete] ASC
)
INCLUDE ( 	[titleId],
	[title],
	[path],
	[serialType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_content_5_2069582411__K13_K1_K9_K14_K12_2_3_5_10_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_content_5_2069582411__K13_K1_K9_K14_K12_2_3_5_10_11] ON [dbo].[img_content]
(
	[catalogid] ASC,
	[id] ASC,
	[isDelete] ASC,
	[type] ASC,
	[totopdate] ASC
)
INCLUDE ( 	[titleId],
	[title],
	[path],
	[contentPage],
	[serialType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_img_content_5_2069582411__K13_K9_K14_K1_12]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_content_5_2069582411__K13_K9_K14_K1_12] ON [dbo].[img_content]
(
	[catalogid] ASC,
	[isDelete] ASC,
	[type] ASC,
	[id] ASC
)
INCLUDE ( 	[totopdate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_content_5_2069582411__K2_K9_K1_K12_3_5_11_14]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_content_5_2069582411__K2_K9_K1_K12_3_5_11_14] ON [dbo].[img_content]
(
	[titleId] ASC,
	[isDelete] ASC,
	[id] ASC,
	[totopdate] ASC
)
INCLUDE ( 	[title],
	[path],
	[serialType],
	[type]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_content_5_2069582411__K2_K9_K12_K1_5_4149]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_content_5_2069582411__K2_K9_K12_K1_5_4149] ON [dbo].[img_content]
(
	[titleId] ASC,
	[isDelete] ASC,
	[totopdate] ASC,
	[id] ASC
)
INCLUDE ( 	[path]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_content_5_2069582411__K9_K13_K14_K1_K12_2_3_5_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_content_5_2069582411__K9_K13_K14_K1_K12_2_3_5_11] ON [dbo].[img_content]
(
	[isDelete] ASC,
	[catalogid] ASC,
	[type] ASC,
	[id] ASC,
	[totopdate] ASC
)
INCLUDE ( 	[titleId],
	[title],
	[path],
	[serialType]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_content_5_2069582411__K9_K2_K12_K1_3_5_11_14_8066]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_content_5_2069582411__K9_K2_K12_K1_3_5_11_14_8066] ON [dbo].[img_content]
(
	[isDelete] ASC,
	[titleId] ASC,
	[totopdate] ASC,
	[id] ASC
)
INCLUDE ( 	[title],
	[path],
	[serialType],
	[type]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_content]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_content] ON [dbo].[img_content]
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_content_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_img_content_1] ON [dbo].[img_content]
(
	[totopdate] DESC,
	[id] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_content_2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_img_content_2] ON [dbo].[img_content]
(
	[isDelete] ASC,
	[catalogid] ASC,
	[type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_content_titleId]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_content_titleId] ON [dbo].[img_content]
(
	[id] ASC,
	[titleId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newContent_5_1259151531__K2_K9_K1_K8_3_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newContent_5_1259151531__K2_K9_K1_K8_3_5] ON [dbo].[img_newContent]
(
	[titleId] ASC,
	[isDelete] ASC,
	[id] ASC,
	[sortId] ASC
)
INCLUDE ( 	[title],
	[path]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newContent_5_1259151531__K9_K2_K8_5_2533]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newContent_5_1259151531__K9_K2_K8_5_2533] ON [dbo].[img_newContent]
(
	[isDelete] ASC,
	[titleId] ASC,
	[sortId] ASC
)
INCLUDE ( 	[path]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_newContent]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_newContent] ON [dbo].[img_newContent]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_newContent_sortId]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_img_newContent_sortId] ON [dbo].[img_newContent]
(
	[sortId] ASC,
	[titleId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_newContent_titleId]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_newContent_titleId] ON [dbo].[img_newContent]
(
	[id] ASC,
	[titleId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K1_2_3_4_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K1_2_3_4_11] ON [dbo].[img_newTitle]
(
	[id] ASC
)
INCLUDE ( 	[catalogId],
	[toTop],
	[toSink],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K1_K7_K9_K10_K2_3_4_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K1_K7_K9_K10_K2_3_4_11] ON [dbo].[img_newTitle]
(
	[id] ASC,
	[contentId] ASC,
	[type] ASC,
	[isDelete] ASC,
	[catalogId] ASC
)
INCLUDE ( 	[toTop],
	[toSink],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K10_K9_K2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K10_K9_K2] ON [dbo].[img_newTitle]
(
	[isDelete] ASC,
	[type] ASC,
	[catalogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K10_K9_K2_K6_1_3_4_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K10_K9_K2_K6_1_3_4_11] ON [dbo].[img_newTitle]
(
	[isDelete] ASC,
	[type] ASC,
	[catalogId] ASC,
	[sinkTime] ASC
)
INCLUDE ( 	[id],
	[toTop],
	[toSink],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K3D_K1D_K2_K10_K9_4_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K3D_K1D_K2_K10_K9_4_11] ON [dbo].[img_newTitle]
(
	[toTop] DESC,
	[id] DESC,
	[catalogId] ASC,
	[isDelete] ASC,
	[type] ASC
)
INCLUDE ( 	[toSink],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K4D_K1D_K2_K10_K9_3_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K4D_K1D_K2_K10_K9_3_11] ON [dbo].[img_newTitle]
(
	[toSink] DESC,
	[id] DESC,
	[catalogId] ASC,
	[isDelete] ASC,
	[type] ASC
)
INCLUDE ( 	[toTop],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K5D_K2_K10_K9_1_3_4_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K5D_K2_K10_K9_1_3_4_11] ON [dbo].[img_newTitle]
(
	[topTime] DESC,
	[catalogId] ASC,
	[isDelete] ASC,
	[type] ASC
)
INCLUDE ( 	[id],
	[toTop],
	[toSink],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K6D_K2_K10_K9_1_3_4_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K6D_K2_K10_K9_1_3_4_11] ON [dbo].[img_newTitle]
(
	[sinkTime] DESC,
	[catalogId] ASC,
	[isDelete] ASC,
	[type] ASC
)
INCLUDE ( 	[id],
	[toTop],
	[toSink],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K9_K10_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K9_K10_K1] ON [dbo].[img_newTitle]
(
	[type] ASC,
	[isDelete] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K9_K10_K2_K1_K7_3_4_5_6_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K9_K10_K2_K1_K7_3_4_5_6_11] ON [dbo].[img_newTitle]
(
	[type] ASC,
	[isDelete] ASC,
	[catalogId] ASC,
	[id] ASC,
	[contentId] ASC
)
INCLUDE ( 	[toTop],
	[toSink],
	[topTime],
	[sinkTime],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_newTitle_5_1035150733__K9_K10_K2_K5_1_3_4_11]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_newTitle_5_1035150733__K9_K10_K2_K5_1_3_4_11] ON [dbo].[img_newTitle]
(
	[type] ASC,
	[isDelete] ASC,
	[catalogId] ASC,
	[topTime] ASC
)
INCLUDE ( 	[id],
	[toTop],
	[toSink],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_newTitle]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_newTitle] ON [dbo].[img_newTitle]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_newTitle_sinkTime]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_newTitle_sinkTime] ON [dbo].[img_newTitle]
(
	[id] ASC,
	[sinkTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_newTitle_topTime]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_newTitle_topTime] ON [dbo].[img_newTitle]
(
	[id] ASC,
	[topTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_newTitle_toSink]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_newTitle_toSink] ON [dbo].[img_newTitle]
(
	[id] ASC,
	[toSink] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_newTitle_toTop]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_newTitle_toTop] ON [dbo].[img_newTitle]
(
	[id] ASC,
	[toTop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_newTitle_type]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_newTitle_type] ON [dbo].[img_newTitle]
(
	[id] ASC,
	[type] ASC,
	[catalogId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_title_5_1781437966__K1_K4_K12_K2_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_title_5_1781437966__K1_K4_K12_K2_5] ON [dbo].[img_title]
(
	[id] ASC,
	[type] ASC,
	[isDelete] ASC,
	[catalogId] ASC
)
INCLUDE ( 	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_title_5_1781437966__K12_K4_K2_K1_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_title_5_1781437966__K12_K4_K2_K1_5] ON [dbo].[img_title]
(
	[isDelete] ASC,
	[type] ASC,
	[catalogId] ASC,
	[id] ASC
)
INCLUDE ( 	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_img_title_5_1781437966__K4_K12_K2_K1_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_img_title_5_1781437966__K4_K12_K2_K1_5] ON [dbo].[img_title]
(
	[type] ASC,
	[isDelete] ASC,
	[catalogId] ASC,
	[id] ASC
)
INCLUDE ( 	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_title]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_title] ON [dbo].[img_title]
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_title_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_img_title_1] ON [dbo].[img_title]
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_img_title_type]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_img_title_type] ON [dbo].[img_title]
(
	[id] ASC,
	[type] ASC,
	[catalogId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_kan_bbshistory]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_kan_bbshistory] ON [dbo].[kan_bbshistory]
(
	[id] ASC,
	[userid] ASC,
	[baomingdate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_kan_groupbuy_5_1509436997__K2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_kan_groupbuy_5_1509436997__K2] ON [dbo].[kan_groupbuy]
(
	[serialid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_kan_groupbuy]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_kan_groupbuy] ON [dbo].[kan_groupbuy]
(
	[id] ASC,
	[serialid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_kan_push]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_kan_push] ON [dbo].[kan_push]
(
	[id] ASC,
	[areaid] ASC,
	[brandid] ASC,
	[serialid] ASC,
	[type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_kan_serial]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_kan_serial] ON [dbo].[kan_serial]
(
	[id] ASC,
	[carid] ASC,
	[brandid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_kan_tempkeyword_5_350480873__K2_1_4364]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_kan_tempkeyword_5_350480873__K2_1_4364] ON [dbo].[kan_tempkeyword]
(
	[keyword] ASC
)
INCLUDE ( 	[id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_kan_totalbaoming_5_753958308__K1_K12_6]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_kan_totalbaoming_5_753958308__K1_K12_6] ON [dbo].[kan_totalbaoming]
(
	[id] ASC,
	[carinmind] ASC
)
INCLUDE ( 	[phonearea]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_kan_totalbaoming_5_753958308__K10_1_2_3_4_5_6_7_8_9_11_12_13_14_15_16_17_18]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_kan_totalbaoming_5_753958308__K10_1_2_3_4_5_6_7_8_9_11_12_13_14_15_16_17_18] ON [dbo].[kan_totalbaoming]
(
	[phone] ASC
)
INCLUDE ( 	[id],
	[activetype],
	[sex],
	[hasbuy],
	[paymonth],
	[phonearea],
	[area],
	[buytimeinmind],
	[birthday],
	[username],
	[carinmind],
	[comefrominfo],
	[address],
	[followlog],
	[baomingdate],
	[isdelete],
	[state]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_kan_totalbaoming_5_753958308__K10_K11_1_12]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_kan_totalbaoming_5_753958308__K10_K11_1_12] ON [dbo].[kan_totalbaoming]
(
	[phone] ASC,
	[username] ASC
)
INCLUDE ( 	[id],
	[carinmind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_kan_totalbaoming_5_753958308__K16D_K17_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_18_21_22_23_24]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_kan_totalbaoming_5_753958308__K16D_K17_1_2_3_4_5_6_7_8_9_10_11_12_13_14_15_18_21_22_23_24] ON [dbo].[kan_totalbaoming]
(
	[baomingdate] DESC,
	[isdelete] ASC
)
INCLUDE ( 	[id],
	[activetype],
	[sex],
	[hasbuy],
	[paymonth],
	[phonearea],
	[area],
	[buytimeinmind],
	[birthday],
	[phone],
	[username],
	[carinmind],
	[comefrominfo],
	[address],
	[followlog],
	[state],
	[areaid],
	[brandid],
	[buymodel],
	[serialid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_kan_totalbaoming_5_753958308__K21_K7]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_kan_totalbaoming_5_753958308__K21_K7] ON [dbo].[kan_totalbaoming]
(
	[areaid] ASC,
	[area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_kan_totalbaoming_5_753958308__K22_K12]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_kan_totalbaoming_5_753958308__K22_K12] ON [dbo].[kan_totalbaoming]
(
	[brandid] ASC,
	[carinmind] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_kan_totalbaoming_5_753958308__K24_K12]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_kan_totalbaoming_5_753958308__K24_K12] ON [dbo].[kan_totalbaoming]
(
	[serialid] ASC,
	[carinmind] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_kan_totalbaoming_5_753958308__K7_K21_12]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_kan_totalbaoming_5_753958308__K7_K21_12] ON [dbo].[kan_totalbaoming]
(
	[area] ASC,
	[areaid] ASC
)
INCLUDE ( 	[carinmind]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ktb1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [ktb1] ON [dbo].[kan_totalbaoming]
(
	[brandid] ASC
)
INCLUDE ( 	[phonearea],
	[phone],
	[username],
	[baomingdate],
	[areaid],
	[serialid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ktbm1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [ktbm1] ON [dbo].[kan_totalbaoming]
(
	[isdelete] ASC
)
INCLUDE ( 	[phone],
	[baomingdate],
	[brandid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ktbm2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [ktbm2] ON [dbo].[kan_totalbaoming]
(
	[serialid] ASC
)
INCLUDE ( 	[baomingdate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [ktbm3]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [ktbm3] ON [dbo].[kan_totalbaoming]
(
	[isdelete] ASC
)
INCLUDE ( 	[phonearea],
	[phone],
	[baomingdate],
	[areaid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_key_answer_5_837434603__K2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_answer_5_837434603__K2] ON [dbo].[key_answer]
(
	[questionid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_key_answer_5_837434603__K2_K11_K1_5_7_8_9_10]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_answer_5_837434603__K2_K11_K1_5_7_8_9_10] ON [dbo].[key_answer]
(
	[questionid] ASC,
	[isshielded] ASC,
	[id] ASC
)
INCLUDE ( 	[isdelete],
	[nickname],
	[addtime],
	[username],
	[Acontent]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_key_answer_5_837434603__K2_K8_7]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_answer_5_837434603__K2_K8_7] ON [dbo].[key_answer]
(
	[questionid] ASC,
	[addtime] ASC
)
INCLUDE ( 	[nickname]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_key_answer]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_key_answer] ON [dbo].[key_answer]
(
	[id] ASC,
	[questionid] ASC,
	[userid] ASC,
	[isdelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_key_keyhot_5_743530278__K3_K4_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_keyhot_5_743530278__K3_K4_K1] ON [dbo].[key_keyhot]
(
	[canquestions] ASC,
	[keyword] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_key_questions_5_1903866395__K10D_K9D_K3_K6_1_7_8]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_questions_5_1903866395__K10D_K9D_K3_K6_1_7_8] ON [dbo].[key_questions]
(
	[browses] DESC,
	[addtime] DESC,
	[serialid] ASC,
	[isdelete] ASC
)
INCLUDE ( 	[id],
	[nickname],
	[qcontent]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_key_questions_5_1903866395__K3_K6]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_questions_5_1903866395__K3_K6] ON [dbo].[key_questions]
(
	[serialid] ASC,
	[isdelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_key_questions_5_1903866395__K3_K6_K1_8_9_10]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_questions_5_1903866395__K3_K6_K1_8_9_10] ON [dbo].[key_questions]
(
	[serialid] ASC,
	[isdelete] ASC,
	[id] ASC
)
INCLUDE ( 	[qcontent],
	[addtime],
	[browses]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_key_questions_5_1903866395__K3_K6_K1_K10_K9_7_8]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_questions_5_1903866395__K3_K6_K1_K10_K9_7_8] ON [dbo].[key_questions]
(
	[serialid] ASC,
	[isdelete] ASC,
	[id] ASC,
	[browses] ASC,
	[addtime] ASC
)
INCLUDE ( 	[nickname],
	[qcontent]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_key_questions_5_1903866395__K3_K6_K10_K9_1_7_8]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_questions_5_1903866395__K3_K6_K10_K9_1_7_8] ON [dbo].[key_questions]
(
	[serialid] ASC,
	[isdelete] ASC,
	[browses] ASC,
	[addtime] ASC
)
INCLUDE ( 	[id],
	[nickname],
	[qcontent]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_key_questions_5_1903866395__K6_K1_K3_8_9]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_questions_5_1903866395__K6_K1_K3_8_9] ON [dbo].[key_questions]
(
	[isdelete] ASC,
	[id] ASC,
	[serialid] ASC
)
INCLUDE ( 	[qcontent],
	[addtime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_key_questions_5_1903866395__K6_K3_K1_K14_13]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_questions_5_1903866395__K6_K3_K1_K14_13] ON [dbo].[key_questions]
(
	[isdelete] ASC,
	[serialid] ASC,
	[id] ASC,
	[answertime] ASC
)
INCLUDE ( 	[answerCount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [kq1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [kq1] ON [dbo].[key_questions]
(
	[serialid] ASC,
	[isdelete] ASC
)
INCLUDE ( 	[id],
	[nickname],
	[qcontent],
	[addtime],
	[browses],
	[answerCount],
	[answertime],
	[anickname]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_key_relatedsearch]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_key_relatedsearch] ON [dbo].[key_relatedsearch]
(
	[dealstate] ASC,
	[hascontent] ASC,
	[updatetime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_key_relatedsearch_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_key_relatedsearch_1] ON [dbo].[key_relatedsearch]
(
	[keywords] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_playlevel]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_playlevel] ON [dbo].[key_relatedsearch]
(
	[playlevel] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_key_searchcontent_5_2092130794__K3_K1_2_4_5_6_9987]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_key_searchcontent_5_2092130794__K3_K1_2_4_5_6_9987] ON [dbo].[key_searchcontent]
(
	[keywords] ASC,
	[id] ASC
)
INCLUDE ( 	[newsid],
	[title],
	[link],
	[adddate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_key_searchcontent]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_key_searchcontent] ON [dbo].[key_searchcontent]
(
	[keywords] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_Lib_linkData_5_1023199291__K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_Lib_linkData_5_1023199291__K1] ON [dbo].[Lib_linkData]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_mbg_content]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_mbg_content] ON [dbo].[mbg_content]
(
	[id] ASC,
	[uid] ASC,
	[addtime] DESC,
	[forwardform] ASC,
	[replyid] ASC,
	[forwardroot] ASC,
	[type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_mbg_followinfo]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_mbg_followinfo] ON [dbo].[mbg_followinfo]
(
	[id] ASC,
	[uid] ASC,
	[fansuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_mbg_mentions]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_mbg_mentions] ON [dbo].[mbg_mentions]
(
	[mentioneduid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_mbg_temp]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_mbg_temp] ON [dbo].[mbg_temp]
(
	[id] ASC,
	[blogid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_mbg_users_5_811006516__K2_K3_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_mbg_users_5_811006516__K2_K3_1] ON [dbo].[mbg_users]
(
	[usertype] ASC,
	[keyid] ASC
)
INCLUDE ( 	[id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_mbg_users]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_mbg_users] ON [dbo].[mbg_users]
(
	[id] ASC,
	[usertype] ASC,
	[keyid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_keyid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_Table_keyid] ON [dbo].[msg_1]
(
	[keyid] ASC,
	[msgstate] ASC,
	[sortid] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_Table_keyid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_Table_keyid] ON [dbo].[msg_2]
(
	[keyid] ASC,
	[msgstate] ASC,
	[sortid] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [nb1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [nb1] ON [dbo].[new_cache]
(
	[brandid] ASC
)
INCLUDE ( 	[newsid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [nc1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [nc1] ON [dbo].[new_cache]
(
	[newscatalogid] ASC,
	[carcatalogid] ASC
)
INCLUDE ( 	[newsid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [new_carcatalogid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [new_carcatalogid] ON [dbo].[new_cache]
(
	[carcatalogid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [new_newcatalogid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [new_newcatalogid] ON [dbo].[new_cache]
(
	[newscatalogid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [new_newsid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [new_newsid] ON [dbo].[new_cache]
(
	[newsid] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_catalog_fatherId]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_catalog_fatherId] ON [dbo].[new_catalog]
(
	[catalogId] ASC,
	[fatherId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_new_content_5_1435008739__K11_K4_K2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_content_5_1435008739__K11_K4_K2] ON [dbo].[new_content]
(
	[isDelete] ASC,
	[carcatalogId] ASC,
	[newsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_content_5_1435008739__K11_K6_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_content_5_1435008739__K11_K6_1] ON [dbo].[new_content]
(
	[isDelete] ASC,
	[newsKeywords] ASC
)
INCLUDE ( 	[id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_new_content_5_1435008739__K2_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_content_5_1435008739__K2_K1] ON [dbo].[new_content]
(
	[newsId] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_content_5_1435008739__K2_K10_K1_3_4_5_6_8_9_11_12_13]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_content_5_1435008739__K2_K10_K1_3_4_5_6_8_9_11_12_13] ON [dbo].[new_content]
(
	[newsId] ASC,
	[sortId] ASC,
	[id] ASC
)
INCLUDE ( 	[areaId],
	[carcatalogId],
	[newsTitle],
	[newsKeywords],
	[addDate],
	[lastUpdate],
	[isDelete],
	[titleImgPath],
	[serialid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_new_content_5_1435008739__K2_K11_K4]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_content_5_1435008739__K2_K11_K4] ON [dbo].[new_content]
(
	[newsId] ASC,
	[isDelete] ASC,
	[carcatalogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_content]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_content] ON [dbo].[new_content]
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_content_carCatalogId]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_content_carCatalogId] ON [dbo].[new_content]
(
	[carcatalogId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_content_isDelete]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_content_isDelete] ON [dbo].[new_content]
(
	[isDelete] ASC,
	[sortId] ASC,
	[newsId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_content_newsId]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_content_newsId] ON [dbo].[new_content]
(
	[id] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_content_sortId]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_content_sortId] ON [dbo].[new_content]
(
	[sortId] ASC,
	[newsId] ASC,
	[carcatalogId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_keylibrary_5_1159479705__K1_2_6]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_keylibrary_5_1159479705__K1_2_6] ON [dbo].[new_keylibrary]
(
	[id] ASC
)
INCLUDE ( 	[keywords],
	[serialid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_keylibrary_5_1159479705__K6_2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_keylibrary_5_1159479705__K6_2] ON [dbo].[new_keylibrary]
(
	[serialid] ASC
)
INCLUDE ( 	[keywords]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_new_keywordindex_5_1166483780__K1_2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_keywordindex_5_1166483780__K1_2] ON [dbo].[new_keywordindex]
(
	[keyid] ASC
)
INCLUDE ( 	[newsid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_new_keywordindex_5_1166483780__K1_2_3]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_keywordindex_5_1166483780__K1_2_3] ON [dbo].[new_keywordindex]
(
	[keyid] ASC
)
INCLUDE ( 	[newsid],
	[contentid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_new_keywordindex_5_1166483780__K3_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_keywordindex_5_1166483780__K3_1] ON [dbo].[new_keywordindex]
(
	[contentid] ASC
)
INCLUDE ( 	[keyid]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_keywordindex]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_keywordindex] ON [dbo].[new_keywordindex]
(
	[keyid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K1_K21_K2_K28_K22]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K1_K21_K2_K28_K22] ON [dbo].[new_news]
(
	[id] ASC,
	[isDelete] ASC,
	[newsCatalogId] ASC,
	[reLink] ASC,
	[sortId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K1_K21_K2_K28_K9_4149]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K1_K21_K2_K28_K9_4149] ON [dbo].[new_news]
(
	[id] ASC,
	[isDelete] ASC,
	[newsCatalogId] ASC,
	[reLink] ASC,
	[addAdmin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K1_K22_5_19]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K1_K22_5_19] ON [dbo].[new_news]
(
	[id] ASC,
	[sortId] ASC
)
INCLUDE ( 	[newsTitle],
	[addDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K1_K5_K6]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K1_K5_K6] ON [dbo].[new_news]
(
	[id] ASC,
	[newsTitle] ASC,
	[newsKeywords] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K1_K6]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K1_K6] ON [dbo].[new_news]
(
	[id] ASC,
	[newsKeywords] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K1D_K28_K2_K35_K21_2533]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K1D_K28_K2_K35_K21_2533] ON [dbo].[new_news]
(
	[id] DESC,
	[reLink] ASC,
	[newsCatalogId] ASC,
	[chktitlephoto] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K2_K21_K1_K5_K6]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K2_K21_K1_K5_K6] ON [dbo].[new_news]
(
	[newsCatalogId] ASC,
	[isDelete] ASC,
	[id] ASC,
	[newsTitle] ASC,
	[newsKeywords] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K2_K21_K1_K5_K6_9_19_20_28_29]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K2_K21_K1_K5_K6_9_19_20_28_29] ON [dbo].[new_news]
(
	[newsCatalogId] ASC,
	[isDelete] ASC,
	[id] ASC,
	[newsTitle] ASC,
	[newsKeywords] ASC
)
INCLUDE ( 	[addAdmin],
	[addDate],
	[lastUpdate],
	[reLink],
	[IsImgNews]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K2_K21_K28_K22_1_3_4_5_7_8_9_19]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K2_K21_K28_K22_1_3_4_5_7_8_9_19] ON [dbo].[new_news]
(
	[newsCatalogId] ASC,
	[isDelete] ASC,
	[reLink] ASC,
	[sortId] ASC
)
INCLUDE ( 	[id],
	[areaId],
	[carcatalogId],
	[newsTitle],
	[titlePhoto],
	[newsEditor],
	[addAdmin],
	[addDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K19_1_2_5_6_8]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K19_1_2_5_6_8] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[addDate] ASC
)
INCLUDE ( 	[id],
	[newsCatalogId],
	[newsTitle],
	[newsKeywords],
	[newsEditor]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K2_K28_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K2_K28_K1] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[newsCatalogId] ASC,
	[reLink] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K2_K28_K1_K22]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K2_K28_K1_K22] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[newsCatalogId] ASC,
	[reLink] ASC,
	[id] ASC,
	[sortId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K2_K28_K1_K22_4]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K2_K28_K1_K22_4] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[newsCatalogId] ASC,
	[reLink] ASC,
	[id] ASC,
	[sortId] ASC
)
INCLUDE ( 	[carcatalogId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K2_K28_K35_K1_3_4_9_4149]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K2_K28_K35_K1_3_4_9_4149] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[newsCatalogId] ASC,
	[reLink] ASC,
	[chktitlephoto] ASC,
	[id] ASC
)
INCLUDE ( 	[areaId],
	[carcatalogId],
	[addAdmin]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K2_K28_K9_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K2_K28_K9_K1] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[newsCatalogId] ASC,
	[reLink] ASC,
	[addAdmin] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K28_K2_K1_K22_4_5_19_34]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K28_K2_K1_K22_4_5_19_34] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[reLink] ASC,
	[newsCatalogId] ASC,
	[id] ASC,
	[sortId] ASC
)
INCLUDE ( 	[carcatalogId],
	[newsTitle],
	[addDate],
	[shortTitle]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K28_K4_K2_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K28_K4_K2_K1] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[reLink] ASC,
	[carcatalogId] ASC,
	[newsCatalogId] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K28_K4_K2_K22_1_5_19]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K28_K4_K2_K22_1_5_19] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[reLink] ASC,
	[carcatalogId] ASC,
	[newsCatalogId] ASC,
	[sortId] ASC
)
INCLUDE ( 	[id],
	[newsTitle],
	[addDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K5_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K5_1] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[newsTitle] ASC
)
INCLUDE ( 	[id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K21_K6_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K21_K6_1] ON [dbo].[new_news]
(
	[isDelete] ASC,
	[newsKeywords] ASC
)
INCLUDE ( 	[id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K22D_K28_K2_K4_K21_1_3_5_7_19]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K22D_K28_K2_K4_K21_1_3_5_7_19] ON [dbo].[new_news]
(
	[sortId] DESC,
	[reLink] ASC,
	[newsCatalogId] ASC,
	[carcatalogId] ASC,
	[isDelete] ASC
)
INCLUDE ( 	[id],
	[areaId],
	[newsTitle],
	[titlePhoto],
	[addDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K28_K2_K21_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K28_K2_K21_1] ON [dbo].[new_news]
(
	[reLink] ASC,
	[newsCatalogId] ASC,
	[isDelete] ASC
)
INCLUDE ( 	[id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K28_K2_K21_K3_K4_K22_1_5_7_8_9_19]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K28_K2_K21_K3_K4_K22_1_5_7_8_9_19] ON [dbo].[new_news]
(
	[reLink] ASC,
	[newsCatalogId] ASC,
	[isDelete] ASC,
	[areaId] ASC,
	[carcatalogId] ASC,
	[sortId] ASC
)
INCLUDE ( 	[id],
	[newsTitle],
	[titlePhoto],
	[newsEditor],
	[addAdmin],
	[addDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K28_K2_K21_K4_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K28_K2_K21_K4_K1] ON [dbo].[new_news]
(
	[reLink] ASC,
	[newsCatalogId] ASC,
	[isDelete] ASC,
	[carcatalogId] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K28_K21_K2_K1_K22_3_4_5_7_8_9_19]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K28_K21_K2_K1_K22_3_4_5_7_8_9_19] ON [dbo].[new_news]
(
	[reLink] ASC,
	[isDelete] ASC,
	[newsCatalogId] ASC,
	[id] ASC,
	[sortId] ASC
)
INCLUDE ( 	[areaId],
	[carcatalogId],
	[newsTitle],
	[titlePhoto],
	[newsEditor],
	[addAdmin],
	[addDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K28_K21_K22_1_5]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K28_K21_K22_1_5] ON [dbo].[new_news]
(
	[reLink] ASC,
	[isDelete] ASC,
	[sortId] ASC
)
INCLUDE ( 	[id],
	[newsTitle]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K3_K28_K21_K2_9987]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K3_K28_K21_K2_9987] ON [dbo].[new_news]
(
	[areaId] ASC,
	[reLink] ASC,
	[isDelete] ASC,
	[newsCatalogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K35_K21_K3_K2_K1_K28_5201]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K35_K21_K3_K2_K1_K28_5201] ON [dbo].[new_news]
(
	[chktitlephoto] ASC,
	[isDelete] ASC,
	[areaId] ASC,
	[newsCatalogId] ASC,
	[id] ASC,
	[reLink] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K5_K6_K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K5_K6_K1] ON [dbo].[new_news]
(
	[newsTitle] ASC,
	[newsKeywords] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K9]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K9] ON [dbo].[new_news]
(
	[addAdmin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K9_K21_K35_K28_K2_K1_1040]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K9_K21_K35_K28_K2_K1_1040] ON [dbo].[new_news]
(
	[addAdmin] ASC,
	[isDelete] ASC,
	[chktitlephoto] ASC,
	[reLink] ASC,
	[newsCatalogId] ASC,
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_news_5_1458104235__K9_K28_K35_K21_K1_K2_1410]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_news_5_1458104235__K9_K28_K35_K21_K1_K2_1410] ON [dbo].[new_news]
(
	[addAdmin] ASC,
	[reLink] ASC,
	[chktitlephoto] ASC,
	[isDelete] ASC,
	[id] ASC,
	[newsCatalogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_news]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_news] ON [dbo].[new_news]
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_news_addDate]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_news_addDate] ON [dbo].[new_news]
(
	[addDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_news_lastUpdate]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_news_lastUpdate] ON [dbo].[new_news]
(
	[lastUpdate] ASC,
	[newsCatalogId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_news_newsCatalogId]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_news_newsCatalogId] ON [dbo].[new_news]
(
	[sortId] ASC,
	[newsCatalogId] ASC,
	[carcatalogId] ASC,
	[areaId] ASC,
	[addDate] ASC,
	[isPhoto] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_news_newsCatalogId_id]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_news_newsCatalogId_id] ON [dbo].[new_news]
(
	[id] ASC,
	[newsCatalogId] ASC,
	[carcatalogId] ASC,
	[areaId] ASC,
	[addDate] ASC,
	[isPhoto] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_news_original]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_news_original] ON [dbo].[new_news]
(
	[sortId] ASC,
	[newsCatalogId] ASC,
	[addDate] ASC,
	[isOriginal] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [nnews1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [nnews1] ON [dbo].[new_news]
(
	[isDelete] ASC
)
INCLUDE ( 	[id],
	[newsCatalogId],
	[newsTitle],
	[addAdmin],
	[addDate],
	[lastUpdate],
	[isOriginal],
	[reLink],
	[IsImgNews]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_pricecomment]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_pricecomment] ON [dbo].[new_pricecomment]
(
	[id] ASC,
	[price] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_recommended]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_recommended] ON [dbo].[new_recommended]
(
	[catalogId] ASC,
	[newsId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_recommended_id]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_new_recommended_id] ON [dbo].[new_recommended]
(
	[id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_new_recommended_sortId]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_recommended_sortId] ON [dbo].[new_recommended]
(
	[sortId] ASC,
	[catalogId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_new_related_5_180664187__K2_K1_3_4]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_new_related_5_180664187__K2_K1_3_4] ON [dbo].[new_related]
(
	[contentId] ASC,
	[id] ASC
)
INCLUDE ( 	[url],
	[title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_new_related]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_new_related] ON [dbo].[new_related]
(
	[contentId] ASC,
	[url] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_news_quickrule]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_news_quickrule] ON [dbo].[news_quickrule]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_pkzt_info_5_2037438878__K43_K1_2_3]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_pkzt_info_5_2037438878__K43_K1_2_3] ON [dbo].[pkzt_info]
(
	[isdelete] ASC,
	[id] ASC
)
INCLUDE ( 	[carid1],
	[carid2]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_prd_relatedcarid]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_prd_relatedcarid] ON [dbo].[prd_relatedcarid]
(
	[selfcarid] ASC,
	[webid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_pub_ad_5_686625489__K1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_pub_ad_5_686625489__K1] ON [dbo].[pub_ad]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_pub_ad_5_686625489__K1_K13_K8_K2_K7_3]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_pub_ad_5_686625489__K1_K13_K8_K2_K7_3] ON [dbo].[pub_ad]
(
	[id] ASC,
	[isshow] ASC,
	[isDelete] ASC,
	[typeName] ASC,
	[place] ASC
)
INCLUDE ( 	[upload]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_pub_AdClickhand_5_709434147__K2]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_pub_AdClickhand_5_709434147__K2] ON [dbo].[pub_AdClickhand]
(
	[sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_pub_beautyweb]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_pub_beautyweb] ON [dbo].[pub_beautyweb]
(
	[typeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_pub_editorTemplate]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_pub_editorTemplate] ON [dbo].[pub_editorTemplate]
(
	[id] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_pub_ipdata_5_427005148__K2_K3_4_7]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_pub_ipdata_5_427005148__K2_K3_4_7] ON [dbo].[pub_ipdata]
(
	[ipnumstart] ASC,
	[ipnumend] ASC
)
INCLUDE ( 	[areaid],
	[areainfo]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_pub_ipdata_5_427005148__K3_K2_4_7]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_pub_ipdata_5_427005148__K3_K2_4_7] ON [dbo].[pub_ipdata]
(
	[ipnumend] ASC,
	[ipnumstart] ASC
)
INCLUDE ( 	[areaid],
	[areainfo]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_pub_message_5_853578079__K8_1_2_3_4_5_6_7_9_10_11_12_13_14_15_16_17]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_pub_message_5_853578079__K8_1_2_3_4_5_6_7_9_10_11_12_13_14_15_16_17] ON [dbo].[pub_message]
(
	[class] ASC
)
INCLUDE ( 	[id],
	[title],
	[content],
	[tid],
	[username],
	[adddate],
	[isdelete],
	[reply],
	[sortId],
	[replyTime],
	[hdExperts],
	[checkstat],
	[isBright],
	[realUserName],
	[brightPkZtid],
	[topCount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_pub_message_5_853578079__K8_K1_2_3_4_5_6_7_9_10_11_12_13_14_15_16_17_18_19]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_pub_message_5_853578079__K8_K1_2_3_4_5_6_7_9_10_11_12_13_14_15_16_17_18_19] ON [dbo].[pub_message]
(
	[class] ASC,
	[id] ASC
)
INCLUDE ( 	[title],
	[content],
	[tid],
	[username],
	[adddate],
	[isdelete],
	[reply],
	[sortId],
	[replyTime],
	[hdExperts],
	[checkstat],
	[isBright],
	[realUserName],
	[brightPkZtid],
	[topCount],
	[support],
	[oppose]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_pub_message_5_853578079__K8_K4_K1_K6_2_3_5_7_9_10_11_12_13_14_15_16_17_18_19_1912]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_pub_message_5_853578079__K8_K4_K1_K6_2_3_5_7_9_10_11_12_13_14_15_16_17_18_19_1912] ON [dbo].[pub_message]
(
	[class] ASC,
	[tid] ASC,
	[id] ASC,
	[adddate] ASC
)
INCLUDE ( 	[title],
	[content],
	[username],
	[isdelete],
	[reply],
	[sortId],
	[replyTime],
	[hdExperts],
	[checkstat],
	[isBright],
	[realUserName],
	[brightPkZtid],
	[topCount],
	[support],
	[oppose]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [lty]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [lty] ON [dbo].[pub_message]
(
	[id] DESC,
	[tid] DESC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [psm1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [psm1] ON [dbo].[pub_smsdata]
(
	[adddate] ASC
)
INCLUDE ( 	[id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_pub_temp]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_pub_temp] ON [dbo].[pub_temp]
(
	[type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_rne_catalog_fatherId]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_rne_catalog_fatherId] ON [dbo].[rne_catalog]
(
	[catalogId] ASC,
	[fatherId] ASC,
	[isDelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [IX_sit_catalog]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_sit_catalog] ON [dbo].[sit_catalog]
(
	[catalogid] ASC,
	[fatherid] ASC,
	[isdelete] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_sub_data_5_290100074__K13_1]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_sub_data_5_290100074__K13_1] ON [dbo].[sub_data]
(
	[sortId] ASC
)
INCLUDE ( 	[id]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_sub_data_5_290100074__K16_1_6]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_sub_data_5_290100074__K16_1_6] ON [dbo].[sub_data]
(
	[isad] ASC
)
INCLUDE ( 	[id],
	[link]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [_dta_index_sub_data_5_290100074__K2_1_3_5_6_7_8_9_10_11_12_13_14_15_16]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_sub_data_5_290100074__K2_1_3_5_6_7_8_9_10_11_12_13_14_15_16] ON [dbo].[sub_data]
(
	[sid] ASC
)
INCLUDE ( 	[id],
	[title],
	[pic],
	[link],
	[ctitle],
	[clink],
	[color],
	[bold],
	[adddate],
	[isdelete],
	[sortId],
	[link_back],
	[clink_back],
	[isad]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [_dta_index_TDayClick_5_165575628__K1_K3_K2_5_1912]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [_dta_index_TDayClick_5_165575628__K1_K3_K2_5_1912] ON [dbo].[TDayClick]
(
	[type] ASC,
	[adddate] ASC,
	[tid] ASC
)
INCLUDE ( 	[click]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_TDayClick]    Script Date: 2014/12/17 16:43:51 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_TDayClick] ON [dbo].[TDayClick]
(
	[adddate] ASC,
	[type] ASC,
	[tid] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_zht_brightMessageToTop]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_zht_brightMessageToTop] ON [dbo].[zht_brightMessageToTop]
(
	[topTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_zht_brightUserInfo]    Script Date: 2014/12/17 16:43:51 ******/
CREATE NONCLUSTERED INDEX [IX_zht_brightUserInfo] ON [dbo].[zht_brightUserInfo]
(
	[addDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ad_placedefad] ADD  CONSTRAINT [DF_ad_placedefad_isDelete]  DEFAULT ((0)) FOR [isDelete]
GO
ALTER TABLE [dbo].[ad_placedefad] ADD  CONSTRAINT [DF_ad_placedefad_isdefault]  DEFAULT ((0)) FOR [isdefault]
GO
ALTER TABLE [dbo].[ad_placedefad] ADD  DEFAULT ((0)) FOR [areakeyid]
GO
ALTER TABLE [dbo].[ad_popad] ADD  CONSTRAINT [DF_ad_popad_adid]  DEFAULT ((0)) FOR [adid]
GO
ALTER TABLE [dbo].[ad_popad] ADD  CONSTRAINT [DF_ad_popad_poptotaltimes]  DEFAULT ((0)) FOR [poptotaltimes]
GO
ALTER TABLE [dbo].[ad_popad] ADD  CONSTRAINT [DF_Table_1_clicktimes]  DEFAULT ((0)) FOR [remaintimes]
GO
ALTER TABLE [dbo].[ad_popad] ADD  CONSTRAINT [DF_ad_popad_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[ad_popad] ADD  DEFAULT ('1900-01-01') FOR [scheduledDay]
GO
ALTER TABLE [dbo].[ad_popad] ADD  DEFAULT ((0)) FOR [totalclick]
GO
ALTER TABLE [dbo].[ad_popadcarinfo] ADD  CONSTRAINT [DF_ad_popadcarinfo_popaid]  DEFAULT ((0)) FOR [popaid]
GO
ALTER TABLE [dbo].[ad_popadcarinfo] ADD  CONSTRAINT [DF_ad_popadcarinfo_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[ad_popadcarinfo] ADD  CONSTRAINT [DF_ad_popadcarinfo_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[ad_popadschedule] ADD  CONSTRAINT [DF_ad_popadschedule_popaid]  DEFAULT ((0)) FOR [popaid]
GO
ALTER TABLE [dbo].[ad_popadschedule] ADD  CONSTRAINT [DF_ad_popadschedule_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[ad_serialAd] ADD  CONSTRAINT [DF_ad_serialAd_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[ad_serialAd] ADD  CONSTRAINT [DF_ad_serialAd_modelstr]  DEFAULT ('[#1]') FOR [modelstr]
GO
ALTER TABLE [dbo].[adm_accesslog] ADD  CONSTRAINT [DF_adm_accesslog_logtime]  DEFAULT (getdate()) FOR [logtime]
GO
ALTER TABLE [dbo].[adm_function] ADD  CONSTRAINT [DF_adm_function_isdelete]  DEFAULT (0) FOR [isdelete]
GO
ALTER TABLE [dbo].[adm_function] ADD  CONSTRAINT [DF_adm_function_isusing]  DEFAULT ((0)) FOR [isusing]
GO
ALTER TABLE [dbo].[adm_hobby] ADD  CONSTRAINT [DF_adm_hobby_barcatalogtype]  DEFAULT ((0)) FOR [barcatalogtype]
GO
ALTER TABLE [dbo].[adm_hobby] ADD  CONSTRAINT [DF_adm_hobby_barverify]  DEFAULT ((2)) FOR [barverify]
GO
ALTER TABLE [dbo].[adm_hobby] ADD  CONSTRAINT [DF_adm_hobby_bartiemarea]  DEFAULT ((2)) FOR [bartimearea]
GO
ALTER TABLE [dbo].[adm_hobby] ADD  CONSTRAINT [DF_adm_hobby_isnews]  DEFAULT ((2)) FOR [isnews]
GO
ALTER TABLE [dbo].[adm_hobby] ADD  CONSTRAINT [DF_adm_hobby_isreport]  DEFAULT ((0)) FOR [isreport]
GO
ALTER TABLE [dbo].[adm_hobby] ADD  CONSTRAINT [DF_adm_hobby_baristotop]  DEFAULT ((2)) FOR [baristotop]
GO
ALTER TABLE [dbo].[adm_hobby] ADD  CONSTRAINT [DF_adm_hobby_barisindextop]  DEFAULT ((2)) FOR [barisindextop]
GO
ALTER TABLE [dbo].[adm_hobby] ADD  CONSTRAINT [DF_adm_hobby_searchtype]  DEFAULT ((1)) FOR [searchtype]
GO
ALTER TABLE [dbo].[adm_hobby] ADD  DEFAULT ('') FOR [serialimage]
GO
ALTER TABLE [dbo].[adm_log] ADD  CONSTRAINT [DF_adm_log_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[adm_OwnBrand] ADD  CONSTRAINT [DF_admOwnBrand_uid]  DEFAULT ((0)) FOR [uid]
GO
ALTER TABLE [dbo].[adm_OwnBrand] ADD  CONSTRAINT [DF_admOwnBrand_brandid]  DEFAULT ((0)) FOR [brandid]
GO
ALTER TABLE [dbo].[adm_OwnBrand] ADD  DEFAULT ((0)) FOR [areaid]
GO
ALTER TABLE [dbo].[adm_user] ADD  CONSTRAINT [DF_adm_user_realname]  DEFAULT ('') FOR [realname]
GO
ALTER TABLE [dbo].[adm_user] ADD  CONSTRAINT [DF_adm_user_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[adm_user] ADD  DEFAULT ((0)) FOR [areaid]
GO
ALTER TABLE [dbo].[adm_userpermission] ADD  CONSTRAINT [DF_adm_userpermission_opertion]  DEFAULT (0) FOR [opertion]
GO
ALTER TABLE [dbo].[app_click] ADD  CONSTRAINT [DF_app_click_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[app_clientuid] ADD  CONSTRAINT [DF_app_clientuid_userid]  DEFAULT ((0)) FOR [userid]
GO
ALTER TABLE [dbo].[are_catalog] ADD  CONSTRAINT [DF_are_catalog_isDelete]  DEFAULT ((0)) FOR [isDelete]
GO
ALTER TABLE [dbo].[are_catalog] ADD  DEFAULT ((0)) FOR [forumsid]
GO
ALTER TABLE [dbo].[are_catalog] ADD  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[are_catalog] ADD  DEFAULT ((0)) FOR [isCity]
GO
ALTER TABLE [dbo].[are_catalog] ADD  DEFAULT ((9)) FOR [adareakeyid]
GO
ALTER TABLE [dbo].[ath_carcatalog] ADD  CONSTRAINT [DF_ath_carcatalog_pathlevel]  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[ath_carcatalog] ADD  CONSTRAINT [DF__ath_carca__ispro__77A88CBD]  DEFAULT ((0)) FOR [ispropchanged]
GO
ALTER TABLE [dbo].[ath_carproperties] ADD  CONSTRAINT [DF_ath_carpropeties_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[ath_carproperties] ADD  CONSTRAINT [DF_ath_carpropeties_fatherid]  DEFAULT ((0)) FOR [fatherid]
GO
ALTER TABLE [dbo].[ath_properties] ADD  CONSTRAINT [DF_ath_properties_paramid]  DEFAULT ((0)) FOR [paramid]
GO
ALTER TABLE [dbo].[ath_updatedata] ADD  CONSTRAINT [DF_ath_updatedatea_carcatalogid]  DEFAULT ((0)) FOR [carcatalogid]
GO
ALTER TABLE [dbo].[ath_updatedata] ADD  CONSTRAINT [DF_ath_updatedatea_oldfatherid]  DEFAULT ((0)) FOR [oldfatherid]
GO
ALTER TABLE [dbo].[ath_updatedata] ADD  CONSTRAINT [DF_ath_updatedatea_newfatherid]  DEFAULT ((0)) FOR [newfatherid]
GO
ALTER TABLE [dbo].[ath_updatedata] ADD  CONSTRAINT [DF_ath_updatedatea_optiontype]  DEFAULT ((0)) FOR [optiontype]
GO
ALTER TABLE [dbo].[ath_updatedata] ADD  CONSTRAINT [DF_ath_updatedatea_dealstat]  DEFAULT ((0)) FOR [dealstat]
GO
ALTER TABLE [dbo].[ath_updatedata] ADD  CONSTRAINT [DF_ath_updatedata_isforbrand]  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[ath_updatedata] ADD  CONSTRAINT [DF_ath_updatedatea_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[aut_data] ADD  CONSTRAINT [DF_aut_data_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[aut_data] ADD  DEFAULT ((0)) FOR [isad]
GO
ALTER TABLE [dbo].[bbs_Adminipaccess] ADD  CONSTRAINT [DF_bbs_Adminipaccess_ip]  DEFAULT ('') FOR [ip]
GO
ALTER TABLE [dbo].[bbs_Adminipaccess] ADD  CONSTRAINT [DF_bbs_Adminipaccess_EffectiveDate]  DEFAULT ('1900-01-01') FOR [EffectiveDate]
GO
ALTER TABLE [dbo].[bbs_AppCarSerialNum] ADD  CONSTRAINT [DF_bbs_AppCarSerialNum_appdate]  DEFAULT (getdate()) FOR [appdate]
GO
ALTER TABLE [dbo].[bbs_AppCarSerialNum] ADD  DEFAULT ((0)) FOR [code]
GO
ALTER TABLE [dbo].[bbs_AppCarSerialNum] ADD  DEFAULT (getdate()) FOR [recodedate]
GO
ALTER TABLE [dbo].[bbs_AppCarSignNumSet] ADD  CONSTRAINT [DF_bbs_AppCarSignNumSet_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[bbs_AppCarSignNumSet] ADD  CONSTRAINT [DF_bbs_AppCarSignNumSet_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[bbs_GetMphoneName] ADD  CONSTRAINT [DF__GetMphone__userN__43A1090D]  DEFAULT ('') FOR [userName]
GO
ALTER TABLE [dbo].[bbs_GetMphoneName] ADD  CONSTRAINT [DF__GetMphone__getSt__44952D46]  DEFAULT (1) FOR [getState]
GO
ALTER TABLE [dbo].[bbs_GetMphoneName] ADD  CONSTRAINT [DF__GetMphone__apply__4589517F]  DEFAULT (getdate()) FOR [applyTime]
GO
ALTER TABLE [dbo].[bbs_keyuser] ADD  CONSTRAINT [DF_bbs_keyuser_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[bbs_MenPaiCatalog] ADD  CONSTRAINT [DF__MenPaiCat__M_Nam__29E1370A]  DEFAULT ('') FOR [M_Name]
GO
ALTER TABLE [dbo].[bbs_MenPaiCatalog] ADD  CONSTRAINT [DF__MenPaiCat__M_Des__2AD55B43]  DEFAULT ('') FOR [M_Descript]
GO
ALTER TABLE [dbo].[bbs_MenPaiCatalog] ADD  CONSTRAINT [DF__MenPaiCat__M_Fla__2BC97F7C]  DEFAULT ('') FOR [M_Flat]
GO
ALTER TABLE [dbo].[bbs_MenPaiCatalog] ADD  CONSTRAINT [DF__MenPaiCat__M_Cre__2CBDA3B5]  DEFAULT ('') FOR [M_Creater]
GO
ALTER TABLE [dbo].[bbs_MenPaiCatalog] ADD  CONSTRAINT [DF__MenPaiCat__M_Cre__2DB1C7EE]  DEFAULT (0) FOR [M_CreateTime]
GO
ALTER TABLE [dbo].[bbs_MenPaiCatalog] ADD  CONSTRAINT [DF__MenPaiCat__M_Cre__2EA5EC27]  DEFAULT (1) FOR [M_CreateClass]
GO
ALTER TABLE [dbo].[bbs_MenPaiCatalog] ADD  CONSTRAINT [DF__MenPaiCat__M_App__2F9A1060]  DEFAULT (0) FOR [M_AppState]
GO
ALTER TABLE [dbo].[bbs_MobilePhone] ADD  CONSTRAINT [DF__MobilePho__mphon__6E8B6712]  DEFAULT ('') FOR [mphoneNumber]
GO
ALTER TABLE [dbo].[bbs_MobilePhone] ADD  CONSTRAINT [DF__MobilePho__mpGet__6F7F8B4B]  DEFAULT (0) FOR [mpGetCid]
GO
ALTER TABLE [dbo].[bbs_MobilePhone] ADD  CONSTRAINT [DF__MobilePho__JoinT__7073AF84]  DEFAULT (getdate()) FOR [JoinTime]
GO
ALTER TABLE [dbo].[bbs_TopicScore] ADD  CONSTRAINT [DF_bbs_TopicScore_score]  DEFAULT ((0)) FOR [score]
GO
ALTER TABLE [dbo].[bbs_user] ADD  CONSTRAINT [DF_s_user_height]  DEFAULT (0) FOR [height]
GO
ALTER TABLE [dbo].[bbs_user] ADD  CONSTRAINT [DF_s_user_weight]  DEFAULT (0) FOR [weight]
GO
ALTER TABLE [dbo].[bbs_user] ADD  CONSTRAINT [DF_s_user_regDate]  DEFAULT (getdate()) FOR [regDate]
GO
ALTER TABLE [dbo].[bbs_user] ADD  CONSTRAINT [DF_s_user_authentication]  DEFAULT (0) FOR [authentication]
GO
ALTER TABLE [dbo].[bbs_user] ADD  DEFAULT ((0)) FOR [carSerialNum]
GO
ALTER TABLE [dbo].[bbs_user] ADD  DEFAULT ((0)) FOR [areaNum]
GO
ALTER TABLE [dbo].[bbs_user] ADD  DEFAULT ((0)) FOR [carmodelid]
GO
ALTER TABLE [dbo].[bbs_visitRecord] ADD  CONSTRAINT [DF_bbs_visitRecord_hostuserid]  DEFAULT ((0)) FOR [hostuserid]
GO
ALTER TABLE [dbo].[bbs_visitRecord] ADD  CONSTRAINT [DF_bbs_visitRecord_visiterid]  DEFAULT ((0)) FOR [visiterid]
GO
ALTER TABLE [dbo].[cah_helper] ADD  CONSTRAINT [DF_cah_helper_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[cah_manage] ADD  CONSTRAINT [DF_cah_manage_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[car_AttentionSerial] ADD  CONSTRAINT [DF_car_AttentionSerial_carid1]  DEFAULT ((0)) FOR [carid1]
GO
ALTER TABLE [dbo].[car_AttentionSerial] ADD  CONSTRAINT [DF_car_AttentionSerial_carid2]  DEFAULT ((0)) FOR [carid2]
GO
ALTER TABLE [dbo].[car_autohomeprop] ADD  CONSTRAINT [DF_car_autohomeprop_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[car_autohomeprop] ADD  DEFAULT ((0)) FOR [isupdate]
GO
ALTER TABLE [dbo].[car_autoMaintainProp] ADD  CONSTRAINT [DF_car_autoMaintainProp_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[car_autoMaintainProp] ADD  CONSTRAINT [DF_car_autoMaintainProp_autohomecarid]  DEFAULT ((0)) FOR [autohomecarid]
GO
ALTER TABLE [dbo].[car_baikeRefrence] ADD  CONSTRAINT [DF_car_baikeContent_titleid]  DEFAULT ((0)) FOR [baikeid]
GO
ALTER TABLE [dbo].[car_baikeRefrence] ADD  CONSTRAINT [DF_car_baikeRefrence_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[car_baikeRelatedmodel] ADD  CONSTRAINT [DF_car_baikeRelatedmodel_modelid]  DEFAULT ((0)) FOR [modelid]
GO
ALTER TABLE [dbo].[car_baikeRelatedmodel] ADD  CONSTRAINT [DF_car_baikeRelatedmodel_baikeid]  DEFAULT ((0)) FOR [baikeid]
GO
ALTER TABLE [dbo].[car_baikeRelatedmodel] ADD  CONSTRAINT [DF_car_baikeRelatedmodel_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[car_baikeTitle] ADD  CONSTRAINT [DF_car_baikeTitle_hascontent]  DEFAULT ((0)) FOR [hascontent]
GO
ALTER TABLE [dbo].[car_baikeTitle] ADD  CONSTRAINT [DF_car_baikeTitle_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[car_baikeTitle] ADD  CONSTRAINT [DF_car_baikeTitle_addtime]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[car_baikeTitle] ADD  CONSTRAINT [DF_car_baikeTitle_uptime]  DEFAULT (getdate()) FOR [uptime]
GO
ALTER TABLE [dbo].[car_baikeTitle] ADD  DEFAULT ((0)) FOR [hotlevel]
GO
ALTER TABLE [dbo].[car_baikeTitleFromUserAdvice] ADD  CONSTRAINT [DF_car_baikeTitleFromUserAdvice_addtime]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[car_brandmanage] ADD  CONSTRAINT [DF_car_brandmanage_brandid]  DEFAULT ((0)) FOR [brandid]
GO
ALTER TABLE [dbo].[car_brandmanage] ADD  CONSTRAINT [DF_car_brandmanage_groupid]  DEFAULT ((0)) FOR [groupid]
GO
ALTER TABLE [dbo].[car_cacc] ADD  CONSTRAINT [DF_car_cacc_isLive]  DEFAULT ((1)) FOR [isLive]
GO
ALTER TABLE [dbo].[car_cacc] ADD  CONSTRAINT [DF_car_cacc_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[car_cacc] ADD  CONSTRAINT [DF_car_cacc_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[car_cacc] ADD  CONSTRAINT [DF_car_cacc_lastupdate]  DEFAULT (getdate()) FOR [lastupdate]
GO
ALTER TABLE [dbo].[car_cacc] ADD  CONSTRAINT [DF__car_cacc__mainca__586D4088]  DEFAULT ((0)) FOR [maincatalogid]
GO
ALTER TABLE [dbo].[car_cacc] ADD  CONSTRAINT [DF__car_cacc__mainen__596164C1]  DEFAULT ('') FOR [englishname]
GO
ALTER TABLE [dbo].[car_cacc] ADD  CONSTRAINT [DF__car_cacc__ishave__5A5588FA]  DEFAULT ((1)) FOR [ishaverelation]
GO
ALTER TABLE [dbo].[car_cacc] ADD  CONSTRAINT [DF__car_cacc__pathle__5B49AD33]  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[car_cacc] ADD  CONSTRAINT [DF__car_cacc__hotlev__5C3DD16C]  DEFAULT ((0)) FOR [hotlevel]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  CONSTRAINT [DF_car_carkoubei_price]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  CONSTRAINT [DF_car_carkoubei_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  CONSTRAINT [DF_car_carkoubei_space]  DEFAULT ((0)) FOR [space]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  CONSTRAINT [DF_car_carkoubei_power]  DEFAULT ((0)) FOR [power]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  CONSTRAINT [DF_car_carkoubei_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  CONSTRAINT [DF_car_carkoubei_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  DEFAULT ((0)) FOR [areaid]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  DEFAULT ((0)) FOR [static]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  DEFAULT ((0)) FOR [kan_giftreqId]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  DEFAULT ((0)) FOR [support]
GO
ALTER TABLE [dbo].[car_carkoubei] ADD  DEFAULT ((0)) FOR [oppose]
GO
ALTER TABLE [dbo].[car_carkoubeicomment] ADD  CONSTRAINT [DF_car_koubeicomment_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[car_carkoubeicomment] ADD  CONSTRAINT [DF_car_koubeicomment_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[car_carkoubeicomment] ADD  CONSTRAINT [DF_car_koubeicomment_support]  DEFAULT ((0)) FOR [support]
GO
ALTER TABLE [dbo].[car_carkoubeicomment] ADD  CONSTRAINT [DF_car_koubeicomment_oppose]  DEFAULT ((0)) FOR [oppose]
GO
ALTER TABLE [dbo].[car_catalog] ADD  CONSTRAINT [DF_car_catalog_isLive]  DEFAULT ((1)) FOR [isLive]
GO
ALTER TABLE [dbo].[car_catalog] ADD  CONSTRAINT [DF_car_catalog_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[car_catalog] ADD  CONSTRAINT [DF_car_catalog_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[car_catalog] ADD  CONSTRAINT [DF_car_catalog_lastupdate]  DEFAULT (getdate()) FOR [lastupdate]
GO
ALTER TABLE [dbo].[car_catalog] ADD  DEFAULT ((0)) FOR [maincatalogid]
GO
ALTER TABLE [dbo].[car_catalog] ADD  DEFAULT ('') FOR [mainenglishname]
GO
ALTER TABLE [dbo].[car_catalog] ADD  DEFAULT ((1)) FOR [ishaverelation]
GO
ALTER TABLE [dbo].[car_catalog] ADD  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[car_catalog] ADD  DEFAULT ((0)) FOR [hotlevel]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  CONSTRAINT [DF_car_catalogtemp_isLive]  DEFAULT ((1)) FOR [isLive]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  CONSTRAINT [DF_car_catalogtemp_onSale]  DEFAULT ((1)) FOR [onSale]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  CONSTRAINT [DF_car_catalogtemp_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  CONSTRAINT [DF_car_catalogtemp_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  CONSTRAINT [DF_car_catalogtemp_lastupdate]  DEFAULT (getdate()) FOR [lastupdate]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  CONSTRAINT [DF__car_catal__mainc__3CD3A82A]  DEFAULT ((0)) FOR [maincatalogid]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  CONSTRAINT [DF__car_catal__ishav__3EBBF09C]  DEFAULT ((1)) FOR [ishaverelation]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  CONSTRAINT [DF__car_catal__pathl__3FB014D5]  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  CONSTRAINT [DF__car_catal__hotle__40A4390E]  DEFAULT ((0)) FOR [hotlevel]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  CONSTRAINT [DF_car_catalognew_fadongji]  DEFAULT ((1)) FOR [fadongji]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  DEFAULT ((0)) FOR [baoyangfeiyong]
GO
ALTER TABLE [dbo].[car_catalognew] ADD  DEFAULT ((0)) FOR [pengzhuanglevel]
GO
ALTER TABLE [dbo].[car_comment] ADD  CONSTRAINT [DF_car_comment_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[car_comment] ADD  CONSTRAINT [DF_car_comment_msgtype]  DEFAULT ((0)) FOR [msgtype]
GO
ALTER TABLE [dbo].[car_comment] ADD  CONSTRAINT [DF_car_comment_isbright]  DEFAULT ((0)) FOR [isbright]
GO
ALTER TABLE [dbo].[car_comment] ADD  CONSTRAINT [DF_car_comment_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[car_comment] ADD  CONSTRAINT [DF_car_comment_postername]  DEFAULT ('') FOR [postername]
GO
ALTER TABLE [dbo].[car_comment] ADD  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[car_comment] ADD  DEFAULT ((0)) FOR [isaccess]
GO
ALTER TABLE [dbo].[car_comment] ADD  DEFAULT ((0)) FOR [support]
GO
ALTER TABLE [dbo].[car_comment] ADD  DEFAULT ((0)) FOR [oppose]
GO
ALTER TABLE [dbo].[car_comment] ADD  DEFAULT ((0)) FOR [isdisplay]
GO
ALTER TABLE [dbo].[car_comment] ADD  DEFAULT ((0)) FOR [hascookie]
GO
ALTER TABLE [dbo].[car_comparecomment] ADD  CONSTRAINT [DF_car_comparecomment_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[car_comparecomment] ADD  CONSTRAINT [DF_car_comparecomment_comparecarid]  DEFAULT ((0)) FOR [comparecarid]
GO
ALTER TABLE [dbo].[car_comparecomment] ADD  CONSTRAINT [DF_car_comparecomment_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[car_comparecomment] ADD  CONSTRAINT [DF_car_comparecomment_sortid]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[car_comparecomment] ADD  CONSTRAINT [DF_car_comparecomment_isaccess]  DEFAULT ((0)) FOR [isaccess]
GO
ALTER TABLE [dbo].[car_comparevote] ADD  CONSTRAINT [DF_car_comparevote_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[car_comparevote] ADD  CONSTRAINT [DF_car_comparevote_comparecarid]  DEFAULT ((0)) FOR [comparecarid]
GO
ALTER TABLE [dbo].[car_comparevote] ADD  CONSTRAINT [DF_Table_1_votenum]  DEFAULT ((0)) FOR [votenum1]
GO
ALTER TABLE [dbo].[car_comparevote] ADD  CONSTRAINT [DF_car_comparevote_votenum2]  DEFAULT ((0)) FOR [votenum2]
GO
ALTER TABLE [dbo].[car_detialnews] ADD  CONSTRAINT [DF_car_detialnews_serialid]  DEFAULT ((0)) FOR [serialid]
GO
ALTER TABLE [dbo].[car_detialnews] ADD  CONSTRAINT [DF_car_detialnews_detailtype]  DEFAULT ((0)) FOR [detailtype]
GO
ALTER TABLE [dbo].[car_detialnews] ADD  CONSTRAINT [DF_car_detialnews_relatedcarModel]  DEFAULT ((0)) FOR [relatedcarModel]
GO
ALTER TABLE [dbo].[car_detialnews] ADD  CONSTRAINT [DF_car_detialnews_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[car_group] ADD  CONSTRAINT [DF_car_group_isabroad]  DEFAULT ((0)) FOR [isabroad]
GO
ALTER TABLE [dbo].[car_group] ADD  DEFAULT ('') FOR [photo]
GO
ALTER TABLE [dbo].[car_group] ADD  DEFAULT ('') FOR [intro]
GO
ALTER TABLE [dbo].[car_group] ADD  DEFAULT ('') FOR [englishname]
GO
ALTER TABLE [dbo].[car_iway] ADD  CONSTRAINT [DF_car_iway_brandid]  DEFAULT ((0)) FOR [brandid]
GO
ALTER TABLE [dbo].[car_newproattention] ADD  CONSTRAINT [DF_car_newproattention_uptime]  DEFAULT (getdate()) FOR [uptime]
GO
ALTER TABLE [dbo].[car_otherSiteCatalog] ADD  DEFAULT ((0)) FOR [selfcarid]
GO
ALTER TABLE [dbo].[car_serialNews] ADD  CONSTRAINT [DF_car_serialNews_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[car_serialNews] ADD  CONSTRAINT [DF_car_serialNews_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[car_serialNews] ADD  DEFAULT ((0)) FOR [sortId]
GO
ALTER TABLE [dbo].[car_serialpeizhides] ADD  CONSTRAINT [DF_car_serialpeizhides_serialid]  DEFAULT ((0)) FOR [serialid]
GO
ALTER TABLE [dbo].[car_serialpeizhides] ADD  CONSTRAINT [DF_car_serialpeizhides_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[car_serialpeizhides] ADD  CONSTRAINT [DF_car_serialpeizhides_updatetime]  DEFAULT (getdate()) FOR [updatetime]
GO
ALTER TABLE [dbo].[car_serialpeizhides] ADD  CONSTRAINT [DF_car_serialpeizhides_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[crm_baoming] ADD  CONSTRAINT [DF_crm_baoming_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[crm_baoming] ADD  CONSTRAINT [DF_crm_baoming_sex]  DEFAULT ((-1)) FOR [sex]
GO
ALTER TABLE [dbo].[crm_baoming] ADD  CONSTRAINT [DF_crm_baoming_hasbuy]  DEFAULT ((-1)) FOR [hasbuy]
GO
ALTER TABLE [dbo].[crm_baoming] ADD  CONSTRAINT [DF_crm_baoming_activetype]  DEFAULT (N'0-') FOR [activetype]
GO
ALTER TABLE [dbo].[crm_baoming] ADD  CONSTRAINT [DF_crm_baoming_paymonth]  DEFAULT ('') FOR [paymonth]
GO
ALTER TABLE [dbo].[css_2014] ADD  CONSTRAINT [DF_css_2014_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[css_2014] ADD  CONSTRAINT [DF_css_2014_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  CONSTRAINT [DF_dea_bbsposts1_pid]  DEFAULT ((0)) FOR [pid]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  CONSTRAINT [DF_dea_bbsposts1_seid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  CONSTRAINT [DF_dea_bbsposts1_tid]  DEFAULT ((0)) FOR [tid]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  CONSTRAINT [DF_dea_bbsposts1_layer]  DEFAULT ((0)) FOR [layer]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  CONSTRAINT [DF_dea_bbsposts1_parentid]  DEFAULT ((0)) FOR [parentid]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  CONSTRAINT [DF_dea_bbsposts1_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  CONSTRAINT [DF_dea_bbsposts1_posterid]  DEFAULT ((0)) FOR [posterid]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  CONSTRAINT [DF_dea_bbsposts1_poster]  DEFAULT ('') FOR [posternickname]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  CONSTRAINT [DF_dea_bbsposts1_lastedit]  DEFAULT ('') FOR [lastedit]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  CONSTRAINT [DF_dea_bbsposts1_postdatetime]  DEFAULT (getdate()) FOR [postdatetime]
GO
ALTER TABLE [dbo].[dea_bbsposts1] ADD  DEFAULT ((0)) FOR [fromphone]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_seid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_views]  DEFAULT ((0)) FOR [views]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_replies]  DEFAULT ((0)) FOR [replies]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_highlight]  DEFAULT ((0)) FOR [highlight]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_jinghua]  DEFAULT ((0)) FOR [jinghua]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_displayorder]  DEFAULT ((0)) FOR [displayorder]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_typeid]  DEFAULT ((0)) FOR [typeid]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics_posterid]  DEFAULT ((0)) FOR [posterid]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics_lastposterid]  DEFAULT ((0)) FOR [lastposterid]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics_contentpid]  DEFAULT ((0)) FOR [contentpid]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics_isimg]  DEFAULT ((0)) FOR [isimg]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_title]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_poster]  DEFAULT ('') FOR [posternickname]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_lastposter]  DEFAULT ('') FOR [lastposternickname]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_postdatetime]  DEFAULT (getdate()) FOR [postdatetime]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  CONSTRAINT [DF_dea_bbstopics1_lastpost]  DEFAULT (getdate()) FOR [lastpostdatetime]
GO
ALTER TABLE [dbo].[dea_bbstopics] ADD  DEFAULT ((0)) FOR [fromphone]
GO
ALTER TABLE [dbo].[dea_bymodel] ADD  CONSTRAINT [DF_dea_bymodel_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_byschedule] ADD  CONSTRAINT [DF_dea_byschedule_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_byschedule] ADD  CONSTRAINT [DF_dea_byschedule_places]  DEFAULT ((0)) FOR [places]
GO
ALTER TABLE [dbo].[dea_byschedule] ADD  CONSTRAINT [DF_dea_byschedule_zhekou]  DEFAULT ('') FOR [zhekou]
GO
ALTER TABLE [dbo].[dea_byschedule] ADD  CONSTRAINT [DF_dea_byschedule_bydate]  DEFAULT (getdate()) FOR [bydate]
GO
ALTER TABLE [dbo].[dea_byschedule] ADD  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_byschedulesenior] ADD  CONSTRAINT [DF_dea_byschedulesenior_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_byschedulesenior] ADD  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_bydate]  DEFAULT ((0)) FOR [placeid]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_dealstate]  DEFAULT ((0)) FOR [dealstate]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_username]  DEFAULT ((0)) FOR [userid]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_zhekou]  DEFAULT ('') FOR [zhekou]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_phone]  DEFAULT ('') FOR [phone]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_carcode]  DEFAULT ('') FOR [carcode]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_fromsource]  DEFAULT ((1)) FOR [fromsource]
GO
ALTER TABLE [dbo].[dea_byyuyue] ADD  CONSTRAINT [DF_dea_byyuyue_issenior]  DEFAULT ((0)) FOR [issenior]
GO
ALTER TABLE [dbo].[dea_click] ADD  DEFAULT ((1)) FOR [clickCount]
GO
ALTER TABLE [dbo].[dea_contact] ADD  CONSTRAINT [DF_dea_contact_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_contact] ADD  CONSTRAINT [DF_dea_contact_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_contact] ADD  CONSTRAINT [DF_dea_contact_state]  DEFAULT ((0)) FOR [state]
GO
ALTER TABLE [dbo].[dea_custom_price] ADD  CONSTRAINT [DF_dea_custom_price_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_dealerinfo] ADD  CONSTRAINT [DF_dea_dealerinfo_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_dealerinfo] ADD  CONSTRAINT [DF_dea_dealerinfo_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_dealerinfo] ADD  DEFAULT ('0') FOR [h_lat]
GO
ALTER TABLE [dbo].[dea_dealerinfo] ADD  DEFAULT ('0') FOR [h_lng]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  CONSTRAINT [DF_dea_dealers_paylevel]  DEFAULT ((0)) FOR [paylevel]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  CONSTRAINT [DF_dea_dealers_areaid]  DEFAULT ((0)) FOR [areaid]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  CONSTRAINT [DF_dea_dealers_indexhotnewssetting]  DEFAULT ((0)) FOR [indexhotnewssetting]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  CONSTRAINT [DF_dea_dealers_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  CONSTRAINT [DF__dea_deale__addda__0F2B1093]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  CONSTRAINT [DF__dea_deale__isbit__101F34CC]  DEFAULT ((0)) FOR [isbitauto]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  CONSTRAINT [DF__dea_dealer__is4s__3A156E98]  DEFAULT ((2)) FOR [is4s]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  DEFAULT ((0)) FOR [isbitautoprice]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  CONSTRAINT [DF_dea_dealers_seposttableid]  DEFAULT ((1)) FOR [seposttableid]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  DEFAULT ((0)) FOR [addbbs]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  DEFAULT ((0)) FOR [maxpushid]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  DEFAULT ((0)) FOR [bmbasiccount]
GO
ALTER TABLE [dbo].[dea_dealers] ADD  CONSTRAINT [DF_dea_dealers_issenior]  DEFAULT ((0)) FOR [issenior]
GO
ALTER TABLE [dbo].[dea_employee] ADD  CONSTRAINT [DF_dea_employee_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_employee] ADD  CONSTRAINT [DF_dea_employee_sortid]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[dea_employee] ADD  CONSTRAINT [DF_dea_employee_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_employee] ADD  CONSTRAINT [DF_dea_employee_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_employee] ADD  DEFAULT ((1)) FOR [servicetype]
GO
ALTER TABLE [dbo].[dea_focusimg] ADD  CONSTRAINT [DF_dea_focusimg_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_focusimg] ADD  CONSTRAINT [DF_dea_focusimg_placeid]  DEFAULT ((0)) FOR [placeid]
GO
ALTER TABLE [dbo].[dea_focusimg] ADD  CONSTRAINT [DF_dea_focusimg_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_focusimg] ADD  CONSTRAINT [DF_dea_focusimg_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_focusimg] ADD  CONSTRAINT [DF_dea_focusimg_updatetime]  DEFAULT (getdate()) FOR [updatetime]
GO
ALTER TABLE [dbo].[dea_frequentlyUseMenu] ADD  CONSTRAINT [DF_dea_frequentlyUseMenu_menuId]  DEFAULT ((0)) FOR [menuId]
GO
ALTER TABLE [dbo].[dea_frequentlyUseMenu] ADD  CONSTRAINT [DF_dea_frequentlyUseMenu_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_helpphone] ADD  CONSTRAINT [DF_dea_helpphone_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  CONSTRAINT [DF_dea_hqnews_serialid]  DEFAULT ((0)) FOR [serialid]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  CONSTRAINT [DF_dea_hqnews_starttime]  DEFAULT (getdate()) FOR [starttime]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  CONSTRAINT [DF_dea_hqnews_isaddress]  DEFAULT ((0)) FOR [isaddress]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  CONSTRAINT [DF_dea_hqnews_ismap]  DEFAULT ((0)) FOR [ismap]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  CONSTRAINT [DF_dea_hqnews_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  CONSTRAINT [DF_dea_hqnews_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  CONSTRAINT [DF_dea_hqnews_newid]  DEFAULT ((0)) FOR [newid]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  DEFAULT ((0)) FOR [saleprice]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  DEFAULT ((0)) FOR [isaddphone]
GO
ALTER TABLE [dbo].[dea_hqnews] ADD  DEFAULT ((0)) FOR [news315]
GO
ALTER TABLE [dbo].[dea_hqnewsTo315] ADD  CONSTRAINT [DF_dea_hqnewsTo315_hqid]  DEFAULT ((0)) FOR [hqid]
GO
ALTER TABLE [dbo].[dea_hqprice] ADD  CONSTRAINT [DF_dea_hqprice_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_hqprice] ADD  CONSTRAINT [DF_dea_hqprice_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_hqprice] ADD  CONSTRAINT [DF_dea_hqprice_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_hqprice] ADD  DEFAULT ((0)) FOR [facprice]
GO
ALTER TABLE [dbo].[dea_hqprice] ADD  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[dea_hqprice] ADD  DEFAULT ((0)) FOR [lowprice]
GO
ALTER TABLE [dbo].[dea_menurelated] ADD  CONSTRAINT [DF_dea_menurelated_menuid]  DEFAULT ((0)) FOR [menuid]
GO
ALTER TABLE [dbo].[dea_menurelated] ADD  CONSTRAINT [DF_dea_menurelated_modelid]  DEFAULT ((0)) FOR [modelid]
GO
ALTER TABLE [dbo].[dea_menusetting] ADD  CONSTRAINT [DF_dea_menusetting_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_menusetting] ADD  CONSTRAINT [DF_dea_menusetting_menuid]  DEFAULT ((0)) FOR [menuid]
GO
ALTER TABLE [dbo].[dea_menusetting] ADD  CONSTRAINT [DF_dea_menusetting_sortid]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[dea_menusetting] ADD  DEFAULT ((0)) FOR [delState]
GO
ALTER TABLE [dbo].[dea_message] ADD  CONSTRAINT [DF_dea_message_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_message] ADD  CONSTRAINT [DF_dea_message_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_message] ADD  CONSTRAINT [DF_dea_message_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_mphone] ADD  CONSTRAINT [DF_dea_mphone_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_mphone] ADD  DEFAULT ((0)) FOR [dealstate]
GO
ALTER TABLE [dbo].[dea_news] ADD  CONSTRAINT [DF_dea_news_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_news] ADD  CONSTRAINT [DF_dea_news_typeid]  DEFAULT ((0)) FOR [typeid]
GO
ALTER TABLE [dbo].[dea_news] ADD  CONSTRAINT [DF_dea_news_views]  DEFAULT ((0)) FOR [views]
GO
ALTER TABLE [dbo].[dea_news] ADD  CONSTRAINT [DF_dea_news_hotsortid]  DEFAULT ((0)) FOR [hotsortid]
GO
ALTER TABLE [dbo].[dea_news] ADD  CONSTRAINT [DF_dea_news_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_news] ADD  CONSTRAINT [DF_dea_news_publishdate]  DEFAULT (getdate()) FOR [publishdate]
GO
ALTER TABLE [dbo].[dea_news] ADD  CONSTRAINT [DF_dea_news_hotdate]  DEFAULT (getdate()) FOR [hotdate]
GO
ALTER TABLE [dbo].[dea_news] ADD  CONSTRAINT [DF_dea_news_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_news] ADD  CONSTRAINT [DF_dea_news_ishot]  DEFAULT ((0)) FOR [ishot]
GO
ALTER TABLE [dbo].[dea_news] ADD  CONSTRAINT [DF_dea_news_bbstopicpostid]  DEFAULT ((0)) FOR [bbstopicpostid]
GO
ALTER TABLE [dbo].[dea_opertions] ADD  CONSTRAINT [DF_dea_opertions_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_opertions] ADD  CONSTRAINT [DF_dea_opertions_scores]  DEFAULT ((0)) FOR [scores]
GO
ALTER TABLE [dbo].[dea_opertions] ADD  CONSTRAINT [DF_dea_opertions_type]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[dea_opertions] ADD  CONSTRAINT [DF_dea_opertions_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_ordercar] ADD  CONSTRAINT [DF_dea_ordercar_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_ordercar] ADD  CONSTRAINT [DF_dea_ordercar_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[dea_ordercar] ADD  CONSTRAINT [DF_dea_ordercar_orderdate]  DEFAULT (getdate()) FOR [orderdate]
GO
ALTER TABLE [dbo].[dea_ordercar] ADD  CONSTRAINT [DF_dea_ordercar_state]  DEFAULT ((0)) FOR [state]
GO
ALTER TABLE [dbo].[dea_ordercar] ADD  CONSTRAINT [DF_dea_ordercar_ordertype]  DEFAULT ((0)) FOR [ordertype]
GO
ALTER TABLE [dbo].[dea_ordercar] ADD  CONSTRAINT [DF_dea_ordercar_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_ordercar] ADD  CONSTRAINT [DF__dea_order__areaI__7E6A98E5]  DEFAULT ((0)) FOR [areaId]
GO
ALTER TABLE [dbo].[dea_ordercar] ADD  DEFAULT ((0)) FOR [userid]
GO
ALTER TABLE [dbo].[dea_ordercar] ADD  CONSTRAINT [DF_dea_ordercar_fromsource]  DEFAULT ((1)) FOR [fromsource]
GO
ALTER TABLE [dbo].[dea_pagemenu] ADD  CONSTRAINT [DF_dea_pagemenu_fatherid]  DEFAULT ((0)) FOR [fatherid]
GO
ALTER TABLE [dbo].[dea_pagemenu] ADD  CONSTRAINT [DF_dea_pagemenu_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_pagemenu] ADD  CONSTRAINT [DF_dea_pagemenu_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_pagemenu] ADD  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[dea_pagemodel] ADD  CONSTRAINT [DF_dea_pagemodel_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_phonedealrecord] ADD  CONSTRAINT [DF_dea_phonedealrecord_dealtime]  DEFAULT (getdate()) FOR [dealtime]
GO
ALTER TABLE [dbo].[dea_phonemanage] ADD  CONSTRAINT [DF_dea_phonemanage_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_phonemanage] ADD  CONSTRAINT [DF_dea_phonemanage_startWork]  DEFAULT ((1)) FOR [startWork]
GO
ALTER TABLE [dbo].[dea_phonemanage] ADD  CONSTRAINT [DF_dea_phonemanage_job]  DEFAULT ((1)) FOR [job]
GO
ALTER TABLE [dbo].[dea_phonemsg] ADD  CONSTRAINT [DF_dea_phonemsg_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_phonemsg] ADD  CONSTRAINT [DF_dea_phonemsg_uid]  DEFAULT ((0)) FOR [uid]
GO
ALTER TABLE [dbo].[dea_phonemsg] ADD  CONSTRAINT [DF_dea_phonemsg_admintype]  DEFAULT ((0)) FOR [admintype]
GO
ALTER TABLE [dbo].[dea_phonemsg] ADD  CONSTRAINT [DF_dea_phonemsg_itype]  DEFAULT ((0)) FOR [itype]
GO
ALTER TABLE [dbo].[dea_phonemsg] ADD  CONSTRAINT [DF_dea_phonemsg_reid]  DEFAULT ((0)) FOR [reid]
GO
ALTER TABLE [dbo].[dea_phonemsg] ADD  CONSTRAINT [DF_dea_phonemsg_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_phonemsg] ADD  CONSTRAINT [DF_dea_phonemsg_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_phoneshare] ADD  CONSTRAINT [DF_dea_phoneshare_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_pushmessage] ADD  CONSTRAINT [DF_dea_pushmessage_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_pushmessage] ADD  CONSTRAINT [DF_dea_pushmessage_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_pushtocustomcrm] ADD  CONSTRAINT [DF_dea_pushtocustomcrm_pushdate]  DEFAULT (getdate()) FOR [pushdate]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  CONSTRAINT [DF_dea_qaonline_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  CONSTRAINT [DF_dea_qaonline_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  CONSTRAINT [DF_dea_qaonline_quesdate]  DEFAULT (getdate()) FOR [quesdate]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  CONSTRAINT [DF_dea_qaonline_answerdate]  DEFAULT (getdate()) FOR [answerdate]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  CONSTRAINT [DF_dea_qaonline_state]  DEFAULT ((0)) FOR [state]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  CONSTRAINT [DF_dea_qaonline_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  DEFAULT ((0)) FOR [areaId]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  DEFAULT ((0)) FOR [ischeck]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  DEFAULT ((0)) FOR [markers]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  DEFAULT ((0)) FOR [hascookie]
GO
ALTER TABLE [dbo].[dea_qaonline] ADD  DEFAULT ((0)) FOR [addbbs]
GO
ALTER TABLE [dbo].[dea_SCcommodity] ADD  CONSTRAINT [DF_dea_SCcommodity_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_SCcommodity] ADD  CONSTRAINT [DF_dea_SCcommodity_totalnum]  DEFAULT ((0)) FOR [totalnum]
GO
ALTER TABLE [dbo].[dea_SCcommodityByArea] ADD  CONSTRAINT [DF_dea_SCcommodityByArea_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_scoresSort] ADD  CONSTRAINT [DF_dea_scoresSort_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_scoresSort] ADD  CONSTRAINT [DF_dea_scoresSort_scores]  DEFAULT ((0)) FOR [scores]
GO
ALTER TABLE [dbo].[dea_scoresSort] ADD  CONSTRAINT [DF_dea_scoresSort_sdate]  DEFAULT (getdate()) FOR [sdate]
GO
ALTER TABLE [dbo].[dea_scoresSort] ADD  CONSTRAINT [DF_dea_scoresSort_edate]  DEFAULT (getdate()) FOR [edate]
GO
ALTER TABLE [dbo].[dea_scoresSort] ADD  DEFAULT ((-1)) FOR [brandSort]
GO
ALTER TABLE [dbo].[dea_scoresSort] ADD  DEFAULT ((-1)) FOR [areaSort]
GO
ALTER TABLE [dbo].[dea_scoresSort] ADD  DEFAULT ((-1)) FOR [brandAndAreaSort]
GO
ALTER TABLE [dbo].[dea_scoresSort] ADD  DEFAULT ((-1)) FOR [sortid]
GO
ALTER TABLE [dbo].[dea_SCPic] ADD  CONSTRAINT [DF_dea_SCPic_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_SCPicByArea] ADD  CONSTRAINT [DF_dea_SCPicByArea_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_SCsignature] ADD  CONSTRAINT [DF_dea_SCsignature_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_smsnotice] ADD  CONSTRAINT [DF_dea_smsnotice_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_smsnotice] ADD  CONSTRAINT [DF_dea_smsnotice_orderCar]  DEFAULT ((1)) FOR [type]
GO
ALTER TABLE [dbo].[dea_smsnotice] ADD  CONSTRAINT [DF_dea_smsnotice_yewu]  DEFAULT ((1)) FOR [yewu]
GO
ALTER TABLE [dbo].[dea_storedisplay] ADD  CONSTRAINT [DF_dea_storedisplay_sortid]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[dea_storedisplay] ADD  CONSTRAINT [DF_dea_storedisplay_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_storedisplay] ADD  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_temphqcontent] ADD  CONSTRAINT [DF_dea_temphqcontent_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_userexpenses] ADD  CONSTRAINT [DF_dea_userexpenses_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[dea_userexpenses] ADD  CONSTRAINT [DF_dea_userexpenses_uid]  DEFAULT ((0)) FOR [uid]
GO
ALTER TABLE [dbo].[dea_userexpenses] ADD  CONSTRAINT [DF_dea_userexpenses_price]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[dea_userexpenses] ADD  CONSTRAINT [DF_dea_userexpenses_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_userexpenses] ADD  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_useroil] ADD  CONSTRAINT [DF_dea_useroil_uid]  DEFAULT ((0)) FOR [uid]
GO
ALTER TABLE [dbo].[dea_useroil] ADD  CONSTRAINT [DF_dea_useroil_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[dea_useroil] ADD  CONSTRAINT [DF_dea_useroil_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_userques] ADD  CONSTRAINT [DF_dea_userques_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_userques] ADD  CONSTRAINT [DF_dea_userques_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_userques] ADD  CONSTRAINT [DF_dea_userques_dealstate]  DEFAULT ((0)) FOR [dealstate]
GO
ALTER TABLE [dbo].[dea_userques] ADD  DEFAULT ((0)) FOR [bbsid]
GO
ALTER TABLE [dbo].[dea_users] ADD  CONSTRAINT [DF_dea_users_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_wxaccount] ADD  CONSTRAINT [DF_dea_wxaccount_wx_ok]  DEFAULT ((0)) FOR [wx_ok]
GO
ALTER TABLE [dbo].[dea_wxaccount] ADD  CONSTRAINT [DF_dea_wxaccount_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_wxaccount] ADD  CONSTRAINT [DF_dea_wxaccount_apiday]  DEFAULT ((0)) FOR [apiday]
GO
ALTER TABLE [dbo].[dea_wxaccount] ADD  CONSTRAINT [DF_dea_wxaccount_statdate]  DEFAULT ((0)) FOR [statdate]
GO
ALTER TABLE [dbo].[dea_wxactbm] ADD  CONSTRAINT [DF_dea_wxactbm_addtime]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[dea_wxActivities] ADD  CONSTRAINT [DF_dea_wxActivities_AddTime]  DEFAULT (getdate()) FOR [AddTime]
GO
ALTER TABLE [dbo].[dea_wxactjoin] ADD  CONSTRAINT [DF_dea_wxactjoin_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO
ALTER TABLE [dbo].[dea_wxadminpushmsg] ADD  CONSTRAINT [DF_Table_1_dflag]  DEFAULT ((0)) FOR [wxflag]
GO
ALTER TABLE [dbo].[dea_wxadminpushmsg] ADD  CONSTRAINT [DF_dea_wxadminpushmsg_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_wxadminpushmsg] ADD  CONSTRAINT [DF_dea_wxadminpushmsg_type]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[dea_WXHongBao] ADD  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[dea_wxintmsg] ADD  CONSTRAINT [DF_dea_wxintmsg_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_wxmsg] ADD  CONSTRAINT [DF_dea_wxmsg_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_wxpay] ADD  CONSTRAINT [DF_dea_wxpay_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_wxrecord] ADD  CONSTRAINT [DF_dea_wxrecord_addtime]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[dea_wxservice] ADD  CONSTRAINT [DF_dea_wxservice_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO
ALTER TABLE [dbo].[dea_wxuser] ADD  CONSTRAINT [DF_dea_wxuser_AddDate]  DEFAULT (getdate()) FOR [AddDate]
GO
ALTER TABLE [dbo].[dea_wxzhuti] ADD  CONSTRAINT [DF_dea_wxzhuti_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_wxzplist] ADD  CONSTRAINT [DF_dea_wxzplist_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_wxzplist] ADD  CONSTRAINT [DF_dea_wxzplist_isok]  DEFAULT ((0)) FOR [isok]
GO
ALTER TABLE [dbo].[dea_youhui] ADD  CONSTRAINT [DF_dea_youhui_eid]  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[dea_youhui] ADD  CONSTRAINT [DF_dea_youhui_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_youhuibm] ADD  CONSTRAINT [DF_dea_youhuibm_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dea_youhuibm] ADD  CONSTRAINT [DF_dea_youhuibm_dealstate]  DEFAULT ((0)) FOR [dealstate]
GO
ALTER TABLE [dbo].[dea_youhuibm] ADD  CONSTRAINT [DF_dea_youhuibm_youhid]  DEFAULT ((0)) FOR [youhid]
GO
ALTER TABLE [dbo].[dea_youhuibm] ADD  CONSTRAINT [DF_dea_youhuibm_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[dea_youhuibm] ADD  CONSTRAINT [DF_dea_youhuibm_uid]  DEFAULT ((0)) FOR [uid]
GO
ALTER TABLE [dbo].[dongyue_bmdata] ADD  CONSTRAINT [DF_Table_1_areaid]  DEFAULT ((0)) FOR [areaname]
GO
ALTER TABLE [dbo].[dongyue_bmdata] ADD  CONSTRAINT [DF_Table_1_serialid]  DEFAULT ((0)) FOR [serialname]
GO
ALTER TABLE [dbo].[dongyue_bmdata] ADD  CONSTRAINT [DF_dongyue_bmdata_areaid]  DEFAULT ((0)) FOR [areaid]
GO
ALTER TABLE [dbo].[dongyue_bmdata] ADD  CONSTRAINT [DF_dongyue_bmdata_serialid]  DEFAULT ((0)) FOR [serialid]
GO
ALTER TABLE [dbo].[dongyue_bmdata] ADD  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[dongyue_user] ADD  CONSTRAINT [DF_dongyue_user_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[duihuaList] ADD  CONSTRAINT [DF_duihuaList_goodsNumb]  DEFAULT ((0)) FOR [goodsNumb]
GO
ALTER TABLE [dbo].[duihuaList] ADD  CONSTRAINT [DF_duihuaList_danwei]  DEFAULT ((0)) FOR [danwei]
GO
ALTER TABLE [dbo].[duihuaList] ADD  CONSTRAINT [DF_duihuaList_coin]  DEFAULT ((0)) FOR [coin]
GO
ALTER TABLE [dbo].[duihuaList] ADD  CONSTRAINT [DF_duihuaList_huagoudian]  DEFAULT ((0)) FOR [huagoudian]
GO
ALTER TABLE [dbo].[duihuaList] ADD  CONSTRAINT [DF_duihuaList_maxtopic]  DEFAULT ((0)) FOR [maxtopic]
GO
ALTER TABLE [dbo].[duihuaList] ADD  CONSTRAINT [DF_duihuaList_maxnumb]  DEFAULT ((0)) FOR [maxnumb]
GO
ALTER TABLE [dbo].[duihuaList] ADD  CONSTRAINT [DF_duihuaList_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[duihuaPresent] ADD  DEFAULT ((0)) FOR [isend]
GO
ALTER TABLE [dbo].[duihuaPresent] ADD  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[duihuaPresent] ADD  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[duihuaPresent] ADD  DEFAULT ((0)) FOR [ptype]
GO
ALTER TABLE [dbo].[ent_4s] ADD  CONSTRAINT [DF_ent_4s_e_adddate]  DEFAULT (getdate()) FOR [e_adddate]
GO
ALTER TABLE [dbo].[ent_4s] ADD  CONSTRAINT [DF_ent_4s_px]  DEFAULT (0) FOR [px]
GO
ALTER TABLE [dbo].[ent_4s] ADD  CONSTRAINT [DF_ent_4s_py]  DEFAULT (0) FOR [py]
GO
ALTER TABLE [dbo].[ent_4s] ADD  DEFAULT (0) FOR [mapAreaID]
GO
ALTER TABLE [dbo].[ent_4s] ADD  CONSTRAINT [DF_ent_4s_gradid]  DEFAULT (0) FOR [grade_id]
GO
ALTER TABLE [dbo].[ent_DomainLogon] ADD  CONSTRAINT [DF__ent_DomainLog__OutTi__48BAC3E5]  DEFAULT (dateadd(minute,1,getdate())) FOR [OutTime]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_ent_product_E_id]  DEFAULT ((0)) FOR [E_id]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_ent_product_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_ent_product_typeid]  DEFAULT ((0)) FOR [typeid]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_ent_product_type]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_ent_product_isRecommended]  DEFAULT ((0)) FOR [isRecommended]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF__ent_produ__price__5DD5DC5C]  DEFAULT ((0)) FOR [pricesSort]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_ent_product_sortId]  DEFAULT ((0)) FOR [sortId]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_ent_product_price]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_ent_product_offersprice]  DEFAULT ((0)) FOR [offersprice]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_bcar_product_P_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_ent_product_updatedate]  DEFAULT (getdate()) FOR [updatedate]
GO
ALTER TABLE [dbo].[ent_product] ADD  CONSTRAINT [DF_ent_product_isdiscountdef]  DEFAULT ((0)) FOR [isdiscountdef]
GO
ALTER TABLE [dbo].[ent_product] ADD  DEFAULT ((0)) FOR [bitautoPrice]
GO
ALTER TABLE [dbo].[ent_user] ADD  CONSTRAINT [DF_ent_user_RegDate]  DEFAULT (getdate()) FOR [RegDate]
GO
ALTER TABLE [dbo].[img_catalog] ADD  CONSTRAINT [DF_img_catalog_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[img_catalog] ADD  CONSTRAINT [DF_img_catalog_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[img_catalog] ADD  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[img_content] ADD  CONSTRAINT [DF_img_content_addDate]  DEFAULT (getdate()) FOR [addDate]
GO
ALTER TABLE [dbo].[img_content] ADD  CONSTRAINT [DF_img_content_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [dbo].[img_content] ADD  CONSTRAINT [DF_img_content_sortId]  DEFAULT ((0)) FOR [sortId]
GO
ALTER TABLE [dbo].[img_content] ADD  CONSTRAINT [DF_img_content_isDelete]  DEFAULT (2) FOR [isDelete]
GO
ALTER TABLE [dbo].[img_content] ADD  DEFAULT ((0)) FOR [contentPage]
GO
ALTER TABLE [dbo].[img_content] ADD  DEFAULT ((0)) FOR [serialType]
GO
ALTER TABLE [dbo].[img_content] ADD  DEFAULT ((0)) FOR [totopdate]
GO
ALTER TABLE [dbo].[img_content] ADD  DEFAULT ((0)) FOR [catalogid]
GO
ALTER TABLE [dbo].[img_content] ADD  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[img_content] ADD  DEFAULT ((0)) FOR [backcatalogid]
GO
ALTER TABLE [dbo].[img_newCatalog] ADD  CONSTRAINT [DF_img_newCatalog_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[img_newCatalog] ADD  CONSTRAINT [DF_img_newCatalog_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[img_newCatalog] ADD  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[img_newContent] ADD  CONSTRAINT [DF_img_newContent_addDate]  DEFAULT (getdate()) FOR [addDate]
GO
ALTER TABLE [dbo].[img_newContent] ADD  CONSTRAINT [DF_img_newContent_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [dbo].[img_newContent] ADD  CONSTRAINT [DF_img_newContent_isDelete]  DEFAULT ((2)) FOR [isDelete]
GO
ALTER TABLE [dbo].[img_newTitle] ADD  CONSTRAINT [DF_img_newTitle_toTop]  DEFAULT ((0)) FOR [toTop]
GO
ALTER TABLE [dbo].[img_newTitle] ADD  CONSTRAINT [DF_img_newTitle_toSink]  DEFAULT ((0)) FOR [toSink]
GO
ALTER TABLE [dbo].[img_newTitle] ADD  CONSTRAINT [DF_img_newTitle_topTime]  DEFAULT (getdate()) FOR [topTime]
GO
ALTER TABLE [dbo].[img_newTitle] ADD  CONSTRAINT [DF_img_newTitle_sinkTime]  DEFAULT (getdate()) FOR [sinkTime]
GO
ALTER TABLE [dbo].[img_newTitle] ADD  CONSTRAINT [DF_img_newTitle_firstContentId]  DEFAULT ((0)) FOR [contentId]
GO
ALTER TABLE [dbo].[img_newTitle] ADD  CONSTRAINT [DF_img_newTitle_type]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[img_newTitle] ADD  CONSTRAINT [DF_img_newTitle_isDelete]  DEFAULT ((2)) FOR [isDelete]
GO
ALTER TABLE [dbo].[img_newTitle] ADD  CONSTRAINT [DF_img_newTitle_addDate]  DEFAULT (getdate()) FOR [addDate]
GO
ALTER TABLE [dbo].[img_newTitle] ADD  CONSTRAINT [DF_img_newTitle_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [dbo].[img_title] ADD  CONSTRAINT [DF_img_title_type]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[img_title] ADD  CONSTRAINT [DF_img_title_addDate]  DEFAULT (getdate()) FOR [addDate]
GO
ALTER TABLE [dbo].[img_title] ADD  CONSTRAINT [DF_img_title_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [dbo].[img_title] ADD  CONSTRAINT [DF_img_title_isDelete]  DEFAULT ((2)) FOR [isDelete]
GO
ALTER TABLE [dbo].[img_title] ADD  CONSTRAINT [DF__img_title__backc__4A60E4FA]  DEFAULT ((0)) FOR [backcatalogid]
GO
ALTER TABLE [dbo].[job_catalog] ADD  CONSTRAINT [DF_job_catalog_isDelete]  DEFAULT ((0)) FOR [isDelete]
GO
ALTER TABLE [dbo].[job_catalog] ADD  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_hdtitle]  DEFAULT ('') FOR [hdtitle]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_photourl]  DEFAULT ('') FOR [photourl]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_addadmin]  DEFAULT ('') FOR [addadmin]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_upadmin]  DEFAULT ('') FOR [upadmin]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_hdcontent]  DEFAULT ('') FOR [hdcontent]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_hdcity]  DEFAULT ((0)) FOR [hdcity]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_hdkanbrand]  DEFAULT ((0)) FOR [hdkanbrand]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_hdkanserial]  DEFAULT ((0)) FOR [hdkanserial]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_addtime]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[kan_active] ADD  CONSTRAINT [DF_kan_active_uptime]  DEFAULT (getdate()) FOR [uptime]
GO
ALTER TABLE [dbo].[kan_active] ADD  DEFAULT (getdate()) FOR [starttime]
GO
ALTER TABLE [dbo].[kan_active] ADD  DEFAULT (getdate()) FOR [endtime]
GO
ALTER TABLE [dbo].[kan_bbshistory] ADD  CONSTRAINT [DF_kan_bbshistory_userid]  DEFAULT ((0)) FOR [userid]
GO
ALTER TABLE [dbo].[kan_bbshistory] ADD  CONSTRAINT [DF_kan_bbshistory_baomingdate]  DEFAULT (getdate()) FOR [baomingdate]
GO
ALTER TABLE [dbo].[kan_bmtodealer] ADD  CONSTRAINT [DF_kan_bmtodealer_kcbmid]  DEFAULT ((0)) FOR [kcbmid]
GO
ALTER TABLE [dbo].[kan_bmtodealer] ADD  CONSTRAINT [DF_kan_bmtodealer_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[kan_bmtodealer] ADD  CONSTRAINT [DF_kan_bmtodealer_dealstate]  DEFAULT ((0)) FOR [dealstate]
GO
ALTER TABLE [dbo].[kan_bmtodealer] ADD  DEFAULT (getdate()) FOR [pushtime]
GO
ALTER TABLE [dbo].[kan_bmtodealer] ADD  DEFAULT ((0)) FOR [eid]
GO
ALTER TABLE [dbo].[kan_BMVisitHistory] ADD  CONSTRAINT [DF_kan_BMVisitHistory_visitdate]  DEFAULT (getdate()) FOR [visitdate]
GO
ALTER TABLE [dbo].[kan_BMVisitHistory] ADD  CONSTRAINT [DF_kan_BMVisitHistory_baomingId]  DEFAULT ((0)) FOR [baomingId]
GO
ALTER TABLE [dbo].[kan_citybrand] ADD  CONSTRAINT [DF_kan_citybrand_bid]  DEFAULT ((0)) FOR [bid]
GO
ALTER TABLE [dbo].[kan_citybrand] ADD  CONSTRAINT [DF_kan_citybrand_cityid]  DEFAULT ((0)) FOR [cityid]
GO
ALTER TABLE [dbo].[kan_citybrand] ADD  CONSTRAINT [DF_kan_citybrand_sortid]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[kan_giftreq] ADD  CONSTRAINT [DF_kan_giftreq_stat]  DEFAULT ((0)) FOR [state]
GO
ALTER TABLE [dbo].[kan_giftreq] ADD  CONSTRAINT [DF_kan_giftreq_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[kan_kanchebrand] ADD  CONSTRAINT [DF_kan_kanchebrand_sortid]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[kan_kanchebrand] ADD  DEFAULT ((0)) FOR [chengdusortid]
GO
ALTER TABLE [dbo].[kan_keyword] ADD  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[kan_serial] ADD  CONSTRAINT [DF_kan_serial_isuse]  DEFAULT ((1)) FOR [isuse]
GO
ALTER TABLE [dbo].[kan_tempkeyword] ADD  CONSTRAINT [DF_kan_tempkeyword_times]  DEFAULT ((1)) FOR [times]
GO
ALTER TABLE [dbo].[kan_tempkeyword] ADD  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[kan_totalbaoming] ADD  CONSTRAINT [DF_kan_totalbaoming_activetype]  DEFAULT (N'0-') FOR [activetype]
GO
ALTER TABLE [dbo].[kan_totalbaoming] ADD  CONSTRAINT [DF_kan_totalbaoming_sex]  DEFAULT ((-1)) FOR [sex]
GO
ALTER TABLE [dbo].[kan_totalbaoming] ADD  CONSTRAINT [DF_kan_totalbaoming_hasbuy]  DEFAULT ((-1)) FOR [hasbuy]
GO
ALTER TABLE [dbo].[kan_totalbaoming] ADD  CONSTRAINT [DF_kan_totalbaoming_paymonth]  DEFAULT ('') FOR [paymonth]
GO
ALTER TABLE [dbo].[kan_totalbaoming] ADD  CONSTRAINT [DF_kan_totalbaoming_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[kan_totalbaoming] ADD  CONSTRAINT [DF_kan_totalbaoming_state]  DEFAULT ((0)) FOR [state]
GO
ALTER TABLE [dbo].[kan_totalbaoming] ADD  DEFAULT ((0)) FOR [areaid]
GO
ALTER TABLE [dbo].[kan_totalbaoming] ADD  DEFAULT ((0)) FOR [brandid]
GO
ALTER TABLE [dbo].[kan_totalbaoming] ADD  DEFAULT ((0)) FOR [serialid]
GO
ALTER TABLE [dbo].[key_answer] ADD  CONSTRAINT [DF_key_answer_acheck]  DEFAULT ((0)) FOR [acheck]
GO
ALTER TABLE [dbo].[key_answer] ADD  CONSTRAINT [DF_key_answer_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[key_answer] ADD  CONSTRAINT [DF__key_answe__addti__2F42DA6A]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[key_answer] ADD  CONSTRAINT [DF__key_answe__usern__33136B4E]  DEFAULT ('') FOR [username]
GO
ALTER TABLE [dbo].[key_answer] ADD  DEFAULT ((0)) FOR [isshielded]
GO
ALTER TABLE [dbo].[key_answer] ADD  DEFAULT ((0)) FOR [support]
GO
ALTER TABLE [dbo].[key_answer] ADD  DEFAULT ((0)) FOR [oppose]
GO
ALTER TABLE [dbo].[key_answer] ADD  DEFAULT ((0)) FOR [hascookie]
GO
ALTER TABLE [dbo].[key_keyhot] ADD  CONSTRAINT [DF_key_keyhot_ctse]  DEFAULT ((0)) FOR [ctse]
GO
ALTER TABLE [dbo].[key_keyhot] ADD  CONSTRAINT [DF_key_keyhot_canquestion]  DEFAULT ((1)) FOR [canquestions]
GO
ALTER TABLE [dbo].[key_keyhot] ADD  CONSTRAINT [DF_key_keyhot_keyword]  DEFAULT ('') FOR [keyword]
GO
ALTER TABLE [dbo].[key_keyrule] ADD  CONSTRAINT [DF_key_keyrule_resultserial]  DEFAULT ((0)) FOR [rserial]
GO
ALTER TABLE [dbo].[key_keyrule] ADD  CONSTRAINT [DF_key_keyrule_resultkey]  DEFAULT ((0)) FOR [rkey]
GO
ALTER TABLE [dbo].[key_keyrule] ADD  CONSTRAINT [DF_key_keyrule_state]  DEFAULT ((0)) FOR [state]
GO
ALTER TABLE [dbo].[key_keyrule] ADD  CONSTRAINT [DF_key_keyrule_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[key_keyrule] ADD  CONSTRAINT [DF_key_keyrule_maxserial]  DEFAULT ((0)) FOR [maxserial]
GO
ALTER TABLE [dbo].[key_NewsZt] ADD  CONSTRAINT [DF_key_NewsZt_keyID]  DEFAULT ((0)) FOR [keyID]
GO
ALTER TABLE [dbo].[key_NewsZt] ADD  DEFAULT ((0)) FOR [serialID]
GO
ALTER TABLE [dbo].[key_NewsZt] ADD  DEFAULT ((0)) FOR [isPublish]
GO
ALTER TABLE [dbo].[key_questions] ADD  CONSTRAINT [DF_key_questions_keyid]  DEFAULT ((0)) FOR [keyid]
GO
ALTER TABLE [dbo].[key_questions] ADD  CONSTRAINT [DF_key_questions_serialid]  DEFAULT ((0)) FOR [serialid]
GO
ALTER TABLE [dbo].[key_questions] ADD  CONSTRAINT [DF_key_questions_state]  DEFAULT ((0)) FOR [state]
GO
ALTER TABLE [dbo].[key_questions] ADD  CONSTRAINT [DF_key_questions_qcheck]  DEFAULT ((0)) FOR [qcheck]
GO
ALTER TABLE [dbo].[key_questions] ADD  CONSTRAINT [DF_key_questions_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[key_questions] ADD  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[key_questions] ADD  DEFAULT ((0)) FOR [browses]
GO
ALTER TABLE [dbo].[key_questions] ADD  DEFAULT ('') FOR [username]
GO
ALTER TABLE [dbo].[key_questions] ADD  CONSTRAINT [DF_key_questions_answerCount]  DEFAULT ((0)) FOR [answerCount]
GO
ALTER TABLE [dbo].[key_questions] ADD  CONSTRAINT [DF_key_questions_answertime]  DEFAULT (getdate()) FOR [answertime]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  CONSTRAINT [DF_key_relatedsearch_issearched]  DEFAULT ((0)) FOR [issearched]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  CONSTRAINT [DF_key_relatedsearch_hascontent]  DEFAULT ((0)) FOR [hascontent]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  CONSTRAINT [DF__key_relate__path__0C54CCD6]  DEFAULT ('.') FOR [path]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  DEFAULT ((0)) FOR [serialid]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  DEFAULT ((0)) FOR [rulekeyid]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  DEFAULT ((0)) FOR [playlevel]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  DEFAULT (getdate()) FOR [infnexttime]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  DEFAULT (getdate()) FOR [autonexttime]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  DEFAULT (getdate()) FOR [bbsnexttime]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  DEFAULT (getdate()) FOR [wwwnexttime]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  DEFAULT ((0)) FOR [viewCount]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  DEFAULT ((0)) FOR [yesterdayCount]
GO
ALTER TABLE [dbo].[key_relatedsearch] ADD  DEFAULT ((0)) FOR [todayCount]
GO
ALTER TABLE [dbo].[key_searchcontent] ADD  CONSTRAINT [DF_key_searchcontent_newsid]  DEFAULT ((0)) FOR [newsid]
GO
ALTER TABLE [dbo].[m315_bug] ADD  CONSTRAINT [DF_m315_bug_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[mbg_content] ADD  CONSTRAINT [DF_mbg_content_replyid]  DEFAULT ((0)) FOR [replyid]
GO
ALTER TABLE [dbo].[mbg_content] ADD  CONSTRAINT [DF_mbg_content_forwardroot]  DEFAULT ((0)) FOR [forwardroot]
GO
ALTER TABLE [dbo].[mbg_content] ADD  CONSTRAINT [DF_mbg_content_forwardform]  DEFAULT ((0)) FOR [forwardform]
GO
ALTER TABLE [dbo].[mbg_content] ADD  CONSTRAINT [DF_mbg_content_addtime]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[mbg_content] ADD  CONSTRAINT [DF_mbg_content_type]  DEFAULT ((1)) FOR [type]
GO
ALTER TABLE [dbo].[mbg_followinfo] ADD  CONSTRAINT [DF_mbg_followinfo_followtime]  DEFAULT (getdate()) FOR [followtime]
GO
ALTER TABLE [dbo].[mbg_online] ADD  CONSTRAINT [DF_mbg_online_time]  DEFAULT (getdate()) FOR [time]
GO
ALTER TABLE [dbo].[msg_1] ADD  CONSTRAINT [DF_msg_1_keyid]  DEFAULT ((0)) FOR [keyid]
GO
ALTER TABLE [dbo].[msg_1] ADD  CONSTRAINT [DF_msg_1_posterid]  DEFAULT ((0)) FOR [posterid]
GO
ALTER TABLE [dbo].[msg_1] ADD  CONSTRAINT [DF_msg_1_msgstate]  DEFAULT ((0)) FOR [msgstate]
GO
ALTER TABLE [dbo].[msg_1] ADD  CONSTRAINT [DF_msg_1_sortid]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[msg_1] ADD  CONSTRAINT [DF_msg_1_expandkey]  DEFAULT ('') FOR [expandkey]
GO
ALTER TABLE [dbo].[msg_1] ADD  CONSTRAINT [DF_msg_1_nickname]  DEFAULT ('') FOR [nickname]
GO
ALTER TABLE [dbo].[msg_1] ADD  CONSTRAINT [DF_msg_1_message]  DEFAULT ('') FOR [message]
GO
ALTER TABLE [dbo].[msg_1] ADD  CONSTRAINT [DF_msg_1_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[msg_1] ADD  DEFAULT ((0)) FOR [hascookie]
GO
ALTER TABLE [dbo].[msg_2] ADD  CONSTRAINT [DF_msg_2_keyid]  DEFAULT ((0)) FOR [keyid]
GO
ALTER TABLE [dbo].[msg_2] ADD  CONSTRAINT [DF_msg_2_posterid]  DEFAULT ((0)) FOR [posterid]
GO
ALTER TABLE [dbo].[msg_2] ADD  CONSTRAINT [DF_msg_2_msgstate]  DEFAULT ((0)) FOR [msgstate]
GO
ALTER TABLE [dbo].[msg_2] ADD  CONSTRAINT [DF_msg_2_sortid]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[msg_2] ADD  CONSTRAINT [DF_msg_2_expandkey]  DEFAULT ('') FOR [expandkey]
GO
ALTER TABLE [dbo].[msg_2] ADD  CONSTRAINT [DF_msg_2_nickname]  DEFAULT ('') FOR [nickname]
GO
ALTER TABLE [dbo].[msg_2] ADD  CONSTRAINT [DF_msg_2_message]  DEFAULT ('') FOR [message]
GO
ALTER TABLE [dbo].[msg_2] ADD  CONSTRAINT [DF_msg_2_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[msg_2] ADD  DEFAULT ((0)) FOR [hascookie]
GO
ALTER TABLE [dbo].[msg_3] ADD  CONSTRAINT [DF_msg_3_keyid]  DEFAULT ((0)) FOR [keyid]
GO
ALTER TABLE [dbo].[msg_3] ADD  CONSTRAINT [DF_msg_3_posterid]  DEFAULT ((0)) FOR [posterid]
GO
ALTER TABLE [dbo].[msg_3] ADD  CONSTRAINT [DF_msg_3_msgstate]  DEFAULT ((0)) FOR [msgstate]
GO
ALTER TABLE [dbo].[msg_3] ADD  CONSTRAINT [DF_msg_3_sortid]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[msg_3] ADD  CONSTRAINT [DF_msg_3_expandkey]  DEFAULT ('') FOR [expandkey]
GO
ALTER TABLE [dbo].[msg_3] ADD  CONSTRAINT [DF_msg_3_nickname]  DEFAULT ('') FOR [nickname]
GO
ALTER TABLE [dbo].[msg_3] ADD  CONSTRAINT [DF_msg_3_message]  DEFAULT ('') FOR [message]
GO
ALTER TABLE [dbo].[msg_3] ADD  CONSTRAINT [DF_msg_3_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[msg_3] ADD  DEFAULT ((0)) FOR [hascookie]
GO
ALTER TABLE [dbo].[msg_4] ADD  CONSTRAINT [DF_msg_4_keyid]  DEFAULT ((0)) FOR [keyid]
GO
ALTER TABLE [dbo].[msg_4] ADD  CONSTRAINT [DF_msg_4_posterid]  DEFAULT ((0)) FOR [posterid]
GO
ALTER TABLE [dbo].[msg_4] ADD  CONSTRAINT [DF_msg_4_msgstate]  DEFAULT ((0)) FOR [msgstate]
GO
ALTER TABLE [dbo].[msg_4] ADD  CONSTRAINT [DF_msg_4_sortid]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[msg_4] ADD  CONSTRAINT [DF_msg_4_expandkey]  DEFAULT ('') FOR [expandkey]
GO
ALTER TABLE [dbo].[msg_4] ADD  CONSTRAINT [DF_msg_4_nickname]  DEFAULT ('') FOR [nickname]
GO
ALTER TABLE [dbo].[msg_4] ADD  CONSTRAINT [DF_msg_4_message]  DEFAULT ('') FOR [message]
GO
ALTER TABLE [dbo].[msg_4] ADD  CONSTRAINT [DF_msg_4_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[msg_4] ADD  DEFAULT ((0)) FOR [hascookie]
GO
ALTER TABLE [dbo].[msg_jiucuo] ADD  CONSTRAINT [DF_msg_jiucuo_fatherid]  DEFAULT ((0)) FOR [fatherid]
GO
ALTER TABLE [dbo].[msg_jiucuo] ADD  CONSTRAINT [DF_msg_jiucuo_addtime]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[new_cache] ADD  CONSTRAINT [DF_new_cache2_carpath]  DEFAULT ('') FOR [carpath]
GO
ALTER TABLE [dbo].[new_cache] ADD  CONSTRAINT [DF_new_cache2_newspath]  DEFAULT ('') FOR [newspath]
GO
ALTER TABLE [dbo].[new_cache] ADD  CONSTRAINT [DF_new_cache2_brandid]  DEFAULT ((0)) FOR [brandid]
GO
ALTER TABLE [dbo].[new_catalog] ADD  CONSTRAINT [DF_new_catalog_isDelete]  DEFAULT ((0)) FOR [isDelete]
GO
ALTER TABLE [dbo].[new_catalog] ADD  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[new_content] ADD  CONSTRAINT [DF_new_content_areaId]  DEFAULT ((0)) FOR [areaId]
GO
ALTER TABLE [dbo].[new_content] ADD  CONSTRAINT [DF_new_content_carcatalogId]  DEFAULT ((0)) FOR [carcatalogId]
GO
ALTER TABLE [dbo].[new_content] ADD  CONSTRAINT [DF_new_content_addDate]  DEFAULT (getdate()) FOR [addDate]
GO
ALTER TABLE [dbo].[new_content] ADD  CONSTRAINT [DF_new_content_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [dbo].[new_content] ADD  CONSTRAINT [DF_new_content_sortId]  DEFAULT ((0)) FOR [sortId]
GO
ALTER TABLE [dbo].[new_content] ADD  CONSTRAINT [DF_new_content_isDelete]  DEFAULT ((2)) FOR [isDelete]
GO
ALTER TABLE [dbo].[new_content] ADD  CONSTRAINT [DF__new_conte__seria__478E99F0]  DEFAULT ((0)) FOR [serialid]
GO
ALTER TABLE [dbo].[new_keychangeRec] ADD  CONSTRAINT [DF_new_keychangeRec_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[new_keylibrary] ADD  CONSTRAINT [DF_new_keylibrary_keywords]  DEFAULT ('') FOR [keywords]
GO
ALTER TABLE [dbo].[new_keylibrary] ADD  CONSTRAINT [DF_new_keylibrary_url]  DEFAULT ('') FOR [url]
GO
ALTER TABLE [dbo].[new_keylibrary] ADD  DEFAULT ((0)) FOR [baikeid]
GO
ALTER TABLE [dbo].[new_keylibrary] ADD  DEFAULT ('') FOR [backurl]
GO
ALTER TABLE [dbo].[new_keylibrary] ADD  DEFAULT ((0)) FOR [serialid]
GO
ALTER TABLE [dbo].[new_keywordindex] ADD  CONSTRAINT [DF_new_keywordindex_newsid]  DEFAULT ((0)) FOR [newsid]
GO
ALTER TABLE [dbo].[new_keywordindex] ADD  CONSTRAINT [DF_new_keywordindex_contentid]  DEFAULT ((0)) FOR [contentid]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_areaId]  DEFAULT (0) FOR [areaId]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_carcatalogId]  DEFAULT (0) FOR [carcatalogId]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_toTop]  DEFAULT (0) FOR [toTop]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_toSink]  DEFAULT (0) FOR [toSink]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_gradeId1]  DEFAULT (0) FOR [gradeId1]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_gradeId2]  DEFAULT (0) FOR [gradeId2]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_gradeId3]  DEFAULT (0) FOR [gradeId3]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_gradeId4]  DEFAULT (0) FOR [gradeId4]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_gradeId5]  DEFAULT (0) FOR [gradeId5]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_addDate]  DEFAULT (getdate()) FOR [addDate]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_isDelete]  DEFAULT (2) FOR [isDelete]
GO
ALTER TABLE [dbo].[new_news] ADD  DEFAULT (0) FOR [isPhoto]
GO
ALTER TABLE [dbo].[new_news] ADD  DEFAULT ((0)) FOR [isOriginal]
GO
ALTER TABLE [dbo].[new_news] ADD  DEFAULT ((0)) FOR [IsImgNews]
GO
ALTER TABLE [dbo].[new_news] ADD  DEFAULT ((0)) FOR [pricedown]
GO
ALTER TABLE [dbo].[new_news] ADD  DEFAULT ((0)) FOR [serialid]
GO
ALTER TABLE [dbo].[new_news] ADD  CONSTRAINT [DF_new_news_chktitlephoto]  DEFAULT ((0)) FOR [chktitlephoto]
GO
ALTER TABLE [dbo].[new_news] ADD  DEFAULT ((0)) FOR [chkdescription]
GO
ALTER TABLE [dbo].[new_news] ADD  DEFAULT ((0)) FOR [islook]
GO
ALTER TABLE [dbo].[new_recommended] ADD  CONSTRAINT [DF_new_recommended_isDelete]  DEFAULT (2) FOR [isDelete]
GO
ALTER TABLE [dbo].[new_recommended] ADD  CONSTRAINT [DF_new_recommended_sortId]  DEFAULT (0) FOR [sortId]
GO
ALTER TABLE [dbo].[new_related] ADD  CONSTRAINT [DF_new_related_title]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[news_cuxiaonews] ADD  CONSTRAINT [DF_news_cuxiaonews_newsid]  DEFAULT ((0)) FOR [newsid]
GO
ALTER TABLE [dbo].[pagetitlectr] ADD  CONSTRAINT [DF_pagetitlectr_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[pk_voteCount] ADD  CONSTRAINT [DF_pk_voteCount_ztid]  DEFAULT ((0)) FOR [ztid]
GO
ALTER TABLE [dbo].[pk_voteCount] ADD  CONSTRAINT [DF_pk_voteCount_voteApp1Count]  DEFAULT ((0)) FOR [voteApp1Count]
GO
ALTER TABLE [dbo].[pk_voteCount] ADD  CONSTRAINT [DF_pk_voteCount_voteApp2Count]  DEFAULT ((0)) FOR [voteApp2Count]
GO
ALTER TABLE [dbo].[pk_voteCount] ADD  CONSTRAINT [DF_pk_voteCount_voteSeat1Count]  DEFAULT ((0)) FOR [voteSeat1Count]
GO
ALTER TABLE [dbo].[pk_voteCount] ADD  CONSTRAINT [DF_pk_voteCount_voteSeat2Count]  DEFAULT ((0)) FOR [voteSeat2Count]
GO
ALTER TABLE [dbo].[pk_voteCount] ADD  CONSTRAINT [DF_pk_voteCount_voteCtrl1Count]  DEFAULT ((0)) FOR [voteCtrl1Count]
GO
ALTER TABLE [dbo].[pk_voteCount] ADD  CONSTRAINT [DF_pk_voteCount_voteCtrl2Count]  DEFAULT ((0)) FOR [voteCtrl2Count]
GO
ALTER TABLE [dbo].[pkzt_info] ADD  CONSTRAINT [DF_pkzt_info_carid1]  DEFAULT ((0)) FOR [carid1]
GO
ALTER TABLE [dbo].[pkzt_info] ADD  CONSTRAINT [DF_pkzt_info_carid2]  DEFAULT ((0)) FOR [carid2]
GO
ALTER TABLE [dbo].[pkzt_info] ADD  CONSTRAINT [DF_pkzt_info_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[pkzt_info] ADD  CONSTRAINT [DF_pkzt_info_uptime]  DEFAULT (getdate()) FOR [uptime]
GO
ALTER TABLE [dbo].[pkzt_info] ADD  CONSTRAINT [DF_pkzt_info_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[prd_proxy] ADD  CONSTRAINT [DF_prd_proxy_port]  DEFAULT ((80)) FOR [port]
GO
ALTER TABLE [dbo].[prd_proxy] ADD  CONSTRAINT [DF_prd_proxy_enable]  DEFAULT ((0)) FOR [enable]
GO
ALTER TABLE [dbo].[prd_relatedcarid] ADD  CONSTRAINT [DF_prd_relatedcarid_selfcarid]  DEFAULT ((0)) FOR [selfcarid]
GO
ALTER TABLE [dbo].[prd_relatedcarid] ADD  CONSTRAINT [DF_prd_relatedcarid_disselfcarid]  DEFAULT ((0)) FOR [disselfcarid]
GO
ALTER TABLE [dbo].[prd_relatedcarid] ADD  CONSTRAINT [DF_prd_relatedcarid_webid]  DEFAULT ((0)) FOR [webid]
GO
ALTER TABLE [dbo].[prd_webrule] ADD  CONSTRAINT [DF_prd_webrule_webtype]  DEFAULT ((0)) FOR [webtype]
GO
ALTER TABLE [dbo].[prd_webrule] ADD  CONSTRAINT [DF_prd_webrule_hasprice]  DEFAULT ((0)) FOR [hasprice]
GO
ALTER TABLE [dbo].[prd_webrule] ADD  CONSTRAINT [DF_prd_webrule_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[prd_webrule] ADD  CONSTRAINT [DF_prd_webrule_totalsearchcount]  DEFAULT ((0)) FOR [totalsearchcount]
GO
ALTER TABLE [dbo].[prd_webrule] ADD  CONSTRAINT [DF_prd_webrule_priceurl]  DEFAULT ('') FOR [priceurl]
GO
ALTER TABLE [dbo].[prd_webrule] ADD  CONSTRAINT [DF_prd_webrule_priceregex]  DEFAULT ('') FOR [priceregex]
GO
ALTER TABLE [dbo].[pro_carindex] ADD  CONSTRAINT [DF_pro_carindex_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[pub_ad] ADD  CONSTRAINT [DF__pub_ad__isDefaul__1BD01343]  DEFAULT ((0)) FOR [isDefault]
GO
ALTER TABLE [dbo].[pub_ad] ADD  DEFAULT ((0)) FOR [areakeyid]
GO
ALTER TABLE [dbo].[pub_ad] ADD  CONSTRAINT [DF_pub_ad_isverify]  DEFAULT ((0)) FOR [isverify]
GO
ALTER TABLE [dbo].[pub_AdClick] ADD  CONSTRAINT [DF_pub_AdClick_sid]  DEFAULT ((0)) FOR [sid]
GO
ALTER TABLE [dbo].[pub_AdClick] ADD  CONSTRAINT [DF__pub_AdCli__isVis__4B3FFA9A]  DEFAULT ((0)) FOR [isVisitCount]
GO
ALTER TABLE [dbo].[pub_AdClickAuto] ADD  CONSTRAINT [DF_pub_AdClickAuto_sid]  DEFAULT ((0)) FOR [sid]
GO
ALTER TABLE [dbo].[pub_AdClickAuto] ADD  CONSTRAINT [DF_pub_AdClickAuto_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[pub_AdClickAuto] ADD  DEFAULT ((0)) FOR [isVisitCount]
GO
ALTER TABLE [dbo].[pub_AdClickhand] ADD  CONSTRAINT [DF_pub_AdClickhand_sid]  DEFAULT ((0)) FOR [sid]
GO
ALTER TABLE [dbo].[pub_AdClickhand] ADD  CONSTRAINT [DF_pub_AdClickhand_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[pub_AdClickhand] ADD  DEFAULT ((0)) FOR [isVisitCount]
GO
ALTER TABLE [dbo].[pub_adCount] ADD  DEFAULT ((0)) FOR [click]
GO
ALTER TABLE [dbo].[pub_adCount] ADD  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[pub_blockipug] ADD  CONSTRAINT [DF_pub_blockipug_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[pub_defad] ADD  DEFAULT ((1)) FOR [sortId]
GO
ALTER TABLE [dbo].[pub_editorTemplate] ADD  CONSTRAINT [DF_pub_editorTemplate_isDelete]  DEFAULT ((0)) FOR [isDelete]
GO
ALTER TABLE [dbo].[pub_emailsend] ADD  CONSTRAINT [DF_pub_emailsend_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[pub_emailsend] ADD  CONSTRAINT [DF_pub_emailsend_sendtime]  DEFAULT ((0)) FOR [sendtime]
GO
ALTER TABLE [dbo].[pub_formitpost] ADD  CONSTRAINT [DF_pub_formitpost_addtime]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[pub_ipdata] ADD  CONSTRAINT [DF_pub_ipdata_haschecked]  DEFAULT ((0)) FOR [haschecked]
GO
ALTER TABLE [dbo].[pub_message] ADD  CONSTRAINT [DF_pub_message_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[pub_message] ADD  DEFAULT ((0)) FOR [checkstat]
GO
ALTER TABLE [dbo].[pub_message] ADD  DEFAULT ((0)) FOR [isBright]
GO
ALTER TABLE [dbo].[pub_message] ADD  DEFAULT ('') FOR [realUserName]
GO
ALTER TABLE [dbo].[pub_message] ADD  DEFAULT ((0)) FOR [brightPkZtid]
GO
ALTER TABLE [dbo].[pub_message] ADD  DEFAULT ((0)) FOR [topCount]
GO
ALTER TABLE [dbo].[pub_message] ADD  DEFAULT ((0)) FOR [support]
GO
ALTER TABLE [dbo].[pub_message] ADD  DEFAULT ((0)) FOR [oppose]
GO
ALTER TABLE [dbo].[pub_pinganbaoming] ADD  CONSTRAINT [DF_pub_pinganbaoming_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[pub_smsdata] ADD  CONSTRAINT [DF_pub_smsdata_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[pub_smsdata] ADD  CONSTRAINT [DF_pub_smsdata_itype]  DEFAULT ((0)) FOR [itype]
GO
ALTER TABLE [dbo].[pub_smsdatabak] ADD  CONSTRAINT [DF_pub_smsdatabak_itype]  DEFAULT ((0)) FOR [itype]
GO
ALTER TABLE [dbo].[pub_tablecatalog] ADD  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[pub_tablecontent] ADD  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[pub_temp] ADD  CONSTRAINT [DF_pub_temp_type]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[pub_temp] ADD  CONSTRAINT [DF_pub_temp_data]  DEFAULT ((0)) FOR [data]
GO
ALTER TABLE [dbo].[pzt_carinfo] ADD  CONSTRAINT [DF_pzt_carinfo_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[pzt_carinfo] ADD  CONSTRAINT [DF_pzt_carinfo_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[pzt_comment] ADD  CONSTRAINT [DF_pzt_comment_carid]  DEFAULT ((0)) FOR [carid]
GO
ALTER TABLE [dbo].[pzt_comment] ADD  CONSTRAINT [DF_pzt_comment_msgtype]  DEFAULT ((0)) FOR [msgtype]
GO
ALTER TABLE [dbo].[pzt_comment] ADD  CONSTRAINT [DF_pzt_comment_isBright]  DEFAULT ((0)) FOR [isBright]
GO
ALTER TABLE [dbo].[pzt_comment] ADD  CONSTRAINT [DF_pzt_comment_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[pzt_comment] ADD  CONSTRAINT [DF__pzt_comme__sorti__2F4A9A06]  DEFAULT ((0)) FOR [sortid]
GO
ALTER TABLE [dbo].[rne_catalog] ADD  CONSTRAINT [DF_rne_catalog_isDelete]  DEFAULT ((0)) FOR [isDelete]
GO
ALTER TABLE [dbo].[rne_catalog] ADD  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[sit_catalog] ADD  CONSTRAINT [DF_sit_catalog_isdelete]  DEFAULT (0) FOR [isdelete]
GO
ALTER TABLE [dbo].[sit_catalog] ADD  DEFAULT ((0)) FOR [pathlevel]
GO
ALTER TABLE [dbo].[skn_ctrl] ADD  CONSTRAINT [DF_skn_ctrl_isdelete]  DEFAULT (0) FOR [isdelete]
GO
ALTER TABLE [dbo].[skn_ctrl] ADD  CONSTRAINT [DF_skn_ctrl_updatetime]  DEFAULT (getdate()) FOR [updatetime]
GO
ALTER TABLE [dbo].[skn_page] ADD  CONSTRAINT [DF_skn_page_isdelete]  DEFAULT (0) FOR [isdelete]
GO
ALTER TABLE [dbo].[skn_page] ADD  CONSTRAINT [DF_skn_page_updatetime]  DEFAULT (getdate()) FOR [updatetime]
GO
ALTER TABLE [dbo].[sub_data] ADD  CONSTRAINT [DF_sub_data_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[sub_data] ADD  DEFAULT ((0)) FOR [isad]
GO
ALTER TABLE [dbo].[T_dealerWXTJ] ADD  CONSTRAINT [DF_T_dealerWXTJ_ClickNum]  DEFAULT ((0)) FOR [ClickNum]
GO
ALTER TABLE [dbo].[T_dealerWXTJ] ADD  CONSTRAINT [DF_T_dealerWXTJ_ReleaseNum]  DEFAULT ((0)) FOR [ReleaseNum]
GO
ALTER TABLE [dbo].[T_dealerWXTJ] ADD  CONSTRAINT [DF_T_dealerWXTJ_ReadNum]  DEFAULT ((0)) FOR [ReadNum]
GO
ALTER TABLE [dbo].[T_dealerWXTJ] ADD  CONSTRAINT [DF_T_dealerWXTJ_ReprintNum]  DEFAULT ((0)) FOR [ReprintNum]
GO
ALTER TABLE [dbo].[T_dealerWXTJ] ADD  CONSTRAINT [DF_T_dealerWXTJ_AskNum]  DEFAULT ((0)) FOR [AskNum]
GO
ALTER TABLE [dbo].[T_dealerWXTJ] ADD  CONSTRAINT [DF_T_dealerWXTJ_PreMain]  DEFAULT ((0)) FOR [PreMain]
GO
ALTER TABLE [dbo].[T_dealerWXTJ] ADD  CONSTRAINT [DF_T_dealerWXTJ_PreDrive]  DEFAULT ((0)) FOR [PreDrive]
GO
ALTER TABLE [dbo].[T_dealerWXTJ] ADD  CONSTRAINT [DF_T_dealerWXTJ_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[T_dealerWXTJ] ADD  CONSTRAINT [DF_T_dealerWXTJ_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[T_dealerWXTJ] ADD  DEFAULT ((0)) FOR [RID]
GO
ALTER TABLE [dbo].[TClick] ADD  CONSTRAINT [DF_T_addtime]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[tmp_2014count] ADD  CONSTRAINT [DF_tmp_2014count_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[TNewsEditorClick] ADD  CONSTRAINT [DF_new_editorClick_tid]  DEFAULT ((0)) FOR [tid]
GO
ALTER TABLE [dbo].[TNewsEditorClick] ADD  CONSTRAINT [DF_new_editorClick_addtime]  DEFAULT (getdate()) FOR [addtime]
GO
ALTER TABLE [dbo].[tousu_check] ADD  CONSTRAINT [DF_tousu_check_questionid]  DEFAULT ((0)) FOR [questionid]
GO
ALTER TABLE [dbo].[tousu_check] ADD  CONSTRAINT [DF_tousu_check_selecttype]  DEFAULT ((0)) FOR [selecttype]
GO
ALTER TABLE [dbo].[tousu_check] ADD  CONSTRAINT [DF_tousu_check_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[tuan_baoming] ADD  CONSTRAINT [DF_tuan_baoming_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[tuan_baoming] ADD  CONSTRAINT [DF_tuan_baoming_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[tuan_baoming] ADD  CONSTRAINT [DF_tuan_baoming_dealstate]  DEFAULT ((0)) FOR [dealstate]
GO
ALTER TABLE [dbo].[tuan_brand] ADD  CONSTRAINT [DF_tuan_brand_brandid]  DEFAULT ((0)) FOR [brandid]
GO
ALTER TABLE [dbo].[tuan_brand] ADD  CONSTRAINT [DF_tuan_suncar_areaid]  DEFAULT ((0)) FOR [areaid]
GO
ALTER TABLE [dbo].[tuan_brand] ADD  CONSTRAINT [DF_tuan_suncar_bmcont]  DEFAULT ((0)) FOR [bmcount]
GO
ALTER TABLE [dbo].[tuan_brand] ADD  CONSTRAINT [DF_tuan_suncar_bbstopicid1]  DEFAULT ((0)) FOR [bbstopicid1]
GO
ALTER TABLE [dbo].[tuan_brand] ADD  CONSTRAINT [DF_tuan_suncar_bbstopicid2]  DEFAULT ((0)) FOR [bbstopicid2]
GO
ALTER TABLE [dbo].[tuan_brand] ADD  CONSTRAINT [DF_tuan_suncar_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[tuan_brand] ADD  CONSTRAINT [DF_tuan_brand_isdelete]  DEFAULT ((0)) FOR [isdelete]
GO
ALTER TABLE [dbo].[tuan_brand] ADD  CONSTRAINT [DF__tuan_bran__price__1DD5BF48]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[vot_Option] ADD  DEFAULT ((0)) FOR [basenum]
GO
ALTER TABLE [dbo].[vot_Reply] ADD  CONSTRAINT [DF_vot_Reply_VoteTime]  DEFAULT (getdate()) FOR [VoteTime]
GO
ALTER TABLE [dbo].[vot_Reply] ADD  DEFAULT ('') FOR [voteIp]
GO
ALTER TABLE [dbo].[vote_phone] ADD  CONSTRAINT [DF_vote_phone_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[vote_phone] ADD  DEFAULT ((0)) FOR [voteid]
GO
ALTER TABLE [dbo].[vote_pingxuan] ADD  CONSTRAINT [DF_vote_pingxuan_votecount]  DEFAULT ((0)) FOR [votecount]
GO
ALTER TABLE [dbo].[vote_pingxuan] ADD  CONSTRAINT [DF_vote_pingxuan_type]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[zht_brightMessageToTop] ADD  CONSTRAINT [DF_zht_brightMessageToTop_topTime]  DEFAULT (getdate()) FOR [topTime]
GO
ALTER TABLE [dbo].[zht_brightUserInfo] ADD  CONSTRAINT [DF_zht_brightUserInfo_addDate]  DEFAULT (getdate()) FOR [addDate]
GO
ALTER TABLE [dbo].[zht_brightUserInfo] ADD  CONSTRAINT [DF_zht_brightUserInfo_isPrize]  DEFAULT ((0)) FOR [isPrize]
GO
ALTER TABLE [dbo].[zht_brightUserInfo] ADD  DEFAULT ((0)) FOR [zid]
GO
ALTER TABLE [dbo].[zht_content] ADD  CONSTRAINT [DF_new_zt_adddate]  DEFAULT (getdate()) FOR [adddate]
GO
ALTER TABLE [dbo].[zht_content] ADD  DEFAULT ((1)) FOR [isHead]
GO
ALTER TABLE [dbo].[zht_content] ADD  DEFAULT (getdate()) FOR [lastCommentDate]
GO
ALTER TABLE [dbo].[zht_pkShowComment] ADD  CONSTRAINT [DF_zht_pkShowComment_leftComment]  DEFAULT ('') FOR [leftComment]
GO
ALTER TABLE [dbo].[zht_pkShowComment] ADD  CONSTRAINT [DF_zht_pkShowComment_rightComment]  DEFAULT ('') FOR [rightComment]
GO
ALTER TABLE [dbo].[zht_subtemplate] ADD  CONSTRAINT [DF_zht_subtemplate_type]  DEFAULT (0) FOR [type]
GO
ALTER TABLE [dbo].[zht_subtemplate] ADD  CONSTRAINT [DF_zht_subtemplate_isdef]  DEFAULT (0) FOR [isdef]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'弹出广告自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popad', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'来源广告id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popad', @level2type=N'COLUMN',@level2name=N'adid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大弹出次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popad', @level2type=N'COLUMN',@level2name=N'poptotaltimes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'剩余弹出次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popad', @level2type=N'COLUMN',@level2name=N'remaintimes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'弹出广告代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popad', @level2type=N'COLUMN',@level2name=N'adstr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识,0--未删除,1--已删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popad', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'弹出广告车系信息自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popadcarinfo', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'弹出广告id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popadcarinfo', @level2type=N'COLUMN',@level2name=N'popaid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'弹出广告车系id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popadcarinfo', @level2type=N'COLUMN',@level2name=N'carid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识,0--未删除,1--已删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popadcarinfo', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'弹出广告日期安排表自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popadschedule', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'弹出广告id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popadschedule', @level2type=N'COLUMN',@level2name=N'popaid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'起始日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popadschedule', @level2type=N'COLUMN',@level2name=N'sdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'结束日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popadschedule', @level2type=N'COLUMN',@level2name=N'edate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识,0--未删除,1--已删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_popadschedule', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车系id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_serialAd', @level2type=N'COLUMN',@level2name=N'carid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板,[#1]为车系名称代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ad_serialAd', @level2type=N'COLUMN',@level2name=N'modelstr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_function', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能点所在页面全限定名(命名空间+路径+类名)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_function', @level2type=N'COLUMN',@level2name=N'page'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能点分类名，方便管理用，不用此表达唯一性' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_function', @level2type=N'COLUMN',@level2name=N'cag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能点名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_function', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否删除状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_function', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_funManage', @level2type=N'COLUMN',@level2name=N'funName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SQL语句' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_funManage', @level2type=N'COLUMN',@level2name=N'funSQL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贴吧目录类型，0--所有，1--贴吧，2--车型，3--新闻' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'barcatalogtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贴吧审核状态，0--所有，1--已审核，2--未审核' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'barverify'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贴吧搜索日期范围' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'bartimearea'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否新闻主题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'isnews'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否被举报主题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'isreport'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否置顶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'baristotop'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否首页置顶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'barisindextop'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'搜索类型，1--搜索主题，2--搜索回复' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'searchtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贴吧主题作者标识cookie' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'barauthorcookie'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贴吧主题作者ip' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'barauthorip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'后台管理菜单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'menulist'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贴吧主题所在目录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'bartitlecatalog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贴吧主题标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'bartitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贴吧主题内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'barcontent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贴吧主题作者' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_hobby', @level2type=N'COLUMN',@level2name=N'barauthor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_user', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_user', @level2type=N'COLUMN',@level2name=N'username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码，MD5加密' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_user', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'真实姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_user', @level2type=N'COLUMN',@level2name=N'realname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_user', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_user', @level2type=N'COLUMN',@level2name=N'udate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_userpermission', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员id，对应adm_user' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_userpermission', @level2type=N'COLUMN',@level2name=N'uid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'功能点id，对应adm_funtion' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_userpermission', @level2type=N'COLUMN',@level2name=N'fid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作许可：0-读取，1-写入，2-发布，3-删除，默认为0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'adm_userpermission', @level2type=N'COLUMN',@level2name=N'opertion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'2--品牌,3--车系,4--车型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ath_carcatalog', @level2type=N'COLUMN',@level2name=N'pathlevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作类型,0--非法,1--新增,2--删除,3--修改,4--移动' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ath_updatedata', @level2type=N'COLUMN',@level2name=N'optiontype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理类型,0--未处理,1--已处理,2--临时数据' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ath_updatedata', @level2type=N'COLUMN',@level2name=N'dealstat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'2--品牌,3--车系,4--车型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ath_updatedata', @level2type=N'COLUMN',@level2name=N'pathlevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1-更换 2-检查 3-视情况而定' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bao_record', @level2type=N'COLUMN',@level2name=N'btype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'民族' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'nation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'身份证号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'cardNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生肖' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'animalYear'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'星座' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'starInfor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'身高' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'height'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'体重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'weight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'血型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'bloodType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自我介绍' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'selfIntroduce'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'mobilephone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮编' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'postNums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'形象图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'userPhoto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'点击率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'clickNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'投票数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'voteNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_user', @level2type=N'COLUMN',@level2name=N'regDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主人id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_visitRecord', @level2type=N'COLUMN',@level2name=N'hostuserid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'拜访人id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'bbs_visitRecord', @level2type=N'COLUMN',@level2name=N'visiterid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'品牌集团关系自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_brandmanage', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'品牌id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_brandmanage', @level2type=N'COLUMN',@level2name=N'brandid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'集团id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_brandmanage', @level2type=N'COLUMN',@level2name=N'groupid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-停产，1-在产，2-未生产' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_catalognew', @level2type=N'COLUMN',@level2name=N'isLive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-停售，1-在售，2-未销售，3-未上市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_catalognew', @level2type=N'COLUMN',@level2name=N'onSale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-海外，1- 国产，2-进口' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_catalognew', @level2type=N'COLUMN',@level2name=N'madein'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-无，1-单厢，2-两厢，3-三厢' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_catalognew', @level2type=N'COLUMN',@level2name=N'xiangti'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-无，1-微型，2-小型，3-紧凑型，4-轻型，5-中型，6-中大型，7-大型，8-豪华，9-超级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_catalognew', @level2type=N'COLUMN',@level2name=N'jibie'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-无，1-轿车，2-跨界车，3-SUV，4-旅行车，5-MPV，6-跑车，7-概念车，8-皮卡，9-客车，10-卡车' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_catalognew', @level2type=N'COLUMN',@level2name=N'leixing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-无，1-手动，2-自动，3-双离合，4-无级变速，5-手自一体(AMT)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_catalognew', @level2type=N'COLUMN',@level2name=N'bsq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用10倍表示，整数，排量存在无的情况，则用-1表示 （0不表示无）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_catalognew', @level2type=N'COLUMN',@level2name=N'pailiang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1-汽油 2-柴油 3-混合动力 4-纯电动 5-天然气' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_catalognew', @level2type=N'COLUMN',@level2name=N'fadongji'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_comment', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车系id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_comment', @level2type=N'COLUMN',@level2name=N'carid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言类型，1--怎么样，2--油耗统计，3--问题(缺点),4-特点(优点),5--保养费用,6--如何省油' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_comment', @level2type=N'COLUMN',@level2name=N'msgtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否精彩评论' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_comment', @level2type=N'COLUMN',@level2name=N'isbright'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否已删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_comment', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言作者用户名,匿名为空' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_comment', @level2type=N'COLUMN',@level2name=N'postername'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_comment', @level2type=N'COLUMN',@level2name=N'message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_comment', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_group', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'集团名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_group', @level2type=N'COLUMN',@level2name=N'groupName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否国外集团' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_group', @level2type=N'COLUMN',@level2name=N'isabroad'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_otherSiteCatalog', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'品牌id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_otherSiteCatalog', @level2type=N'COLUMN',@level2name=N'brandId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车系id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_otherSiteCatalog', @level2type=N'COLUMN',@level2name=N'serialId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车型id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_otherSiteCatalog', @level2type=N'COLUMN',@level2name=N'modelId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'网站类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_otherSiteCatalog', @level2type=N'COLUMN',@level2name=N'website'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否国产' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_otherSiteCatalog', @level2type=N'COLUMN',@level2name=N'isChina'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'car_otherSiteCatalog', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作类型
1：关注；2：已关注再扫描；3：取消关注
4：输入文本
5：click事件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'che315wx_actionrecord', @level2type=N'COLUMN',@level2name=N'actiontype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'tdcodeid关联che315wx_tdcode的主键
但也可能为空
：扫描的二维码在che315wx_tdcode表中没有记录
：与二维码无关的action' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'che315wx_actionrecord', @level2type=N'COLUMN',@level2name=N'tdcodeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否已回复
0：未回复（回复默认文本也记录为未回复）
1：已回复' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'che315wx_actionrecord', @level2type=N'COLUMN',@level2name=N'isreplied'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保留字段，可以扩展为 管理不同公众号的场景二维码
暂时只记录wx315che的二维码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'che315wx_tdcode', @level2type=N'COLUMN',@level2name=N'pubwxaid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'场景-id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'che315wx_tdcode', @level2type=N'COLUMN',@level2name=N'sceneid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'场景名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'che315wx_tdcode', @level2type=N'COLUMN',@level2name=N'scenename'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'场景描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'che315wx_tdcode', @level2type=N'COLUMN',@level2name=N'scenedescription'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'微信返回的tiket，ticket直接作为参数请求二维码图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'che315wx_tdcode', @level2type=N'COLUMN',@level2name=N'ticket'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片地址，两张形式
第一种，由固定url加ticket组合（故此字段可能是多余的）
第二种，上面的图片保存至315che,再用img.315che...的路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'che315wx_tdcode', @level2type=N'COLUMN',@level2name=N'imgurl'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否停止统计' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'che315wx_tdcode', @level2type=N'COLUMN',@level2name=N'isstopped'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 默认为0，不为空' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_byyuyue', @level2type=N'COLUMN',@level2name=N'issenior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业信息自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'infoid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'eid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识，0--正常，1--已删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业介绍' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'intro'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮编' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'zipcode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'传真' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'faq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'网址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'webaddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'销售电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'salephone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交通描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'traffic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'领导致辞' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'speech'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'资质荣誉' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'honor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地图信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealerinfo', @level2type=N'COLUMN',@level2name=N'mapinfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'eid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业级别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'paylevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所在地区' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'areaid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'使用模板id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'modelid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业简称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'shortename'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主营品牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'mainbrand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'ename'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'个性域名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'domain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'首页热点新闻设置，0--自动选取最新新闻，1--手动选取' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'indexhotnewssetting'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 默认为0，不为空' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_dealers', @level2type=N'COLUMN',@level2name=N'issenior'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业员工自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_employee', @level2type=N'COLUMN',@level2name=N'empid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属企业id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_employee', @level2type=N'COLUMN',@level2name=N'eid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_employee', @level2type=N'COLUMN',@level2name=N'sortid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_employee', @level2type=N'COLUMN',@level2name=N'empname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'座机号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_employee', @level2type=N'COLUMN',@level2name=N'plane'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_employee', @level2type=N'COLUMN',@level2name=N'phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'职务' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_employee', @level2type=N'COLUMN',@level2name=N'duty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'头像图片路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_employee', @level2type=N'COLUMN',@level2name=N'avatar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_employee', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_employee', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'形象图自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_focusimg', @level2type=N'COLUMN',@level2name=N'imgid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_focusimg', @level2type=N'COLUMN',@level2name=N'eid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'位置id，1,2,3,4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_focusimg', @level2type=N'COLUMN',@level2name=N'placeid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_focusimg', @level2type=N'COLUMN',@level2name=N'path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_focusimg', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片链接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_focusimg', @level2type=N'COLUMN',@level2name=N'link'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识，0--正常，1--已删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_focusimg', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_focusimg', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_focusimg', @level2type=N'COLUMN',@level2name=N'updatetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'栏目模板对应关系自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_menurelated', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'栏目id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_menurelated', @level2type=N'COLUMN',@level2name=N'menuid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_menurelated', @level2type=N'COLUMN',@level2name=N'modelid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业栏目设置自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_menusetting', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_menusetting', @level2type=N'COLUMN',@level2name=N'eid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'栏目id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_menusetting', @level2type=N'COLUMN',@level2name=N'menuid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_menusetting', @level2type=N'COLUMN',@level2name=N'sortid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'显示名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_menusetting', @level2type=N'COLUMN',@level2name=N'showname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'newsid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'eid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻分类id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'typeid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'浏览量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'views'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'热点新闻排序id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'hotsortid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发布日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'publishdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推荐日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'hotdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识，0--正常，1--已删除，2--未发布' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否推荐' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'ishot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_news', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'orderid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'eid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车型id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'carid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'预订日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'orderdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户手机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'customername'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户联系邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'补充说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'supplement'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单状态,0--未处理，1--已处理，2--待试驾，3--已试驾，4--已过期，5--无效订单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单类型，0--非法类型，1--在线订单，2--预约试驾' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'ordertype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_ordercar', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'栏目自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_pagemenu', @level2type=N'COLUMN',@level2name=N'pid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'栏目默认名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_pagemenu', @level2type=N'COLUMN',@level2name=N'partname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上级栏目id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_pagemenu', @level2type=N'COLUMN',@level2name=N'fatherid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_pagemenu', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_pagemenu', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_pagemodel', @level2type=N'COLUMN',@level2name=N'mid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_pagemodel', @level2type=N'COLUMN',@level2name=N'modeltitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板预览图路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_pagemodel', @level2type=N'COLUMN',@level2name=N'pic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_pagemodel', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_pagemodel', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1-订单 2-试驾 3-保养' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_phonedealrecord', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1-订单 2-试驾 3-保养' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_phoneshare', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'问题自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_qaonline', @level2type=N'COLUMN',@level2name=N'qaid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_qaonline', @level2type=N'COLUMN',@level2name=N'eid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车型id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_qaonline', @level2type=N'COLUMN',@level2name=N'carid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提问日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_qaonline', @level2type=N'COLUMN',@level2name=N'quesdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'答复日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_qaonline', @level2type=N'COLUMN',@level2name=N'answerdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'提问人用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_qaonline', @level2type=N'COLUMN',@level2name=N'askername'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'问题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_qaonline', @level2type=N'COLUMN',@level2name=N'question'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'答复' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_qaonline', @level2type=N'COLUMN',@level2name=N'answer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'问题状态，0--未答，1--已答 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_qaonline', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_qaonline', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'店面展示图片自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_storedisplay', @level2type=N'COLUMN',@level2name=N'picid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_storedisplay', @level2type=N'COLUMN',@level2name=N'sortid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_storedisplay', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_storedisplay', @level2type=N'COLUMN',@level2name=N'path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_storedisplay', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'eid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'首页头图1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'indexpic1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'首页头图2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'indexpic2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'首页头图3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'indexpic3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'首页头图4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'indexpic4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车型报价栏目主题图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'pricepic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业信息栏目主题图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'entinfopic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻动态栏目主题图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'newspic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系我们栏目主题图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'contactpic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车型图片栏目主题图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'carpic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'客户服务栏目主题图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_topicimg', @level2type=N'COLUMN',@level2name=N'servicepic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业用户自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_users', @level2type=N'COLUMN',@level2name=N'uid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_users', @level2type=N'COLUMN',@level2name=N'username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_users', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_users', @level2type=N'COLUMN',@level2name=N'joindate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识，0--正常，1--已删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_users', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后一次登录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_users', @level2type=N'COLUMN',@level2name=N'lastlogindate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后一次登录ip' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_users', @level2type=N'COLUMN',@level2name=N'lastloginip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-正在验证，1-成功，2-失败' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_wxaccount', @level2type=N'COLUMN',@level2name=N'wx_ok'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'微信cookie里面的一个值，目前不知道有什么用途' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_wxaccount', @level2type=N'COLUMN',@level2name=N'bizuin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'微信cookie里面的账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_wxaccount', @level2type=N'COLUMN',@level2name=N'slave_user'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'微信cookie里面的加密串，和slave_user组成关键内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_wxaccount', @level2type=N'COLUMN',@level2name=N'slave_sid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'微信后台url里面的关键串，没有的话直接退出登录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_wxaccount', @level2type=N'COLUMN',@level2name=N'wtoken'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上一次api检查时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_wxaccount', @level2type=N'COLUMN',@level2name=N'checktime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上一次更新cookie的时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_wxaccount', @level2type=N'COLUMN',@level2name=N'cookiecheckdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-默认，1-一等，2-二等，3-三等，4-快乐奖' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dea_wxzplist', @level2type=N'COLUMN',@level2name=N'isok'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'抢兑期号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'duihuaList', @level2type=N'COLUMN',@level2name=N'RobConfirmedNumb'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易运费（快递费用）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'duihuaList', @level2type=N'COLUMN',@level2name=N'dealExpenses'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'抽奖概率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'duihuaList', @level2type=N'COLUMN',@level2name=N'probability'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'换购点' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'duihuaList', @level2type=N'COLUMN',@level2name=N'huagoudian'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大发帖数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'duihuaList', @level2type=N'COLUMN',@level2name=N'maxtopic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大兑换次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'duihuaList', @level2type=N'COLUMN',@level2name=N'maxnumb'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司规模' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_scale'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'法人代表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_Lperson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'员工人数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_staff'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'年营业额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_Ymoney'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮编' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_Anums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'传真' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_Mobilephone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_contactName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'简介' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_introduce'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业或法人图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_photo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'成立时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_founddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系email' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_mail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司主页' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'E_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业会员ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'区域ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_4s', @level2type=N'COLUMN',@level2name=N'areaid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'企业ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'E_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品型号ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'typeid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0，null-整件，1—配件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品报价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'优惠价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'offersprice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'photo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发布日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'updatedate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'数量+单位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'perunit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'remarks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品介绍' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'introduce'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'产品说明书' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'directions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'配置规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_product', @level2type=N'COLUMN',@level2name=N'standards'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'UserName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'UserPassword'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-先生，1-女士' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'Usersex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'RealName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码问题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'UserQuestion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码答案' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'UserAnswer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'UserEmail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部门与职务' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'f_position'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'RegDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'区域' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'f_areaid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'f_address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮编' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'f_number'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'f_phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'f_mobilephone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'传真' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'f_fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'qq/MSN' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ent_user', @level2type=N'COLUMN',@level2name=N'f_qq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_content', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片主题id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_content', @level2type=N'COLUMN',@level2name=N'titleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_content', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关键字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_content', @level2type=N'COLUMN',@level2name=N'keywords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保存路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_content', @level2type=N'COLUMN',@level2name=N'path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_content', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_content', @level2type=N'COLUMN',@level2name=N'lastUpdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_content', @level2type=N'COLUMN',@level2name=N'sortId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0正常,1删除,2待发布' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_content', @level2type=N'COLUMN',@level2name=N'isDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newContent', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片主题id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newContent', @level2type=N'COLUMN',@level2name=N'titleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newContent', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关键字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newContent', @level2type=N'COLUMN',@level2name=N'keywords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保存路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newContent', @level2type=N'COLUMN',@level2name=N'path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newContent', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newContent', @level2type=N'COLUMN',@level2name=N'lastUpdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newContent', @level2type=N'COLUMN',@level2name=N'sortId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0正常,1删除,2待发布' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newContent', @level2type=N'COLUMN',@level2name=N'isDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目录id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'catalogId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'被顶次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'toTop'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'被踩次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'toSink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后被顶时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'topTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后被踩时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'sinkTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认的图片内容id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'contentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'腾讯车型目录id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'qqCatalogId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车型类别（0表示非车型）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0正常,1删除,2待发布' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'isDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关键字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'keywords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'addAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'updateAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'delAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_newTitle', @level2type=N'COLUMN',@level2name=N'lastUpdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目录id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'catalogId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'腾讯车型目录id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'qqCatalogId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车型类别（0表示非车型）' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关键字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'keywords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'addAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'updateAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'delAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'lastUpdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0正常,1删除,2待发布' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'img_title', @level2type=N'COLUMN',@level2name=N'isDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_relatedsearch', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'处理状态，null--未处理，0--废弃，1--通过' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_relatedsearch', @level2type=N'COLUMN',@level2name=N'dealstate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否已搜索过，0--否，1--是' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_relatedsearch', @level2type=N'COLUMN',@level2name=N'issearched'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否已搜索过内容，0--否，1--是' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_relatedsearch', @level2type=N'COLUMN',@level2name=N'hascontent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关键词' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_relatedsearch', @level2type=N'COLUMN',@level2name=N'keywords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相关搜索关键词id列表，1，2，3，' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_relatedsearch', @level2type=N'COLUMN',@level2name=N'childids'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父级路径，.1.2.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_relatedsearch', @level2type=N'COLUMN',@level2name=N'path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_relatedsearch', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容更新日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_relatedsearch', @level2type=N'COLUMN',@level2name=N'updatetime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_searchcontent', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_searchcontent', @level2type=N'COLUMN',@level2name=N'newsid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关键词' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_searchcontent', @level2type=N'COLUMN',@level2name=N'keywords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_searchcontent', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容链接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_searchcontent', @level2type=N'COLUMN',@level2name=N'link'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'key_searchcontent', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'子增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_content', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_content', @level2type=N'COLUMN',@level2name=N'uid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回复原帖id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_content', @level2type=N'COLUMN',@level2name=N'replyid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转发信息的根id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_content', @level2type=N'COLUMN',@level2name=N'forwardroot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转发自id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_content', @level2type=N'COLUMN',@level2name=N'forwardform'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_followinfo', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关注用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_followinfo', @level2type=N'COLUMN',@level2name=N'uid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'被关注用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_followinfo', @level2type=N'COLUMN',@level2name=N'fansuid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关注时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_followinfo', @level2type=N'COLUMN',@level2name=N'followtime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_mentions', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_mentions', @level2type=N'COLUMN',@level2name=N'mentioneduid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_mentions', @level2type=N'COLUMN',@level2name=N'contentid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_users', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_users', @level2type=N'COLUMN',@level2name=N'usertype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外链id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_users', @level2type=N'COLUMN',@level2name=N'keyid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_users', @level2type=N'COLUMN',@level2name=N'nickname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'头像' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'mbg_users', @level2type=N'COLUMN',@level2name=N'avatar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_1', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外联关键值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_1', @level2type=N'COLUMN',@level2name=N'keyid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者id,0表示匿名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_1', @level2type=N'COLUMN',@level2name=N'posterid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言状态，0--正常，1--已删除，2--精华帖' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_1', @level2type=N'COLUMN',@level2name=N'msgstate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 楼层' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_1', @level2type=N'COLUMN',@level2name=N'sortid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展外联关键值，有多个关键值时作为keyid的扩展字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_1', @level2type=N'COLUMN',@level2name=N'expandkey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者昵称，匿名留言时记录匿名名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_1', @level2type=N'COLUMN',@level2name=N'nickname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_1', @level2type=N'COLUMN',@level2name=N'message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_1', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_2', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外联关键值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_2', @level2type=N'COLUMN',@level2name=N'keyid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者id,0表示匿名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_2', @level2type=N'COLUMN',@level2name=N'posterid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言状态，0--正常，1--已删除，2--精华帖' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_2', @level2type=N'COLUMN',@level2name=N'msgstate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 楼层' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_2', @level2type=N'COLUMN',@level2name=N'sortid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展外联关键值，有多个关键值时作为keyid的扩展字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_2', @level2type=N'COLUMN',@level2name=N'expandkey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者昵称，匿名留言时记录匿名名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_2', @level2type=N'COLUMN',@level2name=N'nickname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_2', @level2type=N'COLUMN',@level2name=N'message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_2', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_3', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外联关键值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_3', @level2type=N'COLUMN',@level2name=N'keyid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者id,0表示匿名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_3', @level2type=N'COLUMN',@level2name=N'posterid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言状态，0--正常，1--已删除，2--精华帖' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_3', @level2type=N'COLUMN',@level2name=N'msgstate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 楼层' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_3', @level2type=N'COLUMN',@level2name=N'sortid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展外联关键值，有多个关键值时作为keyid的扩展字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_3', @level2type=N'COLUMN',@level2name=N'expandkey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者昵称，匿名留言时记录匿名名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_3', @level2type=N'COLUMN',@level2name=N'nickname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_3', @level2type=N'COLUMN',@level2name=N'message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_3', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_4', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外联关键值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_4', @level2type=N'COLUMN',@level2name=N'keyid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者id,0表示匿名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_4', @level2type=N'COLUMN',@level2name=N'posterid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言状态，0--正常，1--已删除，2--精华帖' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_4', @level2type=N'COLUMN',@level2name=N'msgstate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N' 楼层' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_4', @level2type=N'COLUMN',@level2name=N'sortid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展外联关键值，有多个关键值时作为keyid的扩展字段' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_4', @level2type=N'COLUMN',@level2name=N'expandkey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者昵称，匿名留言时记录匿名名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_4', @level2type=N'COLUMN',@level2name=N'nickname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_4', @level2type=N'COLUMN',@level2name=N'message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'msg_4', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻(new_news)的自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'newsId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地域分类id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'areaId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车型分类id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'carcatalogId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'newsTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关键字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'newsKeywords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'newsContent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'lastUpdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'sortId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0正常,1删除,2待发布' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_content', @level2type=N'COLUMN',@level2name=N'isDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻分类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'newsCatalogId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地域分类id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'areaId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车型分类id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'carcatalogId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'newsTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关键字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'newsKeywords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'titlePhoto'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'作者和出处信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'newsEditor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'addAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'updateAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'delAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'被顶的次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'toTop'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'被踩的次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'toSink'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展列1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'gradeId1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展列2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'gradeId2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展列3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'gradeId3'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展列4' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'gradeId4'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展列5' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'gradeId5'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最后更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'lastUpdate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0正常,1删除,2待发布' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_news', @level2type=N'COLUMN',@level2name=N'isDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_publishTime', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发布时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_publishTime', @level2type=N'COLUMN',@level2name=N'publishTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_recommended', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推荐到目录id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_recommended', @level2type=N'COLUMN',@level2name=N'catalogId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'被推荐新闻id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_recommended', @level2type=N'COLUMN',@level2name=N'newsId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_recommended', @level2type=N'COLUMN',@level2name=N'newsTitle'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推荐操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_recommended', @level2type=N'COLUMN',@level2name=N'addAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_recommended', @level2type=N'COLUMN',@level2name=N'updateAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除操作管理员用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_recommended', @level2type=N'COLUMN',@level2name=N'delAdmin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推荐时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_recommended', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0正常,1删除,2待发布' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_recommended', @level2type=N'COLUMN',@level2name=N'isDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新闻内容id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_related', @level2type=N'COLUMN',@level2name=N'contentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关联链接地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_related', @level2type=N'COLUMN',@level2name=N'url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'关联新闻标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'new_related', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'pk专题自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pkzt_info', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车系id1' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pkzt_info', @level2type=N'COLUMN',@level2name=N'carid1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车系id2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pkzt_info', @level2type=N'COLUMN',@level2name=N'carid2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-ip,1-useragent' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pub_blockipug', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自动增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pub_editorTemplate', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'删除标识' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pub_editorTemplate', @level2type=N'COLUMN',@level2name=N'isDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pub_editorTemplate', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'html代码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pub_editorTemplate', @level2type=N'COLUMN',@level2name=N'html'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0-看出团，1-微车商' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pub_smsdata', @level2type=N'COLUMN',@level2name=N'itype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'动态表格自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pub_tablecatalog', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主题名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pub_tablecatalog', @level2type=N'COLUMN',@level2name=N'subjectname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'选项名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pub_tablecatalog', @level2type=N'COLUMN',@level2name=N'optionname'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'统计选项标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pub_tablecatalog', @level2type=N'COLUMN',@level2name=N'isforcount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'carid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否已删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'加速性能0-100Km/h' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'XNjiasu100'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'加速性能0-400m' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'XNjiasu400'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'制动性能100Km/h-0' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'XNzhidong100'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操控性能18M绕桩速度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'XNcaokong18'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'舒适性能60Km/h声噪' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'XNshushi60'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'舒适性能80Km/h声噪' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'XNshushi80'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'燃油经济性测试综合油耗' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'XNranyouzonghe'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'燃油经济性官方理论油耗' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'XNranyouguanfang'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'乘坐空间数据前排头部空间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'KJftoubu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'乘坐空间数据前排座椅宽度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'KJfzuoyi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'乘坐空间数据后排头部空间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'KJbtoubu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'乘坐空间数据后排座椅宽度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'KJbzuoyi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'乘坐空间数据后排腿部空间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'KJbtuibu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'储物空间数据前排杯架数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'KJfbeijia'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'储物空间数据前排储物格数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'KJfchuwuge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'后排储物格数量后排储物格数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'KJbchuwuge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'储物空间数据后排座椅放倒方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'KJbzuoyifangdao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'储物空间数据后备箱容积' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'KJhoubeixian'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安全配置及碰撞成绩安全带提醒' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'AQanquandai'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安全配置及碰撞成绩安全气囊' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'AQanquanqinao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安全配置及碰撞成绩主动安全装置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'AQanquanzhuangzhi'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安全配置及碰撞成绩C-NCAP碰撞成绩' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'AQcncap'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安全配置及碰撞成绩E-NCAP碰撞成绩' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_carinfo', @level2type=N'COLUMN',@level2name=N'AQencap'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_comment', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_comment', @level2type=N'COLUMN',@level2name=N'carid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评论类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_comment', @level2type=N'COLUMN',@level2name=N'msgtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否精彩评论' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_comment', @level2type=N'COLUMN',@level2name=N'isBright'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否已删除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_comment', @level2type=N'COLUMN',@level2name=N'isdelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评论内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_comment', @level2type=N'COLUMN',@level2name=N'message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评论作者用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_comment', @level2type=N'COLUMN',@level2name=N'username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pzt_comment', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增长id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sho_userinfo', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sho_userinfo', @level2type=N'COLUMN',@level2name=N'username'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'意向车型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sho_userinfo', @level2type=N'COLUMN',@level2name=N'carmodel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sho_userinfo', @level2type=N'COLUMN',@level2name=N'phone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'身份证' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sho_userinfo', @level2type=N'COLUMN',@level2name=N'cardnum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sho_userinfo', @level2type=N'COLUMN',@level2name=N'ticketnum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sho_userinfo', @level2type=N'COLUMN',@level2name=N'adddate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'微车商点击次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_dealerWXTJ', @level2type=N'COLUMN',@level2name=N'ClickNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发布量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_dealerWXTJ', @level2type=N'COLUMN',@level2name=N'ReleaseNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'阅读次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_dealerWXTJ', @level2type=N'COLUMN',@level2name=N'ReadNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'转载' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_dealerWXTJ', @level2type=N'COLUMN',@level2name=N'ReprintNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'询价人次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_dealerWXTJ', @level2type=N'COLUMN',@level2name=N'AskNum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保养预约人次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_dealerWXTJ', @level2type=N'COLUMN',@level2name=N'PreMain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'预约试驾人次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'T_dealerWXTJ', @level2type=N'COLUMN',@level2name=N'PreDrive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1-新闻,2-图库,3-车型,4-产品,5-企业,6-专题,7-搭车,8-看车团,9-新闻类目,10-配件,11-车型点评,12-人才招聘,13-人才简历,14-租车，15-二手' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TClick', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'精彩评论id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_brightMessageToTop', @level2type=N'COLUMN',@level2name=N'mid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支持时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_brightMessageToTop', @level2type=N'COLUMN',@level2name=N'topTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支持者IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_brightMessageToTop', @level2type=N'COLUMN',@level2name=N'topIp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_brightUserInfo', @level2type=N'COLUMN',@level2name=N'userName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_brightUserInfo', @level2type=N'COLUMN',@level2name=N'voteInfo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_brightUserInfo', @level2type=N'COLUMN',@level2name=N'addDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否领奖页面提交' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_brightUserInfo', @level2type=N'COLUMN',@level2name=N'isPrize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'酷炫车型秀专题非用户临时评论id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_pkShowComment', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'左侧内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_pkShowComment', @level2type=N'COLUMN',@level2name=N'leftComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'右侧内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_pkShowComment', @level2type=N'COLUMN',@level2name=N'rightComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'车系id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_relatedSerial', @level2type=N'COLUMN',@level2name=N'serialId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'专题id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'zht_relatedSerial', @level2type=N'COLUMN',@level2name=N'contentId'
GO
