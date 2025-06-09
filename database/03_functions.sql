
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
