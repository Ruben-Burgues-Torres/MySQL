EMPRESAS (id_empresa, nombre, cif)

DEPARTAMENTOS (id_departamento, nombre, es_rotativo, id_empresa)
donde
  {id_empresa} referencia EMPRESAS

EMPLEADOS (id_empleado, dni, nombre_completo, fecha_registro)

CONTRATO_EMPRESA (id_contrato, fecha_alta, fecha_baja, id_empresa, id_empleado)
donde
  {id_empresa} referencia EMPRESAS
  {id_empleado} referencia EMPLEADOS

SALARIO_HISTORICO (id_salario, precio_hora, fecha_inicio, fecha_fin, id_empleado)
donde
  {id_empleado} referencia EMPLEADOS

NOMINAS (id_nomina, anio, mes, importe_bruto, id_empresa, id_empleado)
donde
  {id_empresa} referencia EMPRESAS
  {id_empleado} referencia EMPLEADOS

AUSENCIAS (id_ausencia, tipo, fecha_inicio, fecha_fin, id_empleado)
donde
  {id_empleado} referencia EMPLEADOS

TURNOS (id_turno, nombre_turno, hora_inicio, hora_fin)

HORARIOS (id_horario, fecha, estado, id_empleado, id_departamento, id_turno)
donde
  {id_empleado} referencia EMPLEADOS
  {id_departamento} referencia DEPARTAMENTOS
  {id_turno} referencia TURNOS

FICHAJES (id_fichaje, hora_entrada, hora_salida, minutos_extra, id_empleado, id_empresa, id_horario)
donde
  {id_empleado} referencia EMPLEADOS
  {id_empresa} referencia EMPRESAS
  {id_horario} referencia HORARIOS

ZONAS (id_zona, nombre_zona, id_empresa, id_departamento)
donde
  {id_empresa} referencia EMPRESAS
  {id_departamento} referencia DEPARTAMENTOS

EXCEPCIONES_ACCESO (id_excepcion, tipo, fecha_validez, id_empleado, id_zona, id_jefe_autoriza)
donde
  {id_empleado} referencia EMPLEADOS
  {id_zona} referencia ZONAS
  {id_jefe_autoriza} referencia EMPLEADOS

ACCESOS_ZONA (id_acceso, fecha_hora, origen, permitido, id_empleado, id_zona, id_excepcion)
donde
  {id_empleado} referencia EMPLEADOS
  {id_zona} referencia ZONAS
  {id_excepcion} referencia EXCEPCIONES_ACCESO

NECESIDAD_TURNO (id_departamento + id_turno, empleados_necesarios)
donde
  {id_departamento} referencia DEPARTAMENTOS
  {id_turno} referencia TURNOS

PERMISO_DEPARTAMENTO (id_empleado + id_departamento, puede_trabajar)
donde
  {id_empleado} referencia EMPLEADOS
  {id_departamento} referencia DEPARTAMENTOS

CONTABILIZACION_ROTACION (id_empleado + id_departamento, le_corresponde, veces_realizadas)
donde
  {id_empleado} referencia EMPLEADOS
  {id_departamento} referencia DEPARTAMENTOS
