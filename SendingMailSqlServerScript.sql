USE [Rahul]
GO
/****** Object:  Table [dbo].[Tbl_LoginUser]    Script Date: 3/8/2019 4:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_LoginUser](
	[Id] [int] NOT NULL,
	[UserName] [varchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[is_Active] [bit] NULL,
	[CreatedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Tbl_LoginUser] ([Id], [UserName], [Email], [is_Active], [CreatedDate]) VALUES (1, N'User1', N'******@gmail.com', 1, CAST(N'2019-02-08' AS Date))
INSERT [dbo].[Tbl_LoginUser] ([Id], [UserName], [Email], [is_Active], [CreatedDate]) VALUES (2, N'User2', N'******@gmail.com', 1, CAST(N'2019-02-08' AS Date))
INSERT [dbo].[Tbl_LoginUser] ([Id], [UserName], [Email], [is_Active], [CreatedDate]) VALUES (3, N'User3', N'******@gmail.com', 1, CAST(N'2019-02-08' AS Date))
INSERT [dbo].[Tbl_LoginUser] ([Id], [UserName], [Email], [is_Active], [CreatedDate]) VALUES (4, N'User4', N'******@gmail.com', 1, CAST(N'2018-09-09' AS Date))
/****** Object:  StoredProcedure [dbo].[Proc_SendEmailLoginUser]    Script Date: 3/8/2019 4:56:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_SendEmailLoginUser]
AS
BEGIN
	CREATE TABLE #temp1 (
		id INT identity(1, 1)
		,email NVARCHAR(max)
		)

	DECLARE @count INT
	DECLARE @currentdate date = GetDate();
	DECLARE @ToMail NVARCHAR(max)
	DECLARE @Body1 VARCHAR(MAX) = '<div>Hi,</div><div><span style="color: inherit;">Thank you for registering with Testting Application. Click on the below
mentioned link to get started with us.</span></div><div><span style="color: inherit;"><br></span></div>

<div>Rahul Dubey</div><div><br></div>

<div>You will be redirected to the login page which gives you
access to your account to create Many kinds application,and a
lot more.&nbsp;</div><div>We will be here to help you with every step along the way. </div><div><br></div>

<div>Always With You</div>

<div>The Rahul Dubey Team<b><o:p></o:p></b></div>';

	INSERT INTO #temp1
	SELECT DISTINCT Email
	FROM dbo.Tbl_LoginUser WITH(NOLOCK)
	where DATEADD(day,180,cast(CreatedDate as date)) = cast(@currentdate as date)

	SELECT @Count = COUNT(id)
	FROM #temp1

	WHILE (@Count > 0)
	BEGIN
		WAITFOR DELAY '000:00:01'

		SELECT @ToMail = email
		FROM #temp1
		WHERE id = @count


		set @ToMail = ''+@ToMail+'';
		EXEC msdb.dbo.sp_send_dbmail 
			 @profile_name = 'OutlookJJ'
			,@Recipients = @ToMail
			,@Body = @Body1
			,@body_format = 'HTML'
			,@Subject = 'Rahul dubey application Welcome Email'

		SET @Count = @Count - 1
	END
END

GO
