USE [master]
GO
/****** Object:  Database [Devices]    Script Date: 05-Nov-17 9:28:00 PM ******/
CREATE DATABASE [Devices]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Devices', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS01\MSSQL\DATA\Devices.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Devices_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS01\MSSQL\DATA\Devices_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Devices] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Devices].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Devices] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Devices] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Devices] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Devices] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Devices] SET ARITHABORT OFF 
GO
ALTER DATABASE [Devices] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Devices] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Devices] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Devices] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Devices] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Devices] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Devices] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Devices] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Devices] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Devices] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Devices] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Devices] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Devices] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Devices] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Devices] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Devices] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Devices] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Devices] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Devices] SET  MULTI_USER 
GO
ALTER DATABASE [Devices] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Devices] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Devices] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Devices] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Devices] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Devices] SET QUERY_STORE = OFF
GO
USE [Devices]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Devices]
GO
/****** Object:  Table [dbo].[Devices]    Script Date: 05-Nov-17 9:28:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Devices](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[manufacturer] [varchar](30) NULL,
	[type] [varchar](6) NOT NULL,
	[os] [varchar](50) NULL,
	[os_version] [float] NULL,
	[cpu] [varchar](50) NULL,
	[ram] [varchar](10) NULL,
 CONSTRAINT [PK_Devices_1] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ownership]    Script Date: 05-Nov-17 9:28:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ownership](
	[id_device] [int] NOT NULL,
	[id_owner] [int] NOT NULL,
	[current_user] [int] NULL,
 CONSTRAINT [PK_Ownership] PRIMARY KEY CLUSTERED 
(
	[id_device] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 05-Nov-17 9:28:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](30) NOT NULL,
	[role] [varchar](30) NULL,
	[location] [varchar](30) NULL,
	[username] [varchar](30) NOT NULL,
	[password] [varchar](64) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Devices] ON 

INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (2, N'Ipad Pro', N'Apple', N'Tablet', N'IOS', 10, N'Hexa-Core A10X Fusion 2.3 GHz', N'4 GB      ')
INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (3, N'Iphone 8', N'Apple', N'Phone', N'IOS', 11, N'Hexa-Core A11 Bionic', N'2 GB')
INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (4, N'Nokia 8', N'Nokia', N'Phone', N'Android', 7, N'Qualcomm Snapdragon Octa-Core 2,5 GHz', N'4 GB')
INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (5, N'Galaxy S8+', N'Samsung', N'Phone', N'Android Oreo', 8, N'Exynos Octa-Core 2.3GHz', N'8 GB')
INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (6, N'Galaxy S7', N'Samsung', N'Phone', N'Android Nougat', 7, N'Cortex-A53 Octa-Core', N'8 GB')
INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (7, N'Asus ZenPad 10', N'Asus', N'Tablet', N'Android Marshmallow', 6, N'MT8163 Quad-core 1.3 GHz', N'2 GB')
INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (8, N'Microsoft Surface Pro 4', N'Microsoft', N'Tablet', N'Windows', 10, N'Intel® CoreTM i7 Dual-Core 2.2 Ghz', N'8 GB')
INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (9, N' Lenovo Tab 3', N'Lenovo', N'Tablet', N'Android Lollipop', 5, N'MTK MT 8127 Quad-Core 1.3 GHz', N'1 GB')
INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (10, N'iPad Air 2', N'Apple', N'Tablet', N'IOS', 8, N'A8X', N'2 GB')
INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (11, N'Allview AX501Q', N'Allview', N'Tablet', N'Android Lollipop', 5.1, N'Cortex A7 Quad-Core 1 GHz', N'1 GB')
INSERT [dbo].[Devices] ([id], [name], [manufacturer], [type], [os], [os_version], [cpu], [ram]) VALUES (12, N'iPad mini 4', N'Apple', N'Tablet', N'IOS', 9, N'A8', N'2 GB')
SET IDENTITY_INSERT [dbo].[Devices] OFF
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (2, 1, 3)
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (3, 1, 7)
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (4, 1, 1)
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (5, 1, 3)
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (6, 1, 3)
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (7, 1, 3)
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (8, 1, NULL)
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (9, 1, NULL)
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (10, 1, 1)
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (11, 1, NULL)
INSERT [dbo].[Ownership] ([id_device], [id_owner], [current_user]) VALUES (12, 1, NULL)
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([id], [name], [role], [location], [username], [password]) VALUES (1, N'Florin Andrei', N'Junior Developer', N'Cluj-Napoca', N'florinandrei', N'fd52d8e9b4ba95b56be308d25123763c2d24ca608abcb5f8b3cce0e07aaee056')
INSERT [dbo].[Users] ([id], [name], [role], [location], [username], [password]) VALUES (2, N'Bob', N'QA Tester', N'Bucuresti', N'bob99', N'2a644511cb34d66fa66cc5d2bbffb9668e3699d838c9698e5695fd9f70bca0cd')
INSERT [dbo].[Users] ([id], [name], [role], [location], [username], [password]) VALUES (3, N'Rick', N'Project Manager', N'Cluj-Napoca', N'rick', N'8ed523916f987e2d35c45f077750fc0aeb9dd20acc140d3ec1ac9ebb7fef9880')
INSERT [dbo].[Users] ([id], [name], [role], [location], [username], [password]) VALUES (4, N'Alina Muntean', N'HR', N'Brasov', N'alinamuntean', N'8fd7899cb8d1826c81fa4a61e111b35477b89a6588e7c784b106acf98f63acab')
INSERT [dbo].[Users] ([id], [name], [role], [location], [username], [password]) VALUES (5, N'JohnDoe', N'Senior Developer', N'Cluj-Napoca', N'johndoe', N'5F50B31F32460692D090B59BFD26579A5AF6F94FF8407DA7ECFF7774720AA01F')
INSERT [dbo].[Users] ([id], [name], [role], [location], [username], [password]) VALUES (7, N'Maria Stanculescu', N'Graphic Designer', N'Sibiu', N'mariastanculescu', N'20C61903CF7CB961D8983129F11314EFB4442503697E51611EB35176B55B1976')
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Ownership]  WITH CHECK ADD  CONSTRAINT [FK_Ownership_Devices] FOREIGN KEY([id_device])
REFERENCES [dbo].[Devices] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Ownership] CHECK CONSTRAINT [FK_Ownership_Devices]
GO
ALTER TABLE [dbo].[Ownership]  WITH CHECK ADD  CONSTRAINT [FK_Ownership_Users] FOREIGN KEY([id_owner])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Ownership] CHECK CONSTRAINT [FK_Ownership_Users]
GO
ALTER TABLE [dbo].[Ownership]  WITH CHECK ADD  CONSTRAINT [FK_Ownership_Users1] FOREIGN KEY([current_user])
REFERENCES [dbo].[Users] ([id])
GO
ALTER TABLE [dbo].[Ownership] CHECK CONSTRAINT [FK_Ownership_Users1]
GO
ALTER TABLE [dbo].[Devices]  WITH CHECK ADD  CONSTRAINT [ck_device_type] CHECK  (([type]='Tablet' OR [type]='Phone'))
GO
ALTER TABLE [dbo].[Devices] CHECK CONSTRAINT [ck_device_type]
GO
USE [master]
GO
ALTER DATABASE [Devices] SET  READ_WRITE 
GO
