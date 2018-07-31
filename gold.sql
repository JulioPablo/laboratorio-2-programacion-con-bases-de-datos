CREATE OR REPLACE PACKAGE gold AS 
    FUNCTION Goldbach(n NUMBER) RETURN terna;
    PROCEDURE SetPrimo(n NUMBER);
    PROCEDURE Demuestre(n NUMBER);
END gold; 
/

CREATE OR REPLACE PACKAGE BODY gold AS 

FUNCTION Goldbach(n NUMBER) RETURN terna AS
        i NUMBER(10);
        iteraciones NUMBER(5) := 0;
BEGIN
       
       IF (MOD(n, 2) != 0) THEN
        RETURN terna(NULL,NULL,NULL);
       END IF;
       
       IF (n = 4) THEN
        i := 2;
       ELSE
        i := 3;
       END IF;

       WHILE (i <= n/2) LOOP 
        iteraciones := iteraciones + 1;
        IF(EsPrimo(i) AND  EsPrimo(n - i)) THEN
            RETURN terna(iteraciones,(n - i),i);
        END IF;
        i := i +2;
       END LOOP;
       
       --Goldbach estaba equivocado
       RETURN terna(iteraciones,0,0);
       
END;

PROCEDURE SetPrimo(n NUMBER) AS
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

PROCEDURE Demuestre(n NUMBER) AS
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
END gold; 
/