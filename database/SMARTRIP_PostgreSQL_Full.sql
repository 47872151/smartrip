-- SCHEMA DEFINITIONS

-- Tabla USUARIO
CREATE TABLE USUARIO (
    idUsuario SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fechaNacimiento DATE NOT NULL,
    genero VARCHAR(10) NOT NULL,
    email VARCHAR(50),
    telefono BIGINT,
    contrasena VARCHAR(50) NOT NULL,
    premium BOOLEAN
);

-- Tabla DIRECCIONES_FRECUENTES
CREATE TABLE DIRECCIONES_FRECUENTES (
    id SERIAL PRIMARY KEY,
    idUsuario INT NOT NULL REFERENCES USUARIO(idUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
    nombre VARCHAR(50) NOT NULL,
    latitud VARCHAR(255) NOT NULL,
    longitud VARCHAR(255) NOT NULL
);

-- Tabla METODOS_DE_PAGO
CREATE TABLE METODOS_DE_PAGO (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    url_api VARCHAR(500) NOT NULL
);

-- Tabla EMPRESA
CREATE TABLE EMPRESA (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    url_api VARCHAR(200) NOT NULL
);

-- Tabla VIAJES
CREATE TABLE VIAJES (
    id SERIAL PRIMARY KEY,
    idUsuario INT NOT NULL REFERENCES USUARIO(idUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
    origen VARCHAR(200) NOT NULL,
    destino VARCHAR(200) NOT NULL,
    fecha DATE NOT NULL,
    estado VARCHAR(50) NOT NULL,
    hora TIME NOT NULL,
    idPago INT,
    idEmpresa INT NOT NULL REFERENCES EMPRESA(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla PAGOS
CREATE TABLE PAGOS (
    idPago SERIAL PRIMARY KEY,
    idViaje INT NOT NULL REFERENCES VIAJES(id) ON DELETE CASCADE ON UPDATE CASCADE,
    costo DECIMAL(10,2) NOT NULL,
    fechaPago DATE NOT NULL,
    idMetodoPago INT NOT NULL REFERENCES METODOS_DE_PAGO(id) ON DELETE CASCADE ON UPDATE CASCADE,
    idPrecio INT NOT NULL
);

-- Tabla CONSULTAS
CREATE TABLE CONSULTAS (
    id SERIAL PRIMARY KEY,
    idUsuario INT NOT NULL REFERENCES USUARIO(idUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    origenLatitud VARCHAR(255) NOT NULL,
    origenLongitud VARCHAR(255) NOT NULL,
    destinoLatitud VARCHAR(255) NOT NULL,
    destinoLongitud VARCHAR(255) NOT NULL
);

-- Tabla PREFERENCIAS
CREATE TABLE PREFERENCIAS (
    id SERIAL PRIMARY KEY,
    idUsuario INT NOT NULL REFERENCES USUARIO(idUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
    modo_transporte_preferido VARCHAR(255) NOT NULL,
    metodoPagoPreferido VARCHAR(255) NOT NULL
);

-- Tabla PRECIOS
CREATE TABLE PRECIOS (
    id SERIAL PRIMARY KEY,
    idUsuario INT NOT NULL REFERENCES USUARIO(idUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
    idEmpresa INT NOT NULL REFERENCES EMPRESA(id) ON DELETE CASCADE ON UPDATE CASCADE,
    origenLatitud VARCHAR(255) NOT NULL,
    origenLongitud VARCHAR(255) NOT NULL,
    destinoLatitud VARCHAR(255) NOT NULL,
    destinoLongitud VARCHAR(255) NOT NULL
);

-- Tabla RESULTADOS_CONSULTA
CREATE TABLE RESULTADOS_CONSULTA (
    id SERIAL PRIMARY KEY,
    idConsulta INT NOT NULL REFERENCES CONSULTAS(id) ON DELETE CASCADE ON UPDATE CASCADE,
    idEmpresa INT NOT NULL REFERENCES EMPRESA(id) ON DELETE CASCADE ON UPDATE CASCADE,
    precio_estimado DECIMAL(18,0) NOT NULL,
    tiempo_estimado TIME NOT NULL
);


-- VIEWS DEFINITIONS

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


-- STORED PROCEDURES (AS FUNCTIONS)

-- FUNCTION: Actualizar Preferencias del Usuario
CREATE OR REPLACE FUNCTION sp_ActualizarPreferenciasUsuario(
    p_idUsuario INT,
    p_modoTransporte VARCHAR,
    p_metodoPago VARCHAR
) RETURNS VOID AS $$
BEGIN
    UPDATE PREFERENCIAS
    SET modo_transporte_preferido = p_modoTransporte,
        metodoPagoPreferido = p_metodoPago
    WHERE idUsuario = p_idUsuario;
END;
$$ LANGUAGE plpgsql;

-- FUNCTION: Eliminar Viaje
CREATE OR REPLACE FUNCTION sp_EliminarViaje(p_idViaje INT) RETURNS VOID AS $$
BEGIN
    DELETE FROM PAGOS WHERE idViaje = p_idViaje;
    DELETE FROM VIAJES WHERE id = p_idViaje;
END;
$$ LANGUAGE plpgsql;

-- FUNCTION: Obtener Recomendaciones de Viaje
CREATE OR REPLACE FUNCTION sp_ObtenerRecomendacionesViaje(p_idUsuario INT)
RETURNS TABLE(nombre VARCHAR, latitud VARCHAR, longitud VARCHAR) AS $$
BEGIN
    RETURN QUERY
    SELECT nombre, latitud, longitud
    FROM DIRECCIONES_FRECUENTES
    WHERE idUsuario = p_idUsuario
    ORDER BY (
        SELECT COUNT(*) FROM CONSULTAS
        WHERE idUsuario = p_idUsuario
          AND destinoLatitud = DIRECCIONES_FRECUENTES.latitud
          AND destinoLongitud = DIRECCIONES_FRECUENTES.longitud
    ) DESC
    LIMIT 5;
END;
$$ LANGUAGE plpgsql;

-- FUNCTION: Obtener Resumen del Usuario
CREATE OR REPLACE FUNCTION sp_ObtenerResumenUsuario(p_idUsuario INT)
RETURNS TABLE(nombre VARCHAR, apellido VARCHAR, TotalViajes INT, TotalConsultas INT, TotalFrecuentes INT) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        u.nombre, u.apellido,
        (SELECT COUNT(*) FROM VIAJES WHERE idUsuario = p_idUsuario),
        (SELECT COUNT(*) FROM CONSULTAS WHERE idUsuario = p_idUsuario),
        (SELECT COUNT(*) FROM DIRECCIONES_FRECUENTES WHERE idUsuario = p_idUsuario)
    FROM USUARIO u
    WHERE u.idUsuario = p_idUsuario;
END;
$$ LANGUAGE plpgsql;

-- FUNCTION: Toggle Premium Usuario
CREATE OR REPLACE FUNCTION sp_TogglePremiumUsuario(p_idUsuario INT) RETURNS VOID AS $$
BEGIN
    UPDATE USUARIO
    SET premium = CASE WHEN premium THEN FALSE ELSE TRUE END
    WHERE idUsuario = p_idUsuario;
END;
$$ LANGUAGE plpgsql;

-- INSERTS DE DATOS DE EJEMPLO

-- INSERTS de ejemplo para la tabla USUARIO
INSERT INTO USUARIO (nombre, apellido, fechaNacimiento, genero, email, telefono, contrasena, premium)
VALUES 
('Juan', 'Pérez', '1990-05-10', 'Masculino', 'juan.perez@mail.com', 1123456789, 'clave123', TRUE),
('María', 'González', '1985-09-23', 'Femenino', 'maria.gonzalez@mail.com', 1134567890, 'segura456', FALSE),
('Carlos', 'Ramírez', '1978-12-01', 'Masculino', 'carlos.ramirez@mail.com', 1145678901, 'clave789', TRUE);

-- INSERTS de ejemplo para la tabla METODOS_DE_PAGO
INSERT INTO METODOS_DE_PAGO (nombre, url_api)
VALUES 
('MercadoPago', 'https://api.mercadopago.com'),
('PayPal', 'https://api.paypal.com');

-- INSERTS de ejemplo para la tabla EMPRESA
INSERT INTO EMPRESA (nombre, url_api)
VALUES 
('Cabify', 'https://api.cabify.com'),
('Uber', 'https://api.uber.com');

-- INSERTS de ejemplo para la tabla DIRECCIONES_FRECUENTES
INSERT INTO DIRECCIONES_FRECUENTES (idUsuario, nombre, latitud, longitud)
VALUES 
(1, 'Casa', '-34.6037', '-58.3816'),
(1, 'Trabajo', '-34.6090', '-58.3922'),
(2, 'Universidad', '-34.6158', '-58.4333');

-- INSERTS de ejemplo para la tabla VIAJES
INSERT INTO VIAJES (idUsuario, origen, destino, fecha, estado, hora, idEmpresa)
VALUES
(1, 'Casa', 'Trabajo', '2025-06-01', 'Finalizado', '08:30:00', 1),
(2, 'Universidad', 'Casa', '2025-06-03', 'Finalizado', '17:45:00', 2);

-- INSERTS de ejemplo para la tabla PAGOS
INSERT INTO PAGOS (idViaje, costo, fechaPago, idMetodoPago, idPrecio)
VALUES
(1, 1500.00, '2025-06-01', 1, 1),
(2, 1200.00, '2025-06-03', 2, 2);

-- INSERTS de ejemplo para la tabla CONSULTAS
INSERT INTO CONSULTAS (idUsuario, fecha, hora, origenLatitud, origenLongitud, destinoLatitud, destinoLongitud)
VALUES 
(1, '2025-05-20', '10:00:00', '-34.6037', '-58.3816', '-34.6090', '-58.3922'),
(1, '2025-05-21', '10:00:00', '-34.6037', '-58.3816', '-34.6090', '-58.3922'),
(2, '2025-05-22', '18:00:00', '-34.6158', '-58.4333', '-34.6037', '-58.3816');

-- INSERTS de ejemplo para la tabla PREFERENCIAS
INSERT INTO PREFERENCIAS (idUsuario, modo_transporte_preferido, metodoPagoPreferido)
VALUES 
(1, 'Auto', 'MercadoPago'),
(2, 'Moto', 'PayPal');

-- INSERTS de ejemplo para la tabla PRECIOS
INSERT INTO PRECIOS (idUsuario, idEmpresa, origenLatitud, origenLongitud, destinoLatitud, destinoLongitud)
VALUES
(1, 1, '-34.6037', '-58.3816', '-34.6090', '-58.3922'),
(2, 2, '-34.6158', '-58.4333', '-34.6037', '-58.3816');

-- INSERTS de ejemplo para la tabla RESULTADOS_CONSULTA
INSERT INTO RESULTADOS_CONSULTA (idConsulta, idEmpresa, precio_estimado, tiempo_estimado)
VALUES
(1, 1, 1500, '00:20:00'),
(2, 2, 1200, '00:25:00');
