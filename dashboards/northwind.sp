dashboard "northwind" {
  title =  "Northwind Dashboard"
  connection_string = "sqlite://northwind.db"
  
  container {
    card {
      sql = <<-EOQ
        SELECT COUNT(*) AS "Category Count"
        FROM Categories;
      EOQ
      width = 3
    } 

    card {
      sql = <<-EOQ
        select
          count(*) as "Customers"
        from
          Customers
        EOQ
      width = 3
    } 
  }
  
  chart {
    title = "Inventory levels"
    width = 6
    type = "column"

    sql   = <<-EOQ
      SELECT
          ProductName,
          UnitsInStock - UnitsOnOrder AS InventoryLevel
      FROM
          Products;
    EOQ
  }
  
  chart {
    title = "Revenue per product"
    width = 6
    type = "column"

    sql   = <<-EOQ
     SELECT
          p.ProductName,
          SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) AS TotalRevenue
      FROM
          Products p
      JOIN
          [Order Details] od ON p.ProductID = od.ProductID
      GROUP BY
          p.ProductName
      ORDER BY
          TotalRevenue DESC;

    EOQ
  }
  chart {
    title = "Customers by country"
    width = 6
    type = "column"

    sql   = <<-EOQ
    SELECT
        Country,
        COUNT(CustomerID) AS CustomerCount
    FROM
        Customers
    GROUP BY
        Country
    ORDER BY
        CustomerCount DESC;


    EOQ
  }
  
  table {
    title = ""
    width = 6
    sql   = <<-EOQ
    SELECT
        r.RegionDescription,
        COUNT(e.EmployeeID) AS EmployeeCount
    FROM
        Regions r
    LEFT JOIN
        Employees e ON r.RegionID = e.Region
    GROUP BY
        r.RegionDescription
    ORDER BY
        EmployeeCount DESC;

    EOQ
  }

}
