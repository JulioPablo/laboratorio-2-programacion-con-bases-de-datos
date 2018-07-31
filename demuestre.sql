CREATE OR REPLACE PROCEDURE Demuestre(n NUMBER) AS
    tern terna;
    cardinalidad NUMBER;
    i NUMBER;
    BEGIN
        

            IF MOD(n, 2) = 0 AND n > 2 THEN
                tern := Goldbach(n);
                DBMS_OUTPUT.PUT_LINE('Buscando Goldbach de ' || n);
                DBMS_OUTPUT.PUT_LINE('Goldbach = ' || n || ' Iteraciones: ' || tern.iteracion || ' Primo1: ' || tern.primo1 || ' Primo2: ' || tern.primo2);
            ELSIF MOD(n, 2) = 0 AND n < 2 THEN 
                DBMS_OUTPUT.PUT_LINE('Nada que buscar de ' || n);
            ELSIF MOD(n, 2) != 0 AND EsPrimo(n) THEN
                DBMS_OUTPUT.PUT_LINE('Buscando cardinalidad de ' || n);
                SetPrimo(n);
                SELECT COUNT(VALOR) INTO cardinalidad FROM PRIMOS WHERE VALOR <= n;
                DBMS_OUTPUT.PUT_LINE('Cardinalidad de: ' || n || ' = ' || cardinalidad);
            ELSIF MOD(n, 2) != 0 THEN
                DBMS_OUTPUT.PUT_LINE('Buscando dos multiplos que producen ' || n);
                FOR i in 2..n LOOP
                    IF(MOD(n, i) = 0) THEN 
                        DBMS_OUTPUT.PUT_LINE(i || ' * ' || n/i || ' = ' || n);
                    RETURN;
                    END IF;
                END LOOP;
            ELSE 
                DBMS_OUTPUT.PUT_LINE('Algo terrible esta ocurriendo...');
            END IF;
    
    END;
    /