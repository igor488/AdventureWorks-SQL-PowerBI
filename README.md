AdventureWorks — Sales Analytics | SQL Server + Power BI

Projeto de análise de vendas desenvolvido com SQL Server e Power BI, utilizando a base de dados AdventureWorks para transformar dados transacionais em informações gerenciais por meio de consultas SQL, modelagem, medidas DAX e visualizações interativas.

O projeto foi desenvolvido com foco em análise de faturamento, comportamento das vendas, desempenho de produtos e evolução ao longo do tempo.

📊 Dashboard




Dashboard desenvolvido no Power BI para análise do desempenho comercial.

🎯 Objetivo

O objetivo deste projeto foi construir uma solução de Business Intelligence capaz de responder perguntas como:

Qual é o faturamento total?
Como o faturamento evoluiu ao longo dos anos?
Quais categorias geram mais receita?
Quais produtos possuem maior faturamento?
Quantos pedidos foram realizados?
Qual é a quantidade de produtos vendidos?
Qual é o ticket médio dos pedidos?
Como o desempenho atual se compara ao período anterior?

A proposta foi transformar dados relacionais em indicadores e análises que facilitam a tomada de decisão.

🛠️ Tecnologias utilizadas
Tecnologia	Utilização
SQL Server	Consulta, exploração e preparação dos dados
SQL	JOINs, agregações, filtros e análises
Power BI	Desenvolvimento do dashboard
DAX	Criação dos indicadores e métricas
GitHub	Versionamento e documentação do projeto
🗄️ Base de dados

O projeto utiliza a base AdventureWorks, disponibilizada pela Microsoft, contendo dados relacionados a vendas, produtos, clientes, categorias e outras informações do processo comercial.

As principais tabelas utilizadas na análise foram:

Sales.SalesOrderHeader
        │
        └── Sales.SalesOrderDetail
                    │
                    └── Production.Product
                                │
                                └── Production.ProductSubcategory
                                            │
                                            └── Production.ProductCategory
Relacionamentos principais
SalesOrderHeader → SalesOrderDetail
SalesOrderDetail → Product
Product → ProductSubcategory
ProductSubcategory → ProductCategory

Esses relacionamentos permitiram combinar informações de pedidos, produtos e categorias em uma única estrutura para análise.

🔎 Preparação dos dados com SQL

Foi criada uma VIEW específica para alimentar o Power BI:

CREATE VIEW vw_VendasPowerBI AS

SELECT
    h.SalesOrderID AS Pedido,
    h.OrderDate AS DataPedido,

    p.ProductID AS ProdutoID,
    p.Name AS Produto,

    ps.Name AS Subcategoria,
    pc.Name AS Categoria,

    d.OrderQty AS Quantidade,
    d.UnitPrice AS PrecoUnitario,
    d.LineTotal AS Receita

FROM Sales.SalesOrderHeader h

INNER JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID

INNER JOIN Production.Product p
    ON d.ProductID = p.ProductID

INNER JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID

INNER JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID;

A VIEW consolida as principais informações necessárias para a análise e simplifica a conexão entre o SQL Server e o Power BI.

📐 Indicadores desenvolvidos

Foram criadas medidas DAX para transformar os dados em indicadores de negócio.

Faturamento
Faturamento =
SUM(vw_VendasPowerBI[Receita])
Pedidos
Pedidos =
DISTINCTCOUNT(vw_VendasPowerBI[Pedido])
Produtos vendidos
Produtos Vendidos =
SUM(vw_VendasPowerBI[Quantidade])
Preço médio
Preco Medio =
AVERAGE(vw_VendasPowerBI[PrecoUnitario])
Ticket médio
Ticket Medio =
DIVIDE(
    [Faturamento],
    [Pedidos]
)
Faturamento do período anterior

A análise temporal também utiliza uma medida para comparar o faturamento com o ano anterior.

Crescimento percentual
Crescimento % =
VAR Atual = [Faturamento]
VAR Anterior = [Faturamento Periodo Anterior]

RETURN
    IF(
        ISBLANK(Anterior),
        BLANK(),
        DIVIDE(
            Atual - Anterior,
            Anterior
        )
    )
📈 Análises realizadas

O dashboard permite analisar:

Evolução do faturamento

Acompanhamento do faturamento ao longo do período disponível na base.

Faturamento por categoria

Comparação do desempenho entre:

Bikes
Components
Clothing
Accessories
Produtos de maior faturamento

Ranking dos principais produtos comercializados, permitindo identificar quais itens possuem maior participação na receita.

Indicadores comerciais

O dashboard apresenta indicadores de:

Faturamento
Pedidos
Produtos vendidos
Preço médio
Ticket médio
Crescimento percentual
Filtros interativos

O usuário pode explorar os dados utilizando filtros de:

Ano
Categoria
Subcategoria
📊 Principais resultados encontrados

A análise dos dados apresentou aproximadamente:

Indicador	Resultado
Pedidos	31.465
Linhas de venda	121.317
Faturamento	R$ 109,85 milhões
Período analisado	30/05/2022 – 29/06/2025
Faturamento por categoria
Categoria	Faturamento
Bikes	R$ 94,65 mi
Components	R$ 11,80 mi
Clothing	R$ 2,12 mi
Accessories	R$ 1,27 mi

A categoria Bikes representa a maior parcela do faturamento analisado.

Entre os produtos de maior faturamento estão diferentes versões da linha Mountain-200, com destaque para o Mountain-200 Black, 38.

⚠️ Observação sobre os dados

Os dados disponíveis para 2025 são parciais, com registros até 29/06/2025.

Por esse motivo, comparações entre 2025 e anos completos anteriores devem considerar essa diferença de período. Para análises de crescimento, a comparação com períodos equivalentes é mais adequada.

📁 Estrutura do projeto
AdventureWorks-SQL-PowerBI/
│
├── README.md
│
├── SQL/
│   └── consultas.sql
│
├── PowerBI/
│   └── AdventureWorks-Sales.pbix
│
└── imagens/
    └── dashboard.png
🚀 Como reproduzir o projeto
1. Banco de dados

Restaurar a base AdventureWorks no SQL Server.

2. SQL

Executar os scripts disponíveis na pasta:

SQL/

A VIEW vw_VendasPowerBI será utilizada como fonte principal dos dados.

3. Power BI

Abrir o arquivo:

PowerBI/AdventureWorks-Sales.pbix

Configurar a conexão com o SQL Server local e atualizar os dados.

📚 Conhecimentos aplicados

Durante o desenvolvimento foram aplicados conceitos de:

SQL
SELECT e WHERE
INNER JOIN
Relacionamentos entre tabelas
Aliases
GROUP BY
ORDER BY
Funções de agregação
Análise temporal
Views
Power BI
DAX
Indicadores de desempenho
Análise exploratória de dados
Visualização de dados
Business Intelligence
💡 Próximos passos

Possíveis evoluções para o projeto:

Criar uma página específica para análise de produtos
Adicionar análise de clientes
Criar indicadores de participação percentual
Expandir as análises temporais
Adicionar novos indicadores comerciais
Melhorar a análise de períodos equivalentes
Criar uma camada de documentação mais detalhada das consultas SQL
👨‍💻 Autor

Igor Gabriel da Silva

Estudante de Análise e Desenvolvimento de Sistemas, com interesse em Desenvolvimento, SQL, Dados, Power BI e Tecnologia da Informação.

GitHub