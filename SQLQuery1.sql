CREATE PROCEDURE GerarNumerosAleatorios 
    @qtdNumeros INT,
    @inicioIntervalo INT,
    @fimIntervalo INT,
    @numerosFixos NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @numeros TABLE (Numero INT);
    DECLARE @numerosGerados INT = 0;
    DECLARE @numeroAleatorio INT;

    -- Se @numerosFixos for NULL, definir como uma string vazia
    SET @numerosFixos = ISNULL(@numerosFixos, '');

    -- Se @numerosFixos n�o for fornecido, inicializar com 0
    IF @numerosFixos = ''
    BEGIN
        SET @numerosGerados = 0;
    END
    ELSE
    BEGIN
        -- Inserir n�meros fixos na tabela
        INSERT INTO @numeros
        SELECT CONVERT(INT, value) FROM STRING_SPLIT(@numerosFixos, ' ');

        SET @numerosGerados = (SELECT COUNT(*) FROM @numeros);

        -- Verificar se a quantidade de n�meros fixos � maior que a quantidade solicitada
        IF @numerosGerados > @qtdNumeros
        BEGIN
            THROW 50000, 'A quantidade de n�meros fixos � maior do que a quantidade total solicitada.', 1;
            RETURN;
        END;
    END;

    -- Gerar n�meros aleat�rios restantes
    WHILE @numerosGerados < @qtdNumeros
    BEGIN
        SET @numeroAleatorio = ROUND(((@fimIntervalo - @inicioIntervalo - 1) * RAND() + @inicioIntervalo), 0);
        IF NOT EXISTS (SELECT * FROM @numeros WHERE Numero = @numeroAleatorio)
        BEGIN
            INSERT INTO @numeros VALUES (@numeroAleatorio);
            SET @numerosGerados += 1;
        END;
    END;

    -- Selecionar e ordenar os n�meros gerados
    SELECT Numero FROM @numeros ORDER BY Numero;
END;


-- EXEC GerarNumerosAleatorios @qtdNumeros = 6, @inicioIntervalo = 1, @fimIntervalo = 40, @numerosFixos = '7 9'
