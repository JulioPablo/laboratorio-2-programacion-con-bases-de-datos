CREATE OR REPLACE PROCEDURE SetPrimo(n NUMBER) AS
    secuencia_textual VARCHAR2(1000);
    limite PRIMOS.VALOR%TYPE;
    i NUMBER;
    BEGIN
        
        SELECT MAX(VALOR) INTO limite FROM PRIMOS;
        
        IF limite IS NULL THEN
            limite := 2;
            INSERT INTO PRIMOS VALUES (2);
        END IF;

        
        IF (limite <= 2) THEN
            secuencia_textual :='2';
        END IF;
        
        IF (limite < 2) THEN
            INSERT INTO PRIMOS VALUES (2);
        END IF;
            
            
        FOR i IN 3..n LOOP
            IF (EsPrimo(i) AND i > limite AND i <= n ) THEN
                secuencia_textual := secuencia_textual || ',' || i;
                INSERT INTO PRIMOS VALUES (i);
            END IF;
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE(secuencia_textual);
END;
/
