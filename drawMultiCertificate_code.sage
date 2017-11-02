

r"""

Draw the subdivision of the unit simplex for which the polynomial is visibly positive
 
AUTHORS:
    --  Marie-Francoise Roy, Dima Pasechnik



"""

def getSimplices(C):
    """
    Starting with the list giving the certificates of positivity extract the list of relevant simplices
    
    EXAMPLES:

    ::


        sage: getSimplices([[[[0, 0], [1/2, 1/2], [0, 1]], [5, 4, 11, 13/4, 17/2, 26]],
 [[[0, 0], [1/2, 0], [1/2, 1/2]], [5, 1, 4, 1, 1, 13/4]],
 [[[1/2, 0], [3/4, 1/4], [1/2, 1/2]], [1, 1, 1, 17/16, 5/8, 13/4]],
 [[[1/2, 0], [1, 0], [3/4, 1/4]], [1, 1, 1, 5, 3/2, 17/16]]])
        [[[0, 0], [1/2, 1/2], [0, 1]], [[[0, 0], [1/2, 0], [1/2, 1/2]], [[[1/2, 0], [3/4, 1/4], [1/2, 1/2]],  [[[1/2, 0], [3/4, 1/4], [1/2, 1/2]]
      
    
    AUTHORS:
    - Marie-Francoise Roy
     """
    # Definition of S
    S = [C[j][0] for  j in range(len(C))] 
    return(S)



def drawMultiCertificate(C):
    """
    Starting with list of line segments constructs the graphic output

    EXAMPLES:

    ::

        sage: C=[[[[0, 0], [1/2, 1/2], [0, 1]], [5, 4, 11, 13/4, 17/2, 26]],
 [[[0, 0], [1/2, 0], [1/2, 1/2]], [5, 1, 4, 1, 1, 13/4]],
 [[[1/2, 0], [3/4, 1/4], [1/2, 1/2]], [1, 1, 1, 17/16, 5/8, 13/4]],
 [[[1/2, 0], [1, 0], [3/4, 1/4]], [1, 1, 1, 5, 3/2, 17/16]]]; drawMultiCertificate(S)
       

    AUTHORS:
    - Marie-Francoise Roy
    """
    S=getSimplices(C)
    Sum = sum(polygon2d(s,rgbcolor=(randrange(100)/100,randrange(100)/100,randrange(100)/100)) for s in S)
    return Sum
