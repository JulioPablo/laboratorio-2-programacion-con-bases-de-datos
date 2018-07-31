CREATE OR REPLACE FUNCTION EsPrimo(x NUMBER)
    RETURN BOOLEAN
    AS
        BEGIN
            IF (x = 2) THEN
                RETURN TRUE;
            END IF;
            
            IF (MOD(x, 2) = 0) THEN
                RETURN FALSE;
            END IF;
                
            FOR i IN 2..(x -1) LOOP
                IF (MOD(x, i) = 0) THEN
                    RETURN FALSE;
                END IF;
        END LOOP;
        RETURN TRUE;
END;
/