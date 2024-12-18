USE [master]
GO

/****** Object:  Database [QLKhachSanTTTN]    Script Date: 21/10/2024 9:14:31 PM ******/
CREATE DATABASE [QLKhachSanTTTN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLKhachSanTTTN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QLKhachSanTTTN.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QLKhachSanTTTN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\QLKhachSanTTTN_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [QLKhachSanTTTN] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLKhachSanTTTN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLKhachSanTTTN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QLKhachSanTTTN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLKhachSanTTTN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLKhachSanTTTN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLKhachSanTTTN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLKhachSanTTTN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLKhachSanTTTN] SET  MULTI_USER 
GO
ALTER DATABASE [QLKhachSanTTTN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLKhachSanTTTN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLKhachSanTTTN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLKhachSanTTTN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLKhachSanTTTN] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLKhachSanTTTN] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QLKhachSanTTTN] SET QUERY_STORE = OFF
GO
USE [QLKhachSanTTTN]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDAdmin] [int] NULL,
	[Anh] [nvarchar](50) NULL,
	[TieuDe] [nvarchar](max) NULL,
	[ThongTin] [text] NULL,
	[NgayDang] [date] NULL,
 CONSTRAINT [PK_Blog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CTAnh]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTAnh](
	[TenAnh] [nvarchar](50) NOT NULL,
	[MaPhong] [int] NULL,
 CONSTRAINT [PK_CTAnh] PRIMARY KEY CLUSTERED 
(
	[TenAnh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatPhong]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatPhong](
	[MaPhong] [int] NOT NULL,
	[SoHoaDon] [int] NOT NULL,
	[NgayDen] [datetime] NULL,
	[NgayDi] [datetime] NULL,
	[NgayHuy] [datetime] NULL,
	[SoNguoi] [int] NULL,
	[IsDelete] [int] NULL,
 CONSTRAINT [PK_DatPhong] PRIMARY KEY CLUSTERED 
(
	[MaPhong] ASC,
	[SoHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GopY]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GopY](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NULL,
	[MaKS] [int] NULL,
	[NgayComment] [datetime] NULL,
	[Comment] [nvarchar](max) NULL,
	[DiemNhanVien] [float] NULL,
	[DiemDoAn] [float] NULL,
	[DiemSachSe] [float] NULL,
	[DiemThoaiMai] [float] NULL,
	[DiemDichVu] [float] NULL,
 CONSTRAINT [PK_GopY] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[SoHoaDon] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NULL,
	[NgayThanhToan] [datetime] NULL,
	[NgayTao] [datetime] NULL,
	[TenKH] [nvarchar](50) NULL,
	[Email] [nvarchar](200) NULL,
	[SDT] [nvarchar](50) NULL,
	[TinhTrang] [nvarchar](50) NULL,
	[ThanhTien] [money] NULL,
 CONSTRAINT [PK_HoaDon] PRIMARY KEY CLUSTERED 
(
	[SoHoaDon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachHang]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachHang](
	[MaKH] [int] IDENTITY(1,1) NOT NULL,
	[TenKH] [nvarchar](50) NULL,
	[GioiTinh] [int] NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[NgaySinh] [date] NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SDT] [nvarchar](50) NULL,
	[UserId] [int] NULL,
	[HieuLuc] [int] NULL,
 CONSTRAINT [PK_KhachHang] PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhachSan]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhachSan](
	[MaKS] [int] IDENTITY(1,1) NOT NULL,
	[MaTinh] [int] NULL,
	[IDNguoiTao] [int] NULL,
	[TenKhachSan] [nvarchar](200) NULL,
	[DiaChi] [nvarchar](max) NULL,
	[MoTa] [nvarchar](max) NULL,
	[Anh] [nvarchar](50) NULL,
	[DanhGia] [int] NULL,
	[Duyet] [int] NULL,
 CONSTRAINT [PK_KhachSan] PRIMARY KEY CLUSTERED 
(
	[MaKS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiPhong]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiPhong](
	[MaLP] [int] IDENTITY(1,1) NOT NULL,
	[MaKS] [int] NULL,
	[TenLP] [nvarchar](50) NULL,
	[SoNguoiToiDa] [int] NULL,
	[Gia] [float] NULL,
	[Anh] [nvarchar](50) NULL,
	[ThongTin] [nvarchar](max) NULL,
	[KichThuoc] [nvarchar](20) NULL,
 CONSTRAINT [PK_LoaiPhong] PRIMARY KEY CLUSTERED 
(
	[MaLP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phong]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phong](
	[MaPhong] [int] IDENTITY(1,1) NOT NULL,
	[TenPhong] [nvarchar](50) NULL,
	[MaLP] [int] NULL,
	[Anh] [nvarchar](50) NULL,
	[MoTa] [nvarchar](max) NULL,
 CONSTRAINT [PK_Phong] PRIMARY KEY CLUSTERED 
(
	[MaPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuenMatKhau]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuenMatKhau](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Token] [nvarchar](max) NULL,
	[Email] [nvarchar](50) NULL,
	[NgayTao] [datetime] NULL,
 CONSTRAINT [PK_QuenMatKhau] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SuDungThietBi]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SuDungThietBi](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MaTB] [int] NOT NULL,
	[MaLP] [int] NOT NULL,
 CONSTRAINT [PK_SuDungThietBi] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThietBi]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThietBi](
	[MaTB] [int] IDENTITY(1,1) NOT NULL,
	[TenTB] [nvarchar](200) NULL,
 CONSTRAINT [PK_ThietBi] PRIMARY KEY CLUSTERED 
(
	[MaTB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TinhThanh]    Script Date: 21/10/2024 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TinhThanh](
	[MaTinh] [int] IDENTITY(1,1) NOT NULL,
	[TenTinh] [nvarchar](50) NULL,
	[Anh] [nvarchar](50) NULL,
 CONSTRAINT [PK_TinhThanh] PRIMARY KEY CLUSTERED 
(
	[MaTinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([ID], [Email], [Password]) VALUES (1, N'viet2002@gmail.com', N'e10adc3949ba59abbe56e057f20f883e')
INSERT [dbo].[Admin] ([ID], [Email], [Password]) VALUES (2, N'admin@gmail.com', N'21232f297a57a5a743894a0e4a801fc3')
INSERT [dbo].[Admin] ([ID], [Email], [Password]) VALUES (3, N'duongphamgl0202@gmail.com', N'fcea920f7412b5da7be0cf42b8c93759')
INSERT [dbo].[Admin] ([ID], [Email], [Password]) VALUES (4, N'test@gmail.com', N'fcea920f7412b5da7be0cf42b8c93759')
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[Blog] ON 

INSERT [dbo].[Blog] ([ID], [IDAdmin], [Anh], [TieuDe], [ThongTin], [NgayDang]) VALUES (2, 2, N'blog.jpg', N'Features holiday on the French Riviera', N'This is an example of the H2 header This is Photoshop''s version of Lorem Ipsum. Proin gravida nibh vel velit auctor aliquet. Aenean sollicitudin, lorem quis bibendum auctor, nisi elit consequat ipsum, nec sagittis sem nibh id elit.  Duis sed odio sit amet nibh vulputate cursus a sit amet mauris. Morbi accumsan ipsum velit. Nam nec tellus a odio tincidunt auctor a ornare odio. Sed non mauris vitae erat consequat auctor eu in elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Mauris in erat justo. Nullam ac urna eu felis dapibus condimentum sit amet a augue. Sed non neque elit. Sed ut imperdiet nisi. Proin condimentum fermentum nunc. Etiam pharetra, erat sed fermentum feugiat, velit mauris egestas quam, ut aliquam massa nisl quis neque. Suspendisse in orci enim.', CAST(N'2024-04-23' AS Date))
SET IDENTITY_INSERT [dbo].[Blog] OFF
GO
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'123sdfa.jpg', 69)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'adasd.jpg', 70)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'amiana private.jfif', 73)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'anhks3.webp', 57)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'anhks7.jpeg', 52)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'axcasdf.jfif', 63)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'biethugiuongdoisanv.jpg', 59)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'bietthuhuongbien.png', 72)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'blog.jpg', 55)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'color.jfif', 74)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'dlx.webp', 6)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'dlx1.webp', 6)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'dlx2.webp', 6)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'dlx3.webp', 6)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'dlx4.webp', 6)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'dlx5.webp', 6)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'free-photo-of-anh-sang-khach-s-n-den-gi-ng.jpeg', 97)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'fsdfasd.jpeg', 103)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-1103808.jpeg', 93)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-12003488.jpeg', 96)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-12715595.jpeg', 100)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-1571450.jpeg', 98)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-1579253.webp', 80)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-164595.jpeg', 75)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-172869.jpeg', 102)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-172872.webp', 90)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-1743231.jpeg', 91)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-1838554.webp', 87)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-2029722.jpeg', 84)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-210265.webp', 81)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-210604.webp', 89)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-2255424.webp', 94)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-237371.jpeg', 78)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-2417842.webp', 92)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-2467285.jpeg', 83)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-262048.jpeg', 76)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-271618.webp', 85)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-271619.webp', 79)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-271624.webp', 77)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-271643.jpeg', 86)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-3659683.webp', 88)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-4058767.webp', 99)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-5379175.webp', 95)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-7258034.jpeg', 104)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-7746042.webp', 101)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'pexels-photo-97083.jpeg', 82)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'phongprimere.jpg', 58)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'royal.jfif', 66)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'sadsad.jpg', 67)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'saigon.jfif', 71)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'Screenshot 2024-09-28 164637.png', 60)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'sdfasfd.jfif', 65)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'std.jpg', 1)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'std1.jpg', 1)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'std2.jpg', 1)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'std3.jpg', 1)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'std4.jpg', 1)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'stdnen.jpg', 2)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'stdnen1.webp', 2)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'stdnen2.webp', 2)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'stdnen3.webp', 2)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'suite.jpg', 64)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'VIP 02.jpg', 62)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'VIP.jpg', 68)
INSERT [dbo].[CTAnh] ([TenAnh], [MaPhong]) VALUES (N'VIP01.jpg', 61)
GO
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1030, CAST(N'2024-03-21T00:00:00.000' AS DateTime), CAST(N'2024-03-21T00:00:00.000' AS DateTime), CAST(N'2024-03-18T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1031, CAST(N'2024-03-23T00:00:00.000' AS DateTime), CAST(N'2024-03-23T00:00:00.000' AS DateTime), CAST(N'2024-03-20T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1033, CAST(N'2024-03-25T00:00:00.000' AS DateTime), CAST(N'2024-03-25T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1034, CAST(N'2024-03-28T00:00:00.000' AS DateTime), CAST(N'2024-03-28T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1035, CAST(N'2024-03-30T00:00:00.000' AS DateTime), CAST(N'2024-03-30T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1053, CAST(N'2024-04-05T00:00:00.000' AS DateTime), CAST(N'2024-04-05T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1060, CAST(N'2024-04-24T00:00:00.000' AS DateTime), CAST(N'2024-04-24T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1061, CAST(N'2024-04-25T00:00:00.000' AS DateTime), CAST(N'2024-04-25T00:00:00.000' AS DateTime), CAST(N'2024-04-22T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1067, CAST(N'2024-04-27T00:00:00.000' AS DateTime), CAST(N'2024-04-27T00:00:00.000' AS DateTime), CAST(N'2024-04-23T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1068, CAST(N'2024-04-28T00:00:00.000' AS DateTime), CAST(N'2024-04-28T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1072, CAST(N'2024-04-29T00:00:00.000' AS DateTime), CAST(N'2024-04-29T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1077, CAST(N'2024-04-30T00:00:00.000' AS DateTime), CAST(N'2024-04-30T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1082, CAST(N'2024-05-01T00:00:00.000' AS DateTime), CAST(N'2024-05-01T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1086, CAST(N'2024-05-02T00:00:00.000' AS DateTime), CAST(N'2024-05-02T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1089, CAST(N'2024-05-03T00:00:00.000' AS DateTime), CAST(N'2024-05-03T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1092, CAST(N'2024-05-08T00:00:00.000' AS DateTime), CAST(N'2024-05-08T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1093, CAST(N'2024-05-09T00:00:00.000' AS DateTime), CAST(N'2024-05-09T00:00:00.000' AS DateTime), CAST(N'2024-05-07T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1096, CAST(N'2024-05-10T00:00:00.000' AS DateTime), CAST(N'2024-05-10T00:00:00.000' AS DateTime), CAST(N'2024-05-08T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1136, CAST(N'2024-05-11T00:00:00.000' AS DateTime), CAST(N'2024-05-11T00:00:00.000' AS DateTime), CAST(N'2024-05-08T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1142, CAST(N'2024-05-11T00:00:00.000' AS DateTime), CAST(N'2024-05-11T00:00:00.000' AS DateTime), CAST(N'2024-05-08T00:00:00.000' AS DateTime), 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1144, CAST(N'2024-05-13T00:00:00.000' AS DateTime), CAST(N'2024-05-13T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1146, CAST(N'2024-05-14T00:00:00.000' AS DateTime), CAST(N'2024-05-14T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1152, CAST(N'2024-05-16T00:00:00.000' AS DateTime), CAST(N'2024-05-16T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1153, CAST(N'2024-05-17T00:00:00.000' AS DateTime), CAST(N'2024-05-17T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1154, CAST(N'2024-05-18T00:00:00.000' AS DateTime), CAST(N'2024-05-18T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1155, CAST(N'2024-05-19T00:00:00.000' AS DateTime), CAST(N'2024-05-19T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1156, CAST(N'2024-05-20T00:00:00.000' AS DateTime), CAST(N'2024-05-20T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1157, CAST(N'2024-05-21T00:00:00.000' AS DateTime), CAST(N'2024-05-21T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1158, CAST(N'2024-05-23T00:00:00.000' AS DateTime), CAST(N'2024-05-23T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1159, CAST(N'2024-05-15T00:00:00.000' AS DateTime), CAST(N'2024-05-15T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1160, CAST(N'2024-05-22T00:00:00.000' AS DateTime), CAST(N'2024-05-22T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1161, CAST(N'2024-05-24T00:00:00.000' AS DateTime), CAST(N'2024-05-24T00:00:00.000' AS DateTime), CAST(N'2024-05-20T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1165, CAST(N'2024-05-28T00:00:00.000' AS DateTime), CAST(N'2024-05-28T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1172, CAST(N'2024-06-03T00:00:00.000' AS DateTime), CAST(N'2024-06-03T00:00:00.000' AS DateTime), CAST(N'2024-05-30T08:18:10.353' AS DateTime), 2, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1175, CAST(N'2024-05-30T00:00:00.000' AS DateTime), CAST(N'2024-05-31T00:00:00.000' AS DateTime), NULL, 3, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (1, 1182, CAST(N'2024-06-04T00:00:00.000' AS DateTime), CAST(N'2024-06-04T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1016, CAST(N'2024-02-22T00:00:00.000' AS DateTime), CAST(N'2024-02-23T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1018, CAST(N'2024-02-24T00:00:00.000' AS DateTime), CAST(N'2024-02-26T00:00:00.000' AS DateTime), CAST(N'2024-05-22T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1019, CAST(N'2024-02-28T00:00:00.000' AS DateTime), CAST(N'2024-02-29T00:00:00.000' AS DateTime), CAST(N'2024-05-24T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1020, CAST(N'2024-03-01T00:00:00.000' AS DateTime), CAST(N'2024-03-01T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1021, CAST(N'2024-02-27T00:00:00.000' AS DateTime), CAST(N'2024-02-27T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1023, CAST(N'2024-03-05T00:00:00.000' AS DateTime), CAST(N'2024-03-05T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1024, CAST(N'2024-03-09T00:00:00.000' AS DateTime), CAST(N'2024-03-09T00:00:00.000' AS DateTime), NULL, 3, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1025, CAST(N'2024-03-08T00:00:00.000' AS DateTime), CAST(N'2024-03-08T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1026, CAST(N'2024-03-13T00:00:00.000' AS DateTime), CAST(N'2024-03-13T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1027, CAST(N'2024-03-07T00:00:00.000' AS DateTime), CAST(N'2024-03-07T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1039, CAST(N'2024-03-27T00:00:00.000' AS DateTime), CAST(N'2024-03-27T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1049, CAST(N'2024-04-03T00:00:00.000' AS DateTime), CAST(N'2024-04-03T00:00:00.000' AS DateTime), NULL, 3, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1052, CAST(N'2024-04-11T00:00:00.000' AS DateTime), CAST(N'2024-04-11T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1143, CAST(N'2024-05-15T00:00:00.000' AS DateTime), CAST(N'2024-05-15T00:00:00.000' AS DateTime), CAST(N'2024-05-12T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1147, CAST(N'2024-05-13T00:00:00.000' AS DateTime), CAST(N'2024-05-13T00:00:00.000' AS DateTime), CAST(N'2024-05-10T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1150, CAST(N'2024-05-17T00:00:00.000' AS DateTime), CAST(N'2024-05-18T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1151, CAST(N'2024-05-20T00:00:00.000' AS DateTime), CAST(N'2024-05-20T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1162, CAST(N'2024-05-19T00:00:00.000' AS DateTime), CAST(N'2024-05-19T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1163, CAST(N'2024-05-22T00:00:00.000' AS DateTime), CAST(N'2024-05-22T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1166, CAST(N'2024-05-28T00:00:00.000' AS DateTime), CAST(N'2024-05-28T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1169, CAST(N'2024-05-29T00:00:00.000' AS DateTime), CAST(N'2024-05-29T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1170, CAST(N'2024-05-30T00:00:00.000' AS DateTime), CAST(N'2024-05-30T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1173, CAST(N'2024-05-31T00:00:00.000' AS DateTime), CAST(N'2024-05-31T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1178, CAST(N'2024-06-04T00:00:00.000' AS DateTime), CAST(N'2024-06-04T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1181, CAST(N'2024-06-05T00:00:00.000' AS DateTime), CAST(N'2024-06-05T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (2, 1185, CAST(N'2024-09-29T00:00:00.000' AS DateTime), CAST(N'2024-09-30T00:00:00.000' AS DateTime), CAST(N'2024-09-28T03:26:21.377' AS DateTime), 3, 1)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (17, 1171, CAST(N'2024-05-29T00:00:00.000' AS DateTime), CAST(N'2024-05-29T00:00:00.000' AS DateTime), NULL, 3, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (17, 1201, CAST(N'2024-10-10T00:00:00.000' AS DateTime), CAST(N'2024-10-12T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (17, 1202, CAST(N'2024-10-10T00:00:00.000' AS DateTime), CAST(N'2024-10-12T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (18, 1174, CAST(N'2024-05-30T00:00:00.000' AS DateTime), CAST(N'2024-05-31T00:00:00.000' AS DateTime), NULL, 3, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (50, 1184, CAST(N'2024-06-08T00:00:00.000' AS DateTime), CAST(N'2024-06-08T00:00:00.000' AS DateTime), NULL, 1, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (57, 1164, CAST(N'2024-05-26T00:00:00.000' AS DateTime), CAST(N'2024-05-26T00:00:00.000' AS DateTime), NULL, 2, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (75, 1186, CAST(N'2024-10-16T00:00:00.000' AS DateTime), CAST(N'2024-10-17T00:00:00.000' AS DateTime), NULL, 4, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (75, 1187, CAST(N'2024-10-04T00:00:00.000' AS DateTime), CAST(N'2024-10-06T00:00:00.000' AS DateTime), NULL, 6, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (75, 1189, CAST(N'2024-10-11T00:00:00.000' AS DateTime), CAST(N'2024-10-12T00:00:00.000' AS DateTime), NULL, 6, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (75, 1190, CAST(N'2024-10-02T00:00:00.000' AS DateTime), CAST(N'2024-10-03T00:00:00.000' AS DateTime), NULL, 4, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (75, 1192, CAST(N'2024-10-07T00:00:00.000' AS DateTime), CAST(N'2024-10-08T00:00:00.000' AS DateTime), NULL, 4, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (75, 1194, CAST(N'2024-10-09T00:00:00.000' AS DateTime), CAST(N'2024-10-10T00:00:00.000' AS DateTime), NULL, 5, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (75, 1196, CAST(N'2024-10-13T00:00:00.000' AS DateTime), CAST(N'2024-10-14T00:00:00.000' AS DateTime), NULL, 5, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (75, 1197, CAST(N'2024-10-18T00:00:00.000' AS DateTime), CAST(N'2024-10-19T00:00:00.000' AS DateTime), NULL, 5, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (75, 1198, CAST(N'2024-10-20T00:00:00.000' AS DateTime), CAST(N'2024-10-21T00:00:00.000' AS DateTime), NULL, 5, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (75, 1199, CAST(N'2024-10-22T00:00:00.000' AS DateTime), CAST(N'2024-10-25T00:00:00.000' AS DateTime), NULL, 3, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (76, 1188, CAST(N'2024-10-04T00:00:00.000' AS DateTime), CAST(N'2024-10-06T00:00:00.000' AS DateTime), NULL, 6, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (76, 1191, CAST(N'2024-10-02T00:00:00.000' AS DateTime), CAST(N'2024-10-03T00:00:00.000' AS DateTime), NULL, 5, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (76, 1193, CAST(N'2024-10-07T00:00:00.000' AS DateTime), CAST(N'2024-10-08T00:00:00.000' AS DateTime), NULL, 3, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (76, 1195, CAST(N'2024-10-09T00:00:00.000' AS DateTime), CAST(N'2024-10-10T00:00:00.000' AS DateTime), NULL, 4, 0)
INSERT [dbo].[DatPhong] ([MaPhong], [SoHoaDon], [NgayDen], [NgayDi], [NgayHuy], [SoNguoi], [IsDelete]) VALUES (93, 1200, CAST(N'2024-10-08T00:00:00.000' AS DateTime), CAST(N'2024-10-10T00:00:00.000' AS DateTime), NULL, 2, 0)
GO
SET IDENTITY_INSERT [dbo].[GopY] ON 

INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (56, 5, 1, CAST(N'2024-03-12T00:00:00.000' AS DateTime), N'a', 4, 4, 4, 4, 4)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (57, 5, 1, CAST(N'2024-03-12T00:00:00.000' AS DateTime), N'af', 6, 6, 6, 6, 6)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (82, 5, 1, CAST(N'2024-03-12T00:00:00.000' AS DateTime), N'aa', 8, 8, 8, 8, 8)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (83, 5, 1, CAST(N'2024-03-12T00:00:00.000' AS DateTime), N'f', 9, 9, 9, 9, 9)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (89, 5, 1, CAST(N'2024-03-12T00:00:00.000' AS DateTime), N'nhân viên phục vụ quá tuyệt vời ạ', 9, 9, 9, 9, 9)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (90, 5, 1, CAST(N'2024-03-12T00:00:00.000' AS DateTime), N'tốt', 8, 8, 8, 8, 8)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (91, 5, 1, CAST(N'2024-03-12T00:00:00.000' AS DateTime), N'quá là ok', 9.3000001907348633, 9.6999998092651367, 9.3999996185302734, 9.6999998092651367, 10)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (92, 5, 2, CAST(N'2024-03-13T00:00:00.000' AS DateTime), N'tuyệt vời', 9.4, 9.7, 9.7, 9.8, 9.8)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (93, 2, 1, CAST(N'2024-03-13T00:00:00.000' AS DateTime), N'tuyệt vời', 9.2, 9.5, 9.7, 9.8, 9.8)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (94, 6, 1, CAST(N'2024-03-13T00:00:00.000' AS DateTime), N'tệ', 5.5, 3.5, 2.4, 1.9, 1.1)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (95, 2, 1, CAST(N'2024-03-13T00:00:00.000' AS DateTime), N'Tốt quá đi', 10, 10, 10, 10, 10)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (96, 2, 1, CAST(N'2024-03-15T00:00:00.000' AS DateTime), N'Tệ quá tệ', 0.7, 1.3, 2.1, 2.3, 2.3)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (98, 5, 1, CAST(N'2024-05-10T00:00:00.000' AS DateTime), N'a', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (99, 5, 1, CAST(N'2024-05-10T00:00:00.000' AS DateTime), N'tốt', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (100, 5, 1, CAST(N'2024-05-10T00:00:00.000' AS DateTime), N'ppp', 9.6, 9.9, 9, 9.1, 8.8)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (101, 5, 1, CAST(N'2024-05-10T00:00:00.000' AS DateTime), N'eee', 9.5, 9.8, 9.7, 9.2, 8.9)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (102, 5, 1, CAST(N'2024-05-10T00:00:00.000' AS DateTime), N'aaa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (103, 5, 1, CAST(N'2024-05-10T00:00:00.000' AS DateTime), N'aa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (104, 5, 1, CAST(N'2024-05-10T00:00:00.000' AS DateTime), N'g', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (105, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'a', 9.2, 8.9, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (106, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'aa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (107, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'dd', 8.2, 8.2, 8.2, 8.2, 10)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (108, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'aarr', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (109, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'đẹp quá đi', 9.9, 9.9, 9.9, 9.9, 9.9)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (110, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'aa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (113, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'a', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (114, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'z', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (116, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'aa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (121, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'bb', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (122, 5, 1, CAST(N'2024-05-12T00:00:00.000' AS DateTime), N'ô', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (126, 5, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'aa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (127, 5, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'bb', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (131, 5, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'aaa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (132, 5, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'nnn', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (146, 5, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'b', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (147, 5, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'nn', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (155, 5, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'sss', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (157, 5, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'aa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (166, 2, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'nnn', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (168, 2, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'sss', 8.9, 8.8, 8.9, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (169, 2, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'aaaaa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (170, 2, 1, CAST(N'2024-05-13T00:00:00.000' AS DateTime), N'ok', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (171, 5, 1, CAST(N'2024-05-13T11:55:20.483' AS DateTime), N'tuyệt', 9.7, 9.8, 9.9, 9.9, 9.7)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (172, 5, 1, CAST(N'2024-05-13T12:01:25.437' AS DateTime), N'ssss', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (173, 5, 1, CAST(N'2024-05-13T12:01:37.507' AS DateTime), N'e', 8.2, 8.2, 8.2, 8.2, 9.7)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (174, 2, 1, CAST(N'2024-05-13T12:02:03.233' AS DateTime), N'ggg', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (175, 5, 1, CAST(N'2024-05-13T12:09:33.623' AS DateTime), N'hh', 8.2, 8.2, 8.2, 8.2, 9.5)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (179, 5, 1, CAST(N'2024-05-13T14:55:05.530' AS DateTime), N'aa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (180, 5, 1, CAST(N'2024-05-13T14:55:17.967' AS DateTime), N'aa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (184, 5, 1, CAST(N'2024-05-13T16:30:31.447' AS DateTime), N'aa', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (189, 2, 1, CAST(N'2024-05-19T10:40:46.070' AS DateTime), N'Hoàng ', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (190, 2, 2, CAST(N'2024-05-22T21:42:53.263' AS DateTime), N'đẹp quá', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (191, 2, 2, CAST(N'2024-05-22T21:45:37.320' AS DateTime), N'a', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (192, 2, 2, CAST(N'2024-05-22T21:45:39.167' AS DateTime), N'a', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (194, 5, 1, CAST(N'2024-05-27T20:26:24.660' AS DateTime), N'ổn', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (195, 5, 1, CAST(N'2024-05-27T20:28:20.910' AS DateTime), N'a', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (196, 5, 1, CAST(N'2024-05-27T20:28:36.290' AS DateTime), N'view đẹp, dịch vụ tốt', 8.2, 8.2, 8.2, 8.2, 8.2)
INSERT [dbo].[GopY] ([ID], [MaKH], [MaKS], [NgayComment], [Comment], [DiemNhanVien], [DiemDoAn], [DiemSachSe], [DiemThoaiMai], [DiemDichVu]) VALUES (197, 5, 1, CAST(N'2024-05-28T19:25:32.810' AS DateTime), N'dịch vụ tốt quá , nhân viên phục vụ nhiệt tình', 9.5, 9.4, 9.5, 9.8, 9.8)
SET IDENTITY_INSERT [dbo].[GopY] OFF
GO
SET IDENTITY_INSERT [dbo].[HoaDon] ON 

INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1016, 2, CAST(N'2024-02-23T00:00:00.000' AS DateTime), NULL, N'Viet', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1018, 2, CAST(N'2024-02-26T00:00:00.000' AS DateTime), NULL, N'Viet', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1019, 2, CAST(N'2024-02-29T00:00:00.000' AS DateTime), NULL, N'Viet', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1020, 5, CAST(N'2024-03-01T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1021, 5, CAST(N'2024-02-27T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1023, 5, CAST(N'2024-03-05T00:00:00.000' AS DateTime), NULL, N'Đỗ Đức Việt', N'vietsex3012@gmail.com', N'0912345678', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1024, 5, CAST(N'2024-03-09T00:00:00.000' AS DateTime), NULL, N'Đỗ Đức Việt', N'vietsex3012@gmail.com', N'0912345678', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1025, 5, CAST(N'2024-03-08T00:00:00.000' AS DateTime), NULL, N'Đỗ Đức Việt', N'vietsex3012@gmail.com', N'0924232846', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1026, 5, CAST(N'2024-03-13T00:00:00.000' AS DateTime), NULL, N'Đỗ Đức Việt', N'vietsex3012@gmail.com', N'0912345874', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1027, 5, CAST(N'2024-03-07T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1030, 2, CAST(N'2024-03-21T00:00:00.000' AS DateTime), NULL, N'Nguyen Van A', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1031, 2, CAST(N'2024-03-23T00:00:00.000' AS DateTime), NULL, N'Nguyen Van A', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1033, 2, CAST(N'2024-03-25T00:00:00.000' AS DateTime), NULL, N'Nguyen Van A', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1034, 2, CAST(N'2024-03-28T00:00:00.000' AS DateTime), NULL, N'Nguyen Van A', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1035, 2, CAST(N'2024-03-30T00:00:00.000' AS DateTime), NULL, N'Nguyen Van A', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1039, 2, CAST(N'2024-03-27T00:00:00.000' AS DateTime), NULL, N'Nguyen Van A', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1049, 5, CAST(N'2024-04-03T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1052, 5, CAST(N'2024-04-11T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1053, 5, CAST(N'2024-04-05T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1060, 5, CAST(N'2024-04-24T00:00:00.000' AS DateTime), CAST(N'2024-05-28T14:55:47.977' AS DateTime), N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1061, 5, CAST(N'2024-04-25T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1067, 5, CAST(N'2024-04-27T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1068, 5, CAST(N'2024-04-28T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1072, 5, CAST(N'2024-04-29T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1077, 5, CAST(N'2024-04-30T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1082, 5, CAST(N'2024-05-01T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1086, 5, CAST(N'2024-05-02T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1089, 5, CAST(N'2024-05-03T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1092, 5, CAST(N'2024-05-08T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1093, 5, CAST(N'2024-05-09T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1096, 5, CAST(N'2024-05-10T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1136, 5, CAST(N'2024-05-11T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã hủy', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1138, 5, CAST(N'2024-05-13T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã hủy', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1141, 5, CAST(N'2024-05-12T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã hủy', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1142, 5, CAST(N'2024-05-11T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1143, 5, CAST(N'2024-05-15T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã hủy', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1144, 5, CAST(N'2024-05-13T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1146, 5, CAST(N'2024-05-14T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1147, 5, CAST(N'2024-05-13T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1150, 5, CAST(N'2024-05-18T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1151, 5, CAST(N'2024-05-20T00:00:00.000' AS DateTime), CAST(N'2024-06-07T08:12:24.917' AS DateTime), N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1152, 2, CAST(N'2024-05-16T00:00:00.000' AS DateTime), CAST(N'2024-06-07T08:15:56.397' AS DateTime), N'Nguyen Van A', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1153, 5, CAST(N'2024-05-17T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1154, 5, CAST(N'2024-05-18T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1155, 5, CAST(N'2024-05-19T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1156, 5, CAST(N'2024-05-20T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1157, 5, CAST(N'2024-05-21T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1158, 5, CAST(N'2024-05-23T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1159, 5, CAST(N'2024-05-15T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1160, 5, CAST(N'2024-05-22T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1161, 5, CAST(N'2024-05-24T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã hủy', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1162, 5, CAST(N'2024-05-19T00:00:00.000' AS DateTime), NULL, N'viet', N'doducviet3012@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1163, 5, CAST(N'2024-05-22T00:00:00.000' AS DateTime), NULL, N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1164, 2, CAST(N'2024-05-26T00:00:00.000' AS DateTime), NULL, N'Nguyen Van A', N'viet123@gmail.com', N'0123456789', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1165, 5, CAST(N'2024-05-28T00:00:00.000' AS DateTime), NULL, N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1166, 5, CAST(N'2024-05-28T00:00:00.000' AS DateTime), NULL, N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1169, 5, CAST(N'2024-05-28T16:39:45.723' AS DateTime), CAST(N'2024-06-07T08:09:54.307' AS DateTime), N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1170, 5, CAST(N'2024-05-28T19:42:40.447' AS DateTime), CAST(N'2024-06-07T08:03:24.420' AS DateTime), N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1171, 5, CAST(N'2024-05-29T23:36:59.293' AS DateTime), CAST(N'2024-06-07T08:14:10.387' AS DateTime), N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1172, 5, CAST(N'2024-05-30T08:15:56.097' AS DateTime), CAST(N'2024-06-07T21:58:13.323' AS DateTime), N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã hủy', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1173, 5, CAST(N'2024-05-30T20:52:01.303' AS DateTime), CAST(N'2024-06-06T22:57:31.533' AS DateTime), N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1174, 5, CAST(N'2024-05-30T21:00:48.690' AS DateTime), CAST(N'2024-06-06T22:59:29.770' AS DateTime), N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1175, 5, CAST(N'2024-05-30T21:02:06.080' AS DateTime), CAST(N'2024-06-06T22:55:20.790' AS DateTime), N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1178, 5, CAST(N'2024-06-03T16:21:11.407' AS DateTime), NULL, N'Việt', N'doducviet3012@gmail.com', N'0903497119', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1181, 5, CAST(N'2024-06-03T17:04:51.643' AS DateTime), CAST(N'2024-06-07T08:02:24.987' AS DateTime), N'Đỗ Đức Việt', N'doducviet3012@gmail.com', N'0903490883', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1182, 5, CAST(N'2024-06-03T17:21:40.137' AS DateTime), CAST(N'2024-06-06T22:39:44.440' AS DateTime), N'Đỗ Đức Việt', N'doducviet3012@gmail.com', N'0903490883', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1183, NULL, CAST(N'2024-06-07T15:58:04.793' AS DateTime), NULL, N'Đỗ Đức Việt', N'doducviet1@gmail.com', N'0903490883', N'Đã thanh toán', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1184, NULL, CAST(N'2024-06-07T16:04:17.947' AS DateTime), NULL, N'Đỗ Đức Việt', N'doducviet1@gmail.com', N'0903490883', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1185, 11, CAST(N'2024-09-28T03:23:32.543' AS DateTime), NULL, N'Phạm Thái Dương', N'dpham990@gmail.com', N'0393541496', N'Đã hủy', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1186, NULL, CAST(N'2024-09-29T21:05:32.293' AS DateTime), NULL, N'Phạm Thái Dương', N'duongphamgl0202@gmail.com', N'0393541496', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1187, NULL, CAST(N'2024-10-01T01:31:36.967' AS DateTime), NULL, N'Phạm Thái Dương', N'duongphamgl0202@gmail.com', N'0393541496', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1188, NULL, CAST(N'2024-10-01T01:31:37.113' AS DateTime), NULL, N'Phạm Thái Dương', N'duongphamgl0202@gmail.com', N'0393541496', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1189, NULL, CAST(N'2024-10-01T01:36:18.597' AS DateTime), NULL, N'Phạm Thái Dương', N'duongphamgl0202@gmail.com', N'0393541496', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1190, NULL, CAST(N'2024-10-01T02:55:22.197' AS DateTime), NULL, NULL, NULL, NULL, N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1191, NULL, CAST(N'2024-10-01T02:55:22.413' AS DateTime), NULL, NULL, NULL, NULL, N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1192, NULL, CAST(N'2024-10-01T03:00:05.147' AS DateTime), NULL, NULL, NULL, NULL, N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1193, NULL, CAST(N'2024-10-01T03:00:05.367' AS DateTime), NULL, NULL, NULL, NULL, N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1194, NULL, CAST(N'2024-10-01T03:06:25.613' AS DateTime), NULL, NULL, NULL, NULL, N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1195, NULL, CAST(N'2024-10-01T03:06:27.723' AS DateTime), NULL, NULL, NULL, NULL, N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1196, NULL, CAST(N'2024-10-01T03:15:35.473' AS DateTime), NULL, NULL, NULL, NULL, N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1197, NULL, CAST(N'2024-10-01T03:36:04.437' AS DateTime), NULL, N'Phạm Thái Dương', N'duongphamgl0202@gmail.com', N'0393541496', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1198, NULL, CAST(N'2024-10-01T04:02:11.550' AS DateTime), NULL, N'Phạm Thái Dương', N'duongphamgl0202@gmail.com', N'0393541496', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1199, NULL, CAST(N'2024-10-06T14:21:42.703' AS DateTime), NULL, N'Phạm Thái Dương', N'duongphamgl0202@gmail.com', N'0393541496', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1200, NULL, CAST(N'2024-10-06T14:21:42.830' AS DateTime), NULL, N'Phạm Thái Dương', N'duongphamgl0202@gmail.com', N'0393541496', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1201, NULL, CAST(N'2024-10-06T14:21:42.833' AS DateTime), NULL, N'Phạm Thái Dương', N'duongphamgl0202@gmail.com', N'0393541496', N'Đã đặt cọc', NULL)
INSERT [dbo].[HoaDon] ([SoHoaDon], [MaKH], [NgayThanhToan], [NgayTao], [TenKH], [Email], [SDT], [TinhTrang], [ThanhTien]) VALUES (1202, NULL, CAST(N'2024-10-06T14:21:42.837' AS DateTime), NULL, N'Phạm Thái Dương', N'duongphamgl0202@gmail.com', N'0393541496', N'Đã đặt cọc', NULL)
SET IDENTITY_INSERT [dbo].[HoaDon] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachHang] ON 

INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [Email], [Password], [NgaySinh], [DiaChi], [SDT], [UserId], [HieuLuc]) VALUES (2, N'Nguyen Van A', 0, N'viet201200413@gmail.com', N'fcea920f7412b5da7be0cf42b8c93759', CAST(N'1999-02-11' AS Date), N'Hà Nội', N'0123456789', 1, 0)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [Email], [Password], [NgaySinh], [DiaChi], [SDT], [UserId], [HieuLuc]) VALUES (3, N'viet', 1, N'viet1234@gmail.com', N'fcea920f7412b5da7be0cf42b8c93759', CAST(N'1990-02-22' AS Date), N'Hà Nội', N'0123456789', 0, 0)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [Email], [Password], [NgaySinh], [DiaChi], [SDT], [UserId], [HieuLuc]) VALUES (4, N'viet', 1, N'viet12345@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', CAST(N'1984-02-11' AS Date), N'Hà Nội', N'0123456789', 1, 0)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [Email], [Password], [NgaySinh], [DiaChi], [SDT], [UserId], [HieuLuc]) VALUES (5, N'Việt', 0, N'doducviet3012@gmail.com', N'fcea920f7412b5da7be0cf42b8c93759', CAST(N'1987-01-23' AS Date), N'Hà Nội', N'0903497119', 0, 0)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [Email], [Password], [NgaySinh], [DiaChi], [SDT], [UserId], [HieuLuc]) VALUES (6, N'Lê Văn An', 0, N'an123@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', CAST(N'1999-02-20' AS Date), N'Hà Nội', N'0123456789', 0, 1)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [Email], [Password], [NgaySinh], [DiaChi], [SDT], [UserId], [HieuLuc]) VALUES (9, N'Viet', 0, N'doducviet144@gmail.com', N'c4ca4238a0b923820dcc509a6f75849b', CAST(N'2000-04-29' AS Date), N'Hải Phòng', N'0909748321', 0, 0)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [Email], [Password], [NgaySinh], [DiaChi], [SDT], [UserId], [HieuLuc]) VALUES (10, N'Test', 0, N'testkhachhang@gmail.com', N'fcea920f7412b5da7be0cf42b8c93759', CAST(N'2000-01-01' AS Date), N'Hà Nội', N'0987654321', 0, 0)
INSERT [dbo].[KhachHang] ([MaKH], [TenKH], [GioiTinh], [Email], [Password], [NgaySinh], [DiaChi], [SDT], [UserId], [HieuLuc]) VALUES (11, N'Phạm Dương', 0, N'dpham990@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', NULL, N'Nam Từ Liêm, Hà Nội', N'0393541496', 0, 0)
SET IDENTITY_INSERT [dbo].[KhachHang] OFF
GO
SET IDENTITY_INSERT [dbo].[KhachSan] ON 

INSERT [dbo].[KhachSan] ([MaKS], [MaTinh], [IDNguoiTao], [TenKhachSan], [DiaChi], [MoTa], [Anh], [DanhGia], [Duyet]) VALUES (1, 1, 2, N'Hotel Royal', N'165, Phường Nghĩa Đô, Quận Cầu Giấy, Thành phố Hà Nội, Phường Nghĩa Đô, Quận Cầu Giấy, Thành phố Hà Nội', N'Khách sạn Hoàng Sơn Peace tọa lạc gần Quảng trường Đinh Tiên Hoàng - Công trình lịch sử chào mừng đại lễ 1000 năm Thăng Long Hà Nội. Nằm giữa trung tâm kinh tế và văn hóa của Thành Phố Ninh Bình, Khách sạn Hoàng Sơn Peace mong muốn là cánh cửa đầu tiên ở Ninh Bình chào đón Quý khách trong nước và Quốc tế về với Ninh Bình, miền đất sở hữu 2 loại hình du lịch đặc trưng là du lịch sinh thái và du lịch văn hóa tâm linh. 

	Với chất lượng đạt chuẩn Quốc tế 4 sao,  Khách sạn Hoàng Sơn Peace không chỉ đáp ứng hoàn hảo nhu cầu nghỉ ngơi của Quý khách mà còn mang đến những giây phút thư giãn giải trí tuyệt vời và để lại dư vị ấn tượng trong văn hóa ẩm thực nơi đây. Khách sạn là sự kết hợp hài hòa của phong cách mang màu sắc sang trọng, hiện đại và cổ kính bao gồm cả quần thể Nhà hàng, Bể Bơi, sân Tennis và các khu vui chơi giải trí khác được quy tụ trong một khuôn viên rộng lớn gần 15.000 m2 . ', N'ks_hanoi.jpg', 5, 1)
INSERT [dbo].[KhachSan] ([MaKS], [MaTinh], [IDNguoiTao], [TenKhachSan], [DiaChi], [MoTa], [Anh], [DanhGia], [Duyet]) VALUES (2, 1, 2, N'Apricot Hotel', N'12, Phường Nhân Chính, Quận Thanh Xuân, Thành phố Hà Nội', NULL, N'ks_hanoi1.jpg', 4, 1)
INSERT [dbo].[KhachSan] ([MaKS], [MaTinh], [IDNguoiTao], [TenKhachSan], [DiaChi], [MoTa], [Anh], [DanhGia], [Duyet]) VALUES (3, 1, 2, N'Pan Pacific Hanoi', N'15, Phường Hàng Mã, Quận Hoàn Kiếm, Thành phố Hà Nội', NULL, N'ks_hanoi2.jpg', 3, 1)
INSERT [dbo].[KhachSan] ([MaKS], [MaTinh], [IDNguoiTao], [TenKhachSan], [DiaChi], [MoTa], [Anh], [DanhGia], [Duyet]) VALUES (4, 3, 2, N'Vinpearl Luxury Nha Trang', N'50, Phường Vĩnh Hòa, Thành phố Nha Trang, Tỉnh Khánh Hòa', NULL, N'ks_nhatrang.jpg', 3, 1)
INSERT [dbo].[KhachSan] ([MaKS], [MaTinh], [IDNguoiTao], [TenKhachSan], [DiaChi], [MoTa], [Anh], [DanhGia], [Duyet]) VALUES (5, 4, 2, N'Amiana Resort Nha Trang', N'6, Phường Bãi Cháy, Thành phố Hạ Long, Tỉnh Quảng Ninh', NULL, N'ks_nhatrang1.jpg', 4, 1)
INSERT [dbo].[KhachSan] ([MaKS], [MaTinh], [IDNguoiTao], [TenKhachSan], [DiaChi], [MoTa], [Anh], [DanhGia], [Duyet]) VALUES (6, 3, 3, N'Evason Ana Mandara Nha Trang', N'Tỉnh Khánh Hòa, Thành phố Nha Trang, Phường Vạn Thắng, Số2', N'đẹp ', N'ks_nhatrang2.jpg', 5, 1)
INSERT [dbo].[KhachSan] ([MaKS], [MaTinh], [IDNguoiTao], [TenKhachSan], [DiaChi], [MoTa], [Anh], [DanhGia], [Duyet]) VALUES (19, 1, 2, N'Cầu Giấy Hotel', N'Thành phố Hà Nội, Quận Cầu Giấy, Phường Nghĩa Đô, số 1', N'đẹp', N'anhks2.jpeg', 5, 1)
INSERT [dbo].[KhachSan] ([MaKS], [MaTinh], [IDNguoiTao], [TenKhachSan], [DiaChi], [MoTa], [Anh], [DanhGia], [Duyet]) VALUES (20, 1, 2, N'Luxury Hotel', N'2, Phường Yên Hoà, Quận Cầu Giấy, Thành phố Hà Nội', N'đẹp', N'anhks5.jpeg', 4, 1)
SET IDENTITY_INSERT [dbo].[KhachSan] OFF
GO
SET IDENTITY_INSERT [dbo].[LoaiPhong] ON 

INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (2, 1, N'Phòng Family', 7, 1000000, N'fml.jpg', NULL, N'80m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (3, 1, N'Phòng Standard', 3, 500000, N'std.jpg', NULL, N'25m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (4, 1, N'Phòng Superior', 3, 400000, N'sup.webp', NULL, N'30m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (5, 2, N'Phòng Suite', 6, 2000000, N'sui.jpg', N'đẹp', N'100m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (6, 1, N'Phòng Deluxe', 4, 800000, N'dlx.webp', NULL, N'40m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (9, 3, N'Phòng Standard', 3, 350000, N'anhks.jpeg', N'đẹp', N'30m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (11, 4, N' Biệt Thự Sân Vườn', 4, 4000000, N'biethu.jpg', N'Với diện tích 75 m², biệt thự có thiết kế sang trọng, thông minh, tích hợp đầy đủ tiện nghi cho kỳ lưu trú của bạn. Tầm nhìn hướng ra biển lãng mạn, có bể bơi riêng, biệt thự là lựa chọn lý tưởng dành cho các cặp đôi đi du lịch nghỉ dưỡng hoặc chuyến công tác 2 người.', N'75 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (12, 4, N'Biệt thự hướng biển', 4, 5000000, N'bietthuhuongbien.png', N'Với diện tích 75 m², biệt thự có thiết kế sang trọng, thông minh, tích hợp đầy đủ tiện nghi cho kỳ lưu trú của bạn. Tầm nhìn hướng ra biển lãng mạn, có bể bơi riêng, biệt thự là lựa chọn lý tưởng dành cho các cặp đôi đi du lịch nghỉ dưỡng hoặc chuyến công tác 2 người.', N'75 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (13, 4, N'Phòng VIP', 2, 10000000, N'VIP.jpg', N'Phòng dành cho thành viên VIP của khách sạn', N'150 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (14, 19, N'Phòng Classic', 6, 1000000, N'axcasdf.jfif', N'Phòng Classic tại khách sạn được thiết kế tinh tế, mang đến không gian nghỉ ngơi thoải mái và ấm cúng. Với diện tích vừa đủ, phòng được trang bị nội thất hiện đại, bao gồm giường ngủ êm ái, bàn làm việc, TV màn hình phẳng và minibar. Các phòng đều có cửa sổ lớn đón ánh sáng tự nhiên, tạo cảm giác thoáng đãng và thư giãn. Phòng tắm riêng được trang bị đầy đủ tiện nghi với vòi sen hoặc bồn tắm, đảm bảo sự tiện lợi và thoải mái cho khách lưu trú. Đây là lựa chọn lý tưởng cho những chuyến công tác ngắn ngày hay kỳ nghỉ thư giãn cùng gia đình và bạn bè.', N'40 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (15, 19, N'Phòng Superior', 4, 3200000, N'sdfasfd.jfif', N'Phòng Superior có không gian rộng rãi hơn với thiết kế hiện đại và tinh tế. Nội thất được nâng cấp với giường ngủ cao cấp, sofa thư giãn và bàn trang điểm. Phòng này thường có cửa sổ lớn với tầm nhìn đẹp ra thành phố hoặc cảnh quan xung quanh. Phòng tắm riêng đi kèm với bồn tắm và các sản phẩm chăm sóc cá nhân cao cấp.', N'50 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (16, 19, N'Phòng Deluxe', 4, 4500000, N'291527_19080307170078978076.webp', N'Phòng Deluxe là sự kết hợp hoàn hảo giữa sang trọng và tiện nghi. Phòng được trang bị giường cỡ King, khu vực ngồi thoải mái và tủ quần áo lớn. Nội thất cao cấp cùng với ánh sáng dịu dàng tạo ra không gian thư giãn. Phòng tắm riêng có bồn tắm lớn và vòi sen đứng, cung cấp trải nghiệm thư giãn tuyệt vời.', N'75 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (17, 19, N'Phòng Executive', 4, 6000000, N'adsd.jpg', N'Phòng Executive thường dành cho khách doanh nhân, được thiết kế với không gian làm việc tiện nghi. Ngoài giường ngủ thoải mái, phòng còn có bàn làm việc lớn, ghế tựa và kết nối Internet tốc độ cao. Phòng này thường có các dịch vụ đặc biệt như truy cập phòng chờ VIP và các bữa ăn sáng miễn phí.', N'75 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (18, 19, N'Phòng Gia Đình', 6, 2200000, N'12312.jpg', N'Phòng Gia Đình là lựa chọn lý tưởng cho các gia đình đi du lịch cùng nhau. Phòng thường được trang bị giường đôi và một hoặc hai giường đơn, đủ chỗ cho cả gia đình. Nội thất thân thiện với trẻ em và không gian rộng rãi giúp mọi người cảm thấy thoải mái. Phòng tắm có đầy đủ tiện nghi và các thiết bị an toàn cho trẻ em.', N'40 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (19, 19, N'Phòng VIP', 2, 12000000, N'sadsad.jpg', N'Phòng dành cho thành viên VIP của khách sạn', N'80 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (20, 2, N'Phòng Classic', 4, 700000, N'axcasdf.jfif', N'Phòng Classic mang đến không gian ấm cúng với nội thất trang nhã. Được trang bị giường lớn hoặc giường đôi, phòng này thường có bàn làm việc, TV màn hình phẳng và minibar. Phòng tắm riêng đi kèm với vòi sen hiện đại và các tiện nghi cơ bản. Đây là sự lựa chọn hoàn hảo cho những ai tìm kiếm sự thoải mái trong kỳ nghỉ.', N'75 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (21, 2, N'Phòng Superior', 6, 1000000, N'sdfasfd.jfif', N'Phòng Superior có không gian rộng rãi hơn với thiết kế hiện đại và tinh tế. Nội thất được nâng cấp với giường ngủ cao cấp, sofa thư giãn và bàn trang điểm. Phòng này thường có cửa sổ lớn với tầm nhìn đẹp ra thành phố hoặc cảnh quan xung quanh. Phòng tắm riêng đi kèm với bồn tắm và các sản phẩm chăm sóc cá nhân cao cấp.', N'40 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (22, 2, N'Phòng VIP', 2, 8000000, N'12asdc.jpg', N'Phòng dành cho thành viên VIP', N'75 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (23, 3, N'Phòng VIP', 2, 8880000, N'VIP.jpg', N'Phòng dành cho VIP của khách sạn', N'75 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (24, 3, N'Phòng Classic', 4, 8000000, N'axcasdf.jfif', N'Phòng Classic mang đến không gian ấm cúng với nội thất trang nhã. Được trang bị giường lớn hoặc giường đôi, phòng này thường có bàn làm việc, TV màn hình phẳng và minibar. Phòng tắm riêng đi kèm với vòi sen hiện đại và các tiện nghi cơ bản. Đây là sự lựa chọn hoàn hảo cho những ai tìm kiếm sự thoải mái trong kỳ nghỉ.', N'40 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (25, 3, N'Phòng Gia Đình', 6, 1700000, N'12312.jpg', N'Phòng Gia Đình là lựa chọn lý tưởng cho các gia đình đi du lịch cùng nhau. Phòng thường được trang bị giường đôi và một hoặc hai giường đơn, đủ chỗ cho cả gia đình. Nội thất thân thiện với trẻ em và không gian rộng rãi giúp mọi người cảm thấy thoải mái. Phòng tắm có đầy đủ tiện nghi và các thiết bị an toàn cho trẻ em.', N'50 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (26, 5, N' Biệt Thự Sân Vườn', 6, 8000000, N'biethu.jpg', N'Biệt thự sân vườn Nha Trang là một không gian nghỉ dưỡng lý tưởng, kết hợp giữa thiên nhiên tươi đẹp và kiến trúc hiện đại. Nằm giữa lòng thành phố, biệt thự có khuôn viên rộng rãi với vườn cây xanh mát, hồ bơi riêng và các phòng ngủ thoáng đãng, đầy đủ tiện nghi. Với thiết kế mở, biệt thự mang đến ánh sáng tự nhiên và không khí trong lành, lý tưởng để thư giãn cùng gia đình và bạn bè. Chỉ mất vài phút đi bộ là bạn đã đến bãi biển Nha Trang xinh đẹp, nơi có những hoạt động vui chơi giải trí hấp dẫn.', N'80 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (27, 5, N'Biệt thự hướng biển', 10, 15000000, N'bietthuhuongbien.png', N'
Biệt thự hướng biển tại Amiana Nha Trang mang đến trải nghiệm nghỉ dưỡng tuyệt vời với tầm nhìn panoramic ra biển xanh bao la. Với thiết kế sang trọng và hiện đại, biệt thự có không gian mở, cho phép ánh sáng tự nhiên tràn ngập và gió biển thổi vào từng ngóc ngách. Các phòng ngủ đều được trang bị cửa kính lớn, giúp bạn thưởng thức khung cảnh tuyệt đẹp của bình minh và hoàng hôn trên biển.
Khu vườn xung quanh biệt thự được chăm sóc tỉ mỉ với nhiều loại cây cối, tạo nên không gian thư giãn lý tưởng. Hồ bơi vô cực ngay bên cạnh là nơi hoàn hảo để ngâm mình và thư giãn, trong khi bạn ngắm nhìn sóng biển vỗ về. Chỉ cần bước ra khỏi biệt thự là bạn đã có thể dễ dàng tới bãi biển, tham gia các hoạt động thể thao nước hoặc thưởng thức hải sản tươi ngon tại các quán ăn ven biển. Biệt thự hướng biển Nha Trang chắc chắn sẽ mang đến cho bạn những kỷ niệm đáng nhớ trong kỳ nghỉ.', N'150 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (28, 20, N'Phòng Classic', 4, 1000000, N'291527_19080307170078978076.webp', N'Phòng Classic mang đến không gian ấm cúng với nội thất trang nhã. Được trang bị giường lớn hoặc giường đôi, phòng này thường có bàn làm việc, TV màn hình phẳng và minibar. Phòng tắm riêng đi kèm với vòi sen hiện đại và các tiện nghi cơ bản. Đây là sự lựa chọn hoàn hảo cho những ai tìm kiếm sự thoải mái trong kỳ nghỉ.', N'40 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (29, 20, N'Phòng Superior', 4, 3200000, N'royal.jfif', N'Phòng Superior có không gian rộng rãi hơn với thiết kế hiện đại và tinh tế. Nội thất được nâng cấp với giường ngủ cao cấp, sofa thư giãn và bàn trang điểm. Phòng này thường có cửa sổ lớn với tầm nhìn đẹp ra thành phố hoặc cảnh quan xung quanh. Phòng tắm riêng đi kèm với bồn tắm và các sản phẩm chăm sóc cá nhân cao cấp.', N'50 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (30, 20, N'Phòng Gia Đình', 6, 3200000, N'12312.jpg', N'Phòng Gia Đình là lựa chọn lý tưởng cho các gia đình đi du lịch cùng nhau. Phòng thường được trang bị giường đôi và một hoặc hai giường đơn, đủ chỗ cho cả gia đình. Nội thất thân thiện với trẻ em và không gian rộng rãi giúp mọi người cảm thấy thoải mái. Phòng tắm có đầy đủ tiện nghi và các thiết bị an toàn cho trẻ em.', N'80 m2')
INSERT [dbo].[LoaiPhong] ([MaLP], [MaKS], [TenLP], [SoNguoiToiDa], [Gia], [Anh], [ThongTin], [KichThuoc]) VALUES (31, 20, N'Phòng Luxury', 2, 8000000, N'VIP01.jpg', N'Phòng đặc biệt của khách sạn', N'80 m2')
SET IDENTITY_INSERT [dbo].[LoaiPhong] OFF
GO
SET IDENTITY_INSERT [dbo].[Phong] ON 

INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (1, N'Phòng Standard Classic', 3, N'std.jpg', N'Mô Tả Phòng Standard

Phòng Standard là sự kết hợp hoàn hảo giữa thoải mái và tiện nghi. Với không gian rộng rãi và trang bị đầy đủ các tiện nghi cơ bản, phòng này là lựa chọn lý tưởng cho những du khách muốn tận hưởng kỳ nghỉ thoải mái mà không làm trống hết ngân sách.

Trong phòng Standard, bạn sẽ được trải nghiệm không gian ấm áp và trang nhã với trang trí tinh tế. Đèn sáng tự nhiên và bố cục thông minh tạo nên một không gian lý tưởng cho việc nghỉ ngơi và thư giãn.

Với giá cả hợp lý, phòng Standard không chỉ là nơi dừng chân tuyệt vời mà còn là điểm xuất phát hoàn hảo để khám phá và trải nghiệm mọi điều tuyệt vời mà địa điểm này mang đến. Hãy để phòng Standard trở thành điểm dừng lý tưởng cho chuyến hành trình của bạn.')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (2, N'Phòng Comfort Retreat ', 3, N'stdnen1.webp', N'Mô Tả Phòng Standard    Phòng Standard là sự kết hợp hoàn hảo giữa thoải mái và tiện nghi. Với không gian rộng rãi và trang bị đầy đủ các tiện nghi cơ bản, phòng này là lựa chọn lý tưởng cho những du khách muốn tận hưởng kỳ nghỉ thoải mái mà không làm trống hết ngân sách.    Trong phòng Standard, bạn sẽ được trải nghiệm không gian ấm áp và trang nhã với trang trí tinh tế. Đèn sáng tự nhiên và bố cục thông minh tạo nên một không gian lý tưởng cho việc nghỉ ngơi và thư giãn.    Với giá cả hợp lý, phòng Standard không chỉ là nơi dừng chân tuyệt vời mà còn là điểm xuất phát hoàn hảo để khám phá và trải nghiệm mọi điều tuyệt vời mà địa điểm này mang đến. Hãy để phòng Standard trở thành điểm dừng lý tưởng cho chuyến hành trình của bạn')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (3, N'Phòng Tranquil Oasis', 3, N'stdnen2.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (4, N'Phòng Serenity', 3, N'stdnen3.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (5, N'Phòng Relaxation Haven', 3, N'stdnen4.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (6, N'Phòng Deluxe Serenade', 6, N'dlxnen.jpg', N'Phòng Deluxe tại khách sạn chúng tôi là sự lựa chọn hoàn hảo cho những du khách đang tìm kiếm không gian lưu trú sang trọng và đẳng cấp. Với diện tích rộng lớn, phòng này mang lại cảm giác thoải mái và tiện nghi đỉnh cao.

Trải qua cửa vào, du khách sẽ ngay lập tức bị cuốn hút bởi sự sang trọng và tinh tế của trang trí nội thất. Mọi chi tiết đều được chăm chút kỹ lưỡng, từ đèn sáng tạo không gian tới sự sắp xếp thông minh của nội thất.

Phòng Deluxe không chỉ đơn thuần là nơi nghỉ ngơi mà còn là không gian riêng tư lý tưởng để tận hưởng những khoảnh khắc quý giá. Với sự linh hoạt trong sắp xếp, du khách có thể tận hưởng không gian ấm áp và trang nhã mà phòng mang lại.

Với giá cả phù hợp với dịch vụ cao cấp, phòng Deluxe tại khách sạn chúng tôi hứa hẹn mang đến trải nghiệm lưu trú đặc biệt và đáng nhớ cho mọi du khách.')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (7, N'Phòng Premier Bliss', 6, N'dlxnen1.jpg', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (8, N'Phòng Elegance Enclave', 6, N'dlxnen2.jpg', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (9, N'Phòng Luxury Radiance', 6, N'dlxnen3.jpg', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (10, N'Phòng Opulent Sanctuary', 6, N'dlxnen4.jpg', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (11, N'Gia Ðình Suite Harmony', 2, N'fmlnen.jpg', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (12, N'Phòng Gia Ðình Joy', 2, N'fmlnen1.jpg', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (13, N'Phòng Gia Ðình Spacious Retreat', 2, N'fmlnen2.jpg', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (14, N'Phòng Gia Ðình Cozy Haven', 2, N'fmlnen3.jpg', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (15, N'Gia Ðình Suite Comfort', 2, N'fmlnen3.jpg', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (17, N'Suite Royal Elegance', 5, N'suinen.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (18, N'Suite Prestige Oasis', 5, N'suinen1.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (19, N'Suite Panorama Splendor', 5, N'suinen2.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (20, N'Suite Executive Tranquility', 5, N'suinen3.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (21, N'Suite Grandeur Retreat', 5, N'suinen4.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (22, N'Superior Comfort Room', 4, N'supnen.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (23, N'Premium Superior Suite', 4, N'supnen1.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (24, N'Elegant Superior Retreat', 4, N'supnen2.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (25, N'Superior Panorama View', 4, N'supnen3.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (26, N'Tranquil Superior Oasis', 6, N'supnen4.webp', NULL)
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (50, N'Phòng Vip2', 3, N'anhks1.jpeg', N'ư')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (51, N'Phòng Vip4', 3, N'anhks3.webp', N's')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (52, N'Phòng Vip5', 4, N'anhks7.jpeg', N'ss')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (55, N'vip3', 5, N'anhks6.jpeg', N'đẹp')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (57, N'Phòng Standard Classic', 9, N'anhks.jpeg', N'đẹp')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (58, N'Biệt Thự Premier Hướng Biển Giường Đôi', 12, N'bietthuhuongbien.png', N'Với diện tích 75 m², biệt thự có thiết kế sang trọng, thông minh, tích hợp đầy đủ tiện nghi cho kỳ lưu trú của bạn. Tầm nhìn hướng ra biển lãng mạn, có bể bơi riêng, biệt thự là lựa chọn lý tưởng dành cho các cặp đôi đi du lịch nghỉ dưỡng hoặc chuyến công tác 2 người.')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (59, N'Biệt Thự 2 Tầng Giường Đôi 1', 11, N'biethu.jpg', N'Với diện tích 110 m², biệt thự có thiết kế 2 tầng sang trọng, rộng rãi, tích hợp đầy đủ tiện nghi cho kỳ lưu trú của bạn. Đặc biệt có bể bơi riêng, đây là lựa chọn lý tưởng dành cho các cặp đôi đi du lịch nghỉ dưỡng hoặc chuyến công tác 2 người.')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (60, N'Biệt Thự 2 Tầng Giường Đôi 2', 11, N'biethu.jpg', N'Với diện tích 110 m², biệt thự có thiết kế 2 tầng sang trọng, rộng rãi, tích hợp đầy đủ tiện nghi cho kỳ lưu trú của bạn. Đặc biệt có bể bơi riêng, đây là lựa chọn lý tưởng dành cho các cặp đôi đi du lịch nghỉ dưỡng hoặc chuyến công tác 2 người.')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (61, N'VIP 01', 13, N'VIP.jpg', N'Phòng VIP hướng biển Nha Trang')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (62, N'VIP 02', 13, N'VIP.jpg', N'Phòng VIP dành cho thành viên VIP của khách sạn')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (63, N'Phòng Classic 301', 20, N'axcasdf.jfif', N'Phòng Classing tầng 3 - 301')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (64, N'Phòng Classic 301', 20, N'axcasdf.jfif', N'Phòng Classic tầng 3 - 302')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (65, N'Phòng Classic 303', 20, N'axcasdf.jfif', N'Phòng Classic tầng 3 - 303')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (66, N'Phòng Classic 304', 20, N'axcasdf.jfif', N'Phòng Classic tầng 3 - 304')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (67, N'Phòng Superior 01', 21, N'suite.jpg', N'Phòng Superior 01 tầng 5')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (68, N'VIP 01', 22, N'VIP.jpg', N'VIP 01 dành cho thành viên VIP')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (69, N'Family 01', 25, N'123sdfa.jpg', N'Phòng dành cho hộ gia đình')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (70, N'Family 02', 25, N'adasd.jpg', N'Phòng dành cho hộ gia đình')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (71, N'Biệt Thự 2 Tầng Giường Đôi', 26, N'biethu.jpg', N'căn biệt thự xinh đẹp nằm giữa khu rừng nhiệt đới xanh mướt, ẩn mình trong tiếng sóng biển rì rào thư thái sẽ mang đến một kỳ nghỉ tuyệt vời, đầy sảng khoái cho du khách.')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (72, N'Biệt Thự 2 Tầng Giường Đôi View Biển', 27, N'bietthuhuongbien.png', N'căn biệt thự xinh đẹp nằm giữa khu rừng nhiệt đới xanh mướt, ẩn mình trong tiếng sóng biển rì rào thư thái sẽ mang đến một kỳ nghỉ tuyệt vời, đầy sảng khoái cho du khách.')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (73, N'Amiana Dark Private', 26, N'biethu.jpg', N'Private ')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (74, N'Amiana Color Room', 26, N'biethu.jpg', N'Bạn sẽ bất ngờ với điều thú vị của khách sạn này')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (75, N'Phòng Classic 01', 14, N'pexels-photo-164595.jpeg', N'Phòng Classic 01')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (76, N'Phòng Classic 02', 14, N'pexels-photo-262048.jpeg', N'Phòng Classic 02')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (77, N'Phòng Classic 03', 14, N'pexels-photo-271624.webp', N'Phòng Classic 03')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (78, N'Phòng Superior 01', 15, N'pexels-photo-237371.jpeg', N'Phòng Superior 01')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (79, N'Phòng Superior 02', 15, N'pexels-photo-271619.webp', N'Phòng Superior 02')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (80, N'Phòng Superior 02', 15, N'pexels-photo-1579253.webp', N'Phòng Superior 02')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (81, N'Phòng Superior 03', 15, N'pexels-photo-210265.webp', N'Phòng Superior 03')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (82, N'Phòng Deluxe 01', 16, N'pexels-photo-97083.jpeg', N'Phòng Deluxe 01')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (83, N'Phòng Deluxe 02', 16, N'pexels-photo-2467285.jpeg', N'Phòng Deluxe 01')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (84, N'Phòng Deluxe 02', 16, N'pexels-photo-2029722.jpeg', N'Phòng Deluxe 02')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (85, N'Phòng Deluxe 03', 16, N'pexels-photo-271618.webp', N'Phòng Deluxe 03')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (86, N'Phòng Executive 01', 17, N'pexels-photo-271643.jpeg', N'Phòng Executive 01')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (87, N'Phòng Executive 02', 17, N'pexels-photo-1838554.webp', N'Phòng Executive 02')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (88, N'Phòng Executive 03', 17, N'pexels-photo-3659683.webp', N'Phòng Executive 03')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (89, N'Phòng Gia Đình 01', 18, N'pexels-photo-210604.webp', N'Phòng Gia Đình 01')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (90, N'Phòng Gia Đình 02', 18, N'pexels-photo-172872.webp', N'Phòng Gia Đình 02')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (91, N'Phòng Gia Đình 03', 18, N'pexels-photo-1743231.jpeg', N'Phòng Gia Đình 03')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (92, N'VIP 01', 19, N'pexels-photo-2417842.webp', N'Phòng dành cho thành viên VIP')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (93, N'VIP 02', 19, N'pexels-photo-1103808.jpeg', N'Phòng dành cho thành viên VIP')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (94, N'Phòng Classic 01', 28, N'pexels-photo-2255424.webp', N'Phòng Classic 01')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (95, N'Phòng Classic 02', 28, N'pexels-photo-5379175.webp', N'Phòng Classic 02')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (96, N'Phòng Classic 03', 28, N'pexels-photo-12003488.jpeg', N'Phòng Classic 03')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (97, N'Phòng Superior 01', 29, N'free-photo-of-anh-sang-khach-s-n-den-gi-ng.jpeg', N'Phòng Superior 01')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (98, N'Phòng Superior 02', 29, N'pexels-photo-1571450.jpeg', N'Phòng Superior 02')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (99, N'Phòng Superior 03', 29, N'pexels-photo-4058767.webp', N'Phòng Superior 03')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (100, N'Phòng Gia Đình 01', 30, N'pexels-photo-12715595.jpeg', N'Phòng Gia Đình 01')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (101, N'Phòng Gia Đình 02', 30, N'pexels-photo-7746042.webp', N'Phòng Gia Đình 02')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (102, N'Phòng Gia Đình 03', 30, N'pexels-photo-172869.jpeg', N'Phòng Gia Đình 03')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (103, N'Luxury 001', 31, N'fsdfasd.jpeg', N'Luxury 001 là phòng đặc biệt của khách sạn chúng tôi')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLP], [Anh], [MoTa]) VALUES (104, N'Luxury private', 31, N'pexels-photo-7258034.jpeg', N'No infomation')
SET IDENTITY_INSERT [dbo].[Phong] OFF
GO
SET IDENTITY_INSERT [dbo].[QuenMatKhau] ON 

INSERT [dbo].[QuenMatKhau] ([ID], [Token], [Email], [NgayTao]) VALUES (1, N'127671', N'doducviet3012@gmail.com', CAST(N'2024-05-08T22:20:06.280' AS DateTime))
INSERT [dbo].[QuenMatKhau] ([ID], [Token], [Email], [NgayTao]) VALUES (2, N'924700', N'doducviet3012@gmail.com', CAST(N'2024-05-08T22:24:28.077' AS DateTime))
INSERT [dbo].[QuenMatKhau] ([ID], [Token], [Email], [NgayTao]) VALUES (3, N'181176', N'doducviet3012@gmail.com', CAST(N'2024-05-08T22:29:17.350' AS DateTime))
INSERT [dbo].[QuenMatKhau] ([ID], [Token], [Email], [NgayTao]) VALUES (4, N'169263', N'doducviet3012@gmail.com', CAST(N'2024-05-09T08:51:04.307' AS DateTime))
INSERT [dbo].[QuenMatKhau] ([ID], [Token], [Email], [NgayTao]) VALUES (5, N'808163', N'dpham990@gmail.com', CAST(N'2024-09-28T02:43:45.953' AS DateTime))
INSERT [dbo].[QuenMatKhau] ([ID], [Token], [Email], [NgayTao]) VALUES (6, N'16981', N'dpham990@gmail.com', CAST(N'2024-09-28T03:02:21.130' AS DateTime))
INSERT [dbo].[QuenMatKhau] ([ID], [Token], [Email], [NgayTao]) VALUES (7, N'403402', N'dpham990@gmail.com', CAST(N'2024-09-28T03:19:29.513' AS DateTime))
SET IDENTITY_INSERT [dbo].[QuenMatKhau] OFF
GO
SET IDENTITY_INSERT [dbo].[SuDungThietBi] ON 

INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (9, 1, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (10, 2, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (11, 3, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (12, 4, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (13, 5, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (14, 6, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (15, 1, 4)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (16, 2, 4)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (17, 3, 4)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (18, 4, 4)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (19, 5, 4)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (20, 6, 4)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (21, 7, 4)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (22, 8, 4)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (23, 9, 4)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (34, 1, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (35, 2, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (36, 3, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (37, 4, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (38, 5, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (39, 6, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (40, 7, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (41, 8, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (42, 9, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (43, 10, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (44, 11, 6)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (65, 1, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (66, 2, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (67, 3, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (68, 4, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (69, 5, 3)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (75, 1, 2)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (76, 2, 2)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (77, 3, 2)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (78, 4, 2)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (79, 5, 2)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (80, 6, 2)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (81, 7, 2)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (82, 8, 2)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (83, 9, 2)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (84, 11, 2)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (90, 1, 5)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (91, 2, 5)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (92, 3, 5)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (93, 4, 5)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (94, 5, 5)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (95, 6, 5)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (96, 7, 5)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (97, 8, 5)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (98, 9, 5)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (99, 10, 5)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (100, 1, 11)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (101, 2, 11)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (102, 3, 11)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (103, 4, 11)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (104, 5, 11)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (105, 7, 11)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (106, 9, 11)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (107, 10, 11)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (108, 1, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (109, 2, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (110, 3, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (111, 4, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (112, 5, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (113, 6, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (114, 7, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (115, 8, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (116, 9, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (117, 10, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (118, 11, 12)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (119, 1, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (120, 2, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (121, 3, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (122, 4, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (123, 5, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (124, 6, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (125, 7, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (126, 8, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (127, 9, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (128, 10, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (129, 11, 13)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (130, 1, 14)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (131, 2, 14)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (132, 3, 14)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (133, 4, 14)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (134, 1, 15)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (135, 2, 15)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (136, 3, 15)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (137, 4, 15)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (138, 5, 15)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (139, 8, 15)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (140, 1, 16)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (141, 2, 16)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (142, 3, 16)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (143, 4, 16)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (144, 5, 16)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (145, 6, 16)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (146, 7, 16)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (147, 9, 16)
GO
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (148, 10, 16)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (149, 11, 16)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (150, 1, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (151, 2, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (152, 3, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (153, 4, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (154, 5, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (155, 6, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (156, 7, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (157, 8, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (158, 9, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (159, 10, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (160, 11, 17)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (161, 1, 18)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (162, 2, 18)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (163, 3, 18)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (164, 4, 18)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (165, 5, 18)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (166, 6, 18)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (167, 8, 18)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (168, 10, 18)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (169, 11, 18)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (170, 1, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (171, 2, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (172, 3, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (173, 4, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (174, 5, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (175, 6, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (176, 7, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (177, 8, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (178, 9, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (179, 10, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (180, 11, 19)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (181, 1, 20)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (182, 2, 20)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (183, 3, 20)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (184, 4, 20)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (185, 5, 20)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (186, 9, 20)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (187, 1, 21)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (188, 2, 21)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (189, 3, 21)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (190, 4, 21)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (191, 5, 21)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (192, 6, 21)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (193, 7, 21)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (194, 9, 21)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (195, 1, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (196, 2, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (197, 3, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (198, 4, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (199, 5, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (200, 6, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (201, 7, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (202, 8, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (203, 9, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (204, 10, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (205, 11, 22)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (206, 1, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (207, 2, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (208, 3, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (209, 4, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (210, 5, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (211, 6, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (212, 7, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (213, 8, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (214, 9, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (215, 10, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (216, 11, 23)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (217, 1, 24)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (218, 2, 24)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (219, 3, 24)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (220, 4, 24)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (221, 5, 24)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (222, 6, 24)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (223, 7, 24)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (224, 8, 24)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (225, 1, 25)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (226, 2, 25)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (227, 3, 25)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (228, 4, 25)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (229, 5, 25)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (230, 6, 25)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (231, 7, 25)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (232, 8, 25)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (233, 11, 25)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (234, 1, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (235, 2, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (236, 3, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (237, 4, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (238, 5, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (239, 6, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (240, 7, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (241, 8, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (242, 9, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (243, 10, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (244, 11, 26)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (245, 1, 27)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (246, 2, 27)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (247, 3, 27)
GO
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (248, 4, 27)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (249, 5, 27)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (250, 6, 27)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (251, 7, 27)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (252, 8, 27)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (253, 9, 27)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (254, 10, 27)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (255, 11, 27)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (256, 1, 28)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (257, 2, 28)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (258, 3, 28)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (259, 4, 28)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (260, 5, 28)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (261, 9, 28)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (262, 1, 29)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (263, 2, 29)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (264, 3, 29)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (265, 4, 29)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (266, 5, 29)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (267, 7, 29)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (268, 9, 29)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (269, 1, 30)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (270, 2, 30)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (271, 3, 30)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (272, 4, 30)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (273, 5, 30)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (274, 6, 30)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (275, 7, 30)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (276, 8, 30)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (277, 9, 30)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (278, 11, 30)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (279, 1, 31)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (280, 2, 31)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (281, 3, 31)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (282, 4, 31)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (283, 5, 31)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (284, 6, 31)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (285, 7, 31)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (286, 8, 31)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (287, 9, 31)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (288, 10, 31)
INSERT [dbo].[SuDungThietBi] ([ID], [MaTB], [MaLP]) VALUES (289, 11, 31)
SET IDENTITY_INSERT [dbo].[SuDungThietBi] OFF
GO
SET IDENTITY_INSERT [dbo].[ThietBi] ON 

INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (1, N'Wi-Fi miễn phí')
INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (2, N'Vệ sinh phòng hằng ngày')
INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (3, N'Điều hòa hai chiều')
INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (4, N'Dịch vụ phòng 24/7')
INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (5, N'Truyền hình cáp')
INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (6, N'MiniBar với đồ uống miễn phí')
INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (7, N'Bể bơi đặc biệt')
INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (8, N'Khu vui chơi cho trẻ em')
INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (9, N'Đồ nội thất cao cấp')
INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (10, N'Phòng tắm cao cấp và sang trọng')
INSERT [dbo].[ThietBi] ([MaTB], [TenTB]) VALUES (11, N'Phòng ngủ và khách riêng biệt')
SET IDENTITY_INSERT [dbo].[ThietBi] OFF
GO
SET IDENTITY_INSERT [dbo].[TinhThanh] ON 

INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (1, N'Thành phố Hà Nội', N'hanoi_nen.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (2, N'Thành phố Đà Nẵng', N'danang_nen.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (3, N'Tỉnh Khánh Hòa', N'nhatrang_nen.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (4, N'Tỉnh Quảng Ninh', N'quangninh_nen.webp')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (5, N'Thành phố Hồ Chí Minh', N'hcm_nen.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (11, N'Tỉnh Bắc Ninh', N'bacninh.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (120, N'Thành phố Hải Phòng', N'haiphong.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (121, N'Thành phố Cần Thơ', N'cantho.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (122, N'Tỉnh An Giang', N'angiang.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (123, N'Tỉnh Bà Rịa - Vũng Tàu', N'baria.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (124, N'Tỉnh Bắc Giang', N'bacgiang.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (125, N'Tỉnh Bắc Kạn', N'bankan.webp')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (126, N'Tỉnh Bạc Liêu', N'baclieu.png')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (128, N'Tỉnh Bến Tre', N'bentre.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (129, N'Tỉnh Bình Định', N'binhdinh.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (130, N'Tỉnh Bình Dương', N'binhduong.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (131, N'Tỉnh Bình Phước', N'binhphuoc.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (132, N'Tỉnh Bình Thuận', N'binhthuan.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (133, N'Tỉnh Cà Mau', N'camau.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (134, N'Tỉnh Cao Bằng', N'caobang.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (135, N'Tỉnh Đắk Lắk', N'daklak.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (136, N'Tỉnh Đắk Nông', N'daknong.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (137, N'Tỉnh Điện Biên', N'dienbien.webp')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (138, N'Tỉnh Đồng Nai', N'donglai.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (139, N'Tỉnh Đồng Tháp', N'dongthap.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (140, N'Tỉnh Gia Lai', N'gialai.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (141, N'Tỉnh Hà Giang', N'hagiang.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (142, N'Tỉnh Hà Nam', N'hanam.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (143, N'Tỉnh Hà Tĩnh', N'hatinh.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (144, N'Tỉnh Hải Dương', N'haiduong.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (145, N'Tỉnh Hậu Giang', N'haugiang.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (146, N'Tỉnh Hòa Bình', N'hoabinh.webp')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (147, N'Tỉnh Hưng Yên', N'hungyen.webp')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (148, N'Tỉnh Kiên Giang', N'kiengiang.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (149, N'Tỉnh Kon Tum', N'kontum.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (150, N'Tỉnh Lai Châu', N'laichau.webp')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (151, N'Tỉnh Lâm Đồng', N'lamdong.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (152, N'Tỉnh Lạng Sơn', N'langson.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (153, N'Tỉnh Lào Cai', N'laocai.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (154, N'Tỉnh Long An', N'longan.webp')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (155, N'Tỉnh Nam Định', N'namdinh.jpeg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (156, N'Tỉnh Nghệ An', N'nghean.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (157, N'Tỉnh Ninh Bình', N'ninhbinh.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (158, N'Tỉnh Ninh Thuận', N'ninhthuan.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (159, N'Tỉnh Phú Thọ', N'phutho.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (160, N'Tỉnh Phú Yên', N'phuyen.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (161, N'Tỉnh Quảng Bình', N'quangbinh.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (162, N'Tỉnh Quảng Nam', N'quangnam.webp')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (163, N'Tỉnh Quảng Ngãi', N'quangngai.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (164, N'Tỉnh Quảng Trị', N'quangtri.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (165, N'Tỉnh Sóc Trăng', N'soctrang.webp')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (166, N'Tỉnh Sơn La', N'sonla.webp')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (167, N'Tỉnh Tây Ninh', N'tayninh.jpeg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (168, N'Tỉnh Thái Bình', N'thaibinh.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (169, N'Tỉnh Thái Nguyên', N'thainguyen.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (170, N'Tỉnh Thanh Hóa', N'thanhhoa.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (171, N'Tỉnh Thừa Thiên Huế', N'hue.jpeg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (172, N'Tỉnh Tiền Giang', N'tiengiang.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (173, N'Tỉnh Trà Vinh', N'travinh.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (174, N'Tỉnh Tuyên Quang', N'tuyenquang.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (175, N'Tỉnh Vĩnh Long', N'vinhlong.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (176, N'Tỉnh Vĩnh Phúc', N'vinhphuc.jpg')
INSERT [dbo].[TinhThanh] ([MaTinh], [TenTinh], [Anh]) VALUES (177, N'Tỉnh Yên Bái', N'yenbai.webp')
SET IDENTITY_INSERT [dbo].[TinhThanh] OFF
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD  CONSTRAINT [FK_Blog_NhanVien] FOREIGN KEY([IDAdmin])
REFERENCES [dbo].[Admin] ([ID])
GO
ALTER TABLE [dbo].[Blog] CHECK CONSTRAINT [FK_Blog_NhanVien]
GO
ALTER TABLE [dbo].[CTAnh]  WITH CHECK ADD  CONSTRAINT [FK_CTAnh_MaPhong] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[Phong] ([MaPhong])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CTAnh] CHECK CONSTRAINT [FK_CTAnh_MaPhong]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_HoaDon] FOREIGN KEY([SoHoaDon])
REFERENCES [dbo].[HoaDon] ([SoHoaDon])
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_HoaDon]
GO
ALTER TABLE [dbo].[DatPhong]  WITH CHECK ADD  CONSTRAINT [FK_DatPhong_Phong] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[Phong] ([MaPhong])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DatPhong] CHECK CONSTRAINT [FK_DatPhong_Phong]
GO
ALTER TABLE [dbo].[GopY]  WITH CHECK ADD  CONSTRAINT [FK_GopY_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[GopY] CHECK CONSTRAINT [FK_GopY_KhachHang]
GO
ALTER TABLE [dbo].[GopY]  WITH CHECK ADD  CONSTRAINT [FK_GopY_KhachSan] FOREIGN KEY([MaKS])
REFERENCES [dbo].[KhachSan] ([MaKS])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GopY] CHECK CONSTRAINT [FK_GopY_KhachSan]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [FK_HoaDon_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [FK_HoaDon_KhachHang]
GO
ALTER TABLE [dbo].[KhachSan]  WITH CHECK ADD  CONSTRAINT [FK_KhachSan_KhachHang] FOREIGN KEY([IDNguoiTao])
REFERENCES [dbo].[KhachHang] ([MaKH])
GO
ALTER TABLE [dbo].[KhachSan] CHECK CONSTRAINT [FK_KhachSan_KhachHang]
GO
ALTER TABLE [dbo].[KhachSan]  WITH CHECK ADD  CONSTRAINT [FK_KhachSan_TinhThanh] FOREIGN KEY([MaTinh])
REFERENCES [dbo].[TinhThanh] ([MaTinh])
GO
ALTER TABLE [dbo].[KhachSan] CHECK CONSTRAINT [FK_KhachSan_TinhThanh]
GO
ALTER TABLE [dbo].[LoaiPhong]  WITH CHECK ADD  CONSTRAINT [FK_LoaiPhong_KhachSan] FOREIGN KEY([MaKS])
REFERENCES [dbo].[KhachSan] ([MaKS])
GO
ALTER TABLE [dbo].[LoaiPhong] CHECK CONSTRAINT [FK_LoaiPhong_KhachSan]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK_Phong_LoaiPhong] FOREIGN KEY([MaLP])
REFERENCES [dbo].[LoaiPhong] ([MaLP])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK_Phong_LoaiPhong]
GO
ALTER TABLE [dbo].[SuDungThietBi]  WITH CHECK ADD  CONSTRAINT [FK_SuDungThietBi_LoaiPhong] FOREIGN KEY([MaLP])
REFERENCES [dbo].[LoaiPhong] ([MaLP])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SuDungThietBi] CHECK CONSTRAINT [FK_SuDungThietBi_LoaiPhong]
GO
ALTER TABLE [dbo].[SuDungThietBi]  WITH CHECK ADD  CONSTRAINT [FK_SuDungThietBi_ThietBi] FOREIGN KEY([MaTB])
REFERENCES [dbo].[ThietBi] ([MaTB])
GO
ALTER TABLE [dbo].[SuDungThietBi] CHECK CONSTRAINT [FK_SuDungThietBi_ThietBi]
GO
USE [master]
GO
ALTER DATABASE [QLKhachSanTTTN] SET  READ_WRITE 
GO
