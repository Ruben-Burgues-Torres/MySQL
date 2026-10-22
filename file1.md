# Ejercicio 1: Artículos y encargos

* CLIENTES (Num_Cliente, Saldo, Limite_Credito, Descuento)
* DIRECCIONES (Id_Direccion, Calle, Numero, Ciudad, Codigo_Postal, Num_Cliente)
  donde
  {Num_Cliente} referencia CLIENTES
* PEDIDOS (Num_Pedido, Fecha_Hora, Num_Cliente, Id_Direccion)
  donde
  {Num_Cliente} referencia CLIENTES
  {Id_Direccion} referencia DIRECCIONES
* ARTICULOS (Num_Articulo, Descripcion)
* FABRICAS (Num_Fabrica, Telefono, Cant_Articulos)
* LINEAS_PEDIDO (Num_Pedido + Num_Articulo, Cantidad)
  donde
  {Num_Pedido} referencia PEDIDOS
  {Num_Articulo} referencia ARTICULOS
* DISTRIBUYE (Num_Articulo + Num_Fabrica, Existencias)
  donde
  {Num_Articulo} referencia ARTICULOS
  {Num_Fabrica} referencia FABRICAS

# Ejercicio 2: Sistema de ventas

* PROVEEDORES (CIF_Proveedor, Nombre, Calle, Numero, Ciudad, Codigo_Postal, Telefono, Pagina_Web)
* CATEGORIAS (Id_Categoria, Nombre, Descripcion)
* PRODUCTOS (Id_Producto, Nombre, Precio_Actual, Stock, CIF_Proveedor, Id_Categoria)
  donde
  {CIF_Proveedor} referencia PROVEEDORES
  {Id_Categoria} referencia CATEGORIAS
* CLIENTES (CIF_Cliente, Nombre, Calle, Numero, Ciudad, Codigo_Postal)
* TELEFONOS (Numero, CIF_Cliente)
  donde
  {CIF_Cliente} referencia CLIENTES

* FACTURAS (Num_Factura, Fecha, Descuento, Importe_Final, CIF_Cliente)
  donde
  {CIF_Cliente} referencia CLIENTES
* DETALLE_VENTA (Num_Factura + Id_Producto, Precio_Venta, Cantidad, Importe_Total)
  donde
  {Num_Factura} referencia FACTURAS
  {Id_Producto} referencia PRODUCTOS

# Ejercicio 3: Red de carreteras y tramos

* CATEGORIAS (Id_Categoria, Nombre_Categoria, Titularidad, Nivel, Prefijo, Color, Señal)
* CARRETERAS (Cod_Carretera, Nombre, Tipo_Via, Acceso_Controlado, Doble_Calzada, Observaciones, Id_Categoria)
donde
  {Id_Categoria} referencia CATEGORIAS
* TRAMOS (Cod_Tramo, Km_Inicial, Km_Final, Tipo_Terreno, Entorno, Velocidad_Limite, Carriles_Por_Sentido, Observaciones, Cod_Carretera)
  donde
  {Cod_Carretera} referencia CARRETERAS
* COMUNIDADES_AUTONOMAS (Cod_CA, Nombre_CA)
* PROVINCIAS (Cod_Provincia, Nombre_Provincia, Cod_CA)
  donde
  {Cod_CA} referencia COMUNIDADES_AUTONOMAS
* PASA_POR (Cod_Tramo + Cod_Provincia, Km_Inicio_Provincia, Km_Fin_Provincia)
  donde
  {Cod_Tramo} referencia TRAMOS
  {Cod_Provincia} referencia PROVINCIAS
* EXTREMOS_TRAMO (Cod_Tramo + Tipo_Extremo)
  donde
  {Cod_Tramo} referencia TRAMOS
* CONFLUENCIAS (Id_Confluencia, Km_Confluencia, Cod_Tramo_Origen, Tipo_Extremo, Cod_Carretera, Cod_Tramo_Dest, Cod_Provincia_Dest)
  donde
  {Cod_Tramo_Origen + Tipo_Extremo} referencia EXTREMOS_TRAMO
  {Cod_Carretera} referencia CARRETERAS
  {Cod_Tramo_Dest} referencia TRAMOS
  {Cod_Provincia_Dest} referencia PROVINCIAS

# Ejercicio 4: Sistema de vuelos

* AEROPUERTOS (Cod_Aeropuerto, Nombre, Ciudad, Pais)
* MODELOS_AVION (Cod_Modelo, Capacidad)
* ADMITE (Cod_Aeropuerto + Cod_Modelo)
  donde
  {Cod_Aeropuerto} referencia AEROPUERTOS
  {Cod_Modelo} referencia MODELOS_AVION
* PROGRAMAS_VUELO (Num_Vuelo, Linea_Aerea, Cod_Aeropuerto_Origen, Cod_Aeropuerto_Destino)
  donde
  {Cod_Aeropuerto_Origen} referencia AEROPUERTOS
  {Cod_Aeropuerto_Destino} referencia AEROPUERTOS
* DIAS_PROGRAMA (Num_Vuelo + Dia_Semana)
  donde
  {Num_Vuelo} referencia PROGRAMAS_VUELO
* VUELOS (Id_Vuelo, Fecha_Vuelo, Plazas_Vacias, Num_Vuelo, Cod_Modelo)
  donde
  {Num_Vuelo} referencia PROGRAMAS_VUELO
  {Cod_Modelo} referencia MODELOS_AVION
* ESCALAS_TECNICAS (Num_Vuelo + Num_Orden, Cod_Aeropuerto)
  donde
  {Num_Vuelo} referencia PROGRAMAS_VUELO
  {Cod_Aeropuerto} referencia AEROPUERTOS
* PARADAS_EN (Id_Vuelo + Num_Vuelo + Num_Orden, Pasajeros_Suben, Pasajeros_Bajan)
  donde
  {Id_Vuelo} referencia VUELOS
  {Num_Vuelo + Num_Orden} referencia ESCALAS_TECNICAS
