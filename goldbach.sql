CREATE OR REPLACE FUNCTION Goldbach(n NUMBER) RETURN terna AS
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
