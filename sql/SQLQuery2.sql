USE AdventureWorks2025;
 GO 
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