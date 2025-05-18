def select_data_test():
    return"""
    SELECT * FROM cliente c
    """
    
def selec_unic_user_em():
    return """ 
    SELECT 
    *
    FROM empleado e WHERE e.correo = %s and e.password = %s
    """