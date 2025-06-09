
-- Vista: Usuarios Premium con Direcciones Frecuentes
CREATE OR REPLACE VIEW vw_UsuariosPremiumConFrecuencias AS
SELECT u.idUsuario, u.nombre, u.apellido, d.nombre AS nombreDireccion, d.latitud, d.longitud
FROM USUARIO u
JOIN DIRECCIONES_FRECUENTES d ON u.idUsuario = d.idUsuario
WHERE u.premium = TRUE;

-- Vista: Pagos con Detalles
CREATE OR REPLACE VIEW vw_PagosConDetalles AS
SELECT p.idPago, p.idViaje, p.costo, p.fechaPago, m.nombre AS metodoPago, v.origen, v.destino
FROM PAGOS p
JOIN METODOS_DE_PAGO m ON p.idMetodoPago = m.id
JOIN VIAJES v ON p.idViaje = v.id;

-- Vista: Consultas Frecuentes
CREATE OR REPLACE VIEW vw_ConsultasFrecuentes AS
SELECT idUsuario, destinoLatitud, destinoLongitud, COUNT(*) AS frecuencia
FROM CONSULTAS
GROUP BY idUsuario, destinoLatitud, destinoLongitud
HAVING COUNT(*) >= 5;

-- Vista: Viajes Recientes
CREATE OR REPLACE VIEW vw_ViajesRecientes AS
SELECT v.id, v.idUsuario, v.origen, v.destino, v.fecha, v.hora, v.estado
FROM VIAJES v
WHERE v.fecha >= CURRENT_DATE - INTERVAL '7 days';

-- Vista: Historial Completo del Usuario
CREATE OR REPLACE VIEW vw_HistorialCompletoUsuario AS
SELECT u.idUsuario, u.nombre, u.apellido, v.origen, v.destino, v.fecha, p.costo, c.fecha AS fechaConsulta
FROM USUARIO u
LEFT JOIN VIAJES v ON u.idUsuario = v.idUsuario
LEFT JOIN PAGOS p ON v.id = p.idViaje
LEFT JOIN CONSULTAS c ON u.idUsuario = c.idUsuario;
