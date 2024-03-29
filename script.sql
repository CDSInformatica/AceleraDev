USE [Treinamento]
GO
/****** Object:  Table [dbo].[Editora]    Script Date: 17/06/2022 09:56:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Editora](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](20) NOT NULL,
	[Endereco] [varchar](50) NOT NULL,
	[Numero] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Livro]    Script Date: 17/06/2022 09:56:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Livro](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Nome] [varchar](30) NOT NULL,
	[preco] [decimal](6, 2) NULL,
	[Lancamento] [datetime] NULL,
	[Id_Editora] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[EditorascomJa]    Script Date: 17/06/2022 09:56:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[EditorascomJa] as (
select e.id as 'Id editora', e.Nome nomeEditora, e.Endereco EnderecoIditora, l.Nome NomeLivro, l.preco PrecoLivro from Livro as l 
left join editora as e on e.id = l.Id_Editora
where e.Nome like '%J%' and e.Numero = 15
)
GO
/****** Object:  View [dbo].[Editoras]    Script Date: 17/06/2022 09:56:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[Editoras] as (
select * from Editora
)
GO
ALTER TABLE [dbo].[Livro]  WITH CHECK ADD  CONSTRAINT [Fk_Editora] FOREIGN KEY([Id_Editora])
REFERENCES [dbo].[Editora] ([id])
GO
ALTER TABLE [dbo].[Livro] CHECK CONSTRAINT [Fk_Editora]
GO
