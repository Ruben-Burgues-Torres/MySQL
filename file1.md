*Ejercicio 1: Artículos y encargos

CLIENTES (Num_Cliente, Saldo, Limite_Credito, Descuento)
DIRECCIONES (Id_Direccion, Calle, Numero, Ciudad, Codigo_Postal, Num_Cliente)
donde
  {Num_Cliente} referencia CLIENTES
PEDIDOS (Num_Pedido, Fecha_Hora, Num_Cliente, Id_Direccion)
donde
  {Num_Cliente} referencia CLIENTES
  {Id_Direccion} referencia DIRECCIONES
ARTICULOS (Num_Articulo, Descripcion)
FABRICAS (Num_Fabrica, Telefono, Cant_Articulos)
LINEAS_PEDIDO (Num_Pedido + Num_Articulo, Cantidad)
donde
  {Num_Pedido} referencia PEDIDOS
  {Num_Articulo} referencia ARTICULOS
DISTRIBUYE (Num_Articulo + Num_Fabrica, Existencias)
donde
  {Num_Articulo} referencia ARTICULOS
  {Num_Fabrica} referencia FABRICAS

*Ejercicio 2: Sistema de ventas

PROVEEDORES (CIF_Proveedor, Nombre, Calle, Numero, Ciudad, Codigo_Postal, Telefono, Pagina_Web)
CATEGORIAS (Id_Categoria, Nombre, Descripcion)
PRODUCTOS (Id_Producto, Nombre, Precio_Actual, Stock, CIF_Proveedor, Id_Categoria)
donde
  {CIF_Proveedor} referencia PROVEEDORES
  {Id_Categoria} referencia CATEGORIAS
CLIENTES (CIF_Cliente, Nombre, Calle, Numero, Ciudad, Codigo_Postal)
TELEFONOS (Numero, CIF_Cliente)
donde
  {CIF_Cliente} referencia CLIENTES

FACTURAS (Num_Factura, Fecha, Descuento, Importe_Final, CIF_Cliente)
donde
  {CIF_Cliente} referencia CLIENTES
DETALLE_VENTA (Num_Factura + Id_Producto, Precio_Venta, Cantidad, Importe_Total)
donde
  {Num_Factura} referencia FACTURAS
  {Id_Producto} referencia PRODUCTOS
