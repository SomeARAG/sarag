

r"""

Draw the topology of a plane real algebraic curve, i.e. the real zero set of a bivariate polynomial 
puting it in general position
 
AUTHORS:
    --  Marie-Francoise Roy, Edinah K. Gnang

"""

def getMax(L):
    """
    Starting with the list coding the topoloogy compute the maximal y-value used to obtain coordinates of the points needed for the final graph.
    
    EXAMPLES:

    ::


        sage: getMax([1])
        2
        sage: getMax([1, [2, 1], 3, [2, 2], 3, [2, 1], 1])
        4
        sage: getMax([4, [4, 3], 6, [5, 5], 6, [5, 1], 6, [4, 2], 4])     
        7
        sage: getMax([0,[1,1],2,[1,1],0])
        3

    
    AUTHORS:
    - Marie-Francoise Roy
     """
    # Definition of p
    p=0
    for idx in range(len(L)):
        if Integer(mod(idx,2)) == 0 :
            p=max(p,L[idx])
        else: 
            p=max(p,L[idx][0])
    return(p+1)

def getList_of_points(L):
    """
    Starting with the list coding the tpoloogy we obtain coordinates of the points needed for drawing the topology.


    EXAMPLES:

    ::

        sage: getList_of_points([1])
        [[(0, 1)], [(1, 1)], [(2, 1)]]
        sage: getList_of_points([1, [2, 1], 3, [2, 2], 3, [2, 1], 1])
        [[(0, 2)],
         [(1, 2)],
         [(2, 4/3), (2, 8/3)],
         [(3, 1), (3, 2), (3, 3)],
         [(4, 4/3), (4, 8/3)],
         [(5, 1), (5, 2), (5, 3)],
         [(6, 4/3), (6, 8/3)],
         [(7, 2)],
         [(8, 2)]]
        sage: getList_of_points([4, [4, 3], 6, [5, 5], 6, [5, 1], 6, [4, 2], 4])
        [[(0, 7/5), (0, 14/5), (0, 21/5), (0, 28/5)],
         [(1, 7/5), (1, 14/5), (1, 21/5), (1, 28/5)],
         [(2, 7/5), (2, 14/5), (2, 21/5), (2, 28/5)],
         [(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6)],
         [(4, 7/6), (4, 7/3), (4, 7/2), (4, 14/3), (4, 35/6)],
         [(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6)],
         [(6, 7/6), (6, 7/3), (6, 7/2), (6, 14/3), (6, 35/6)],
         [(7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6)],
         [(8, 7/5), (8, 14/5), (8, 21/5), (8, 28/5)],
         [(9, 7/5), (9, 14/5), (9, 21/5), (9, 28/5)],
         [(10, 7/5), (10, 14/5), (10, 21/5), (10, 28/5)]]
        sage: getList_of_points([0,[1,1],2,[1,1],0])
        [[], [], [(2, 3/2)], [(3, 1), (3, 2)], [(4, 3/2)], [], []]
        

    AUTHORS:
    - Marie-Francoise Roy, Edinah K. Gnang 
    """
    # Definition of p
    m=getMax(L)
    # Initialization of the list
    if L==[]:
        List_of_points=[]
    else:
        List_of_points = [[(0, (j+1)*m/(L[0]+1)) for  j in range(L[0])]] 
        for idx in range(len(L)):
            if Integer(mod(idx,2)) == 0 :
                # Initialization of the number of points
                i=L[idx]
                List_of_points.append([(idx+1, (j+1)*m/(i+1)) for  j in range(i)]) 
            else: 
                i=L[idx][0]
                List_of_points.append([(idx+1, (j+1)*m/(i+1)) for  j in range(i)]) 
        List_of_points.append([(idx+2, (j+1)*m/(L[len(L)-1]+1)) for  j in range(L[len(L)-1])]) 
    return List_of_points

def getList_of_criticalpoints(L):
    """
    Starting with the list coding the tpoloogy we obtain coordinates of the critical points needed for drawing the topology.


    EXAMPLES:

    ::

        sage: getList_of_criticalpoints([1])
        []
        sage: getList_of_criticalpoints([1, [2, 1], 3, [2, 2], 3, [2, 1], 1])
        [(2, 4/3), (4, 8/3), (6, 4/3)]
        sage: getList_of_criticalpoints([4,[4, 3], 6, [5, 5], 6, [5, 1], 6, [4, 2], 4])
        [(2, 21/5), (4, 35/6), (6, 7/6), (8, 14/5)]     
        sage: getList_of_criticalpoints([0,[1,1],2,[1,1],0])
        [(2, 3/2), (4, 3/2)]
        sage: getList_of_criticalpoints([0,[1,1],0])
        [(2,1)]

    AUTHORS:
    - Marie-Francoise Roy 
    """
    # Definition of p
    m=getMax(L)
    # Initialization of the list
    List_of_criticalpoints=[]
    if not(L==[]):
        for idx in range(len(L)):
            if Integer(mod(idx,2)) == 1 :
                i=L[idx][0]
                j=L[idx][1]
                List_of_criticalpoints.append((idx+1, j*m/(i+1))) 
    return List_of_criticalpoints

def getListLinesegments(L,M):
    """
    Starting with the list coding the topology and the list of points we obtain the list of segments constituting a graph with the same  topology as the topology of the curve

    EXAMPLES:

    ::
        sage: L=[0,[1,1],2,[1,1],0];M=getList_of_points(L);Lp = getListLinesegments(L,M); Lp
        [[(3, 1), (2, 3/2)],
         [(3, 2), (2, 3/2)],
         [(3, 1), (4, 3/2)],
         [(3, 2), (4, 3/2)]]
        sage: L=[1, [2, 1], 3, [2, 2], 3, [2, 1], 1];M=getList_of_points(L);Lp = getListLinesegments(L,M); Lp
        [[(0, 2), (1, 2)],
         [(3, 1), (2, 4/3)],
         [(3, 2), (2, 4/3)],
         [(1, 2), (2, 8/3)],
         [(3, 3), (2, 8/3)],
         [(3, 1), (4, 4/3)],
         [(5, 1), (4, 4/3)],
         [(3, 2), (4, 8/3)],
         [(3, 3), (4, 8/3)],
         [(5, 2), (4, 8/3)],
         [(5, 3), (4, 8/3)],
         [(5, 1), (6, 4/3)],
         [(5, 2), (6, 4/3)],
         [(5, 3), (6, 8/3)],
         [(7, 2), (6, 8/3)],
         [(7, 2), (8, 2)]]
        sage: L=[4, [4, 3], 6, [5, 5], 6, [5, 1], 6, [4, 2], 4];M=getList_of_points(L);Lp = getListLinesegments(L,M); Lp
        [[(0, 7/5), (1, 7/5)],
         [(0, 14/5), (1, 14/5)],
         [(0, 21/5), (1, 21/5)],
         [(0, 28/5), (1, 28/5)],
         [(1, 7/5), (2, 7/5)],
         [(3, 1), (2, 7/5)],
         [(1, 14/5), (2, 14/5)],
         [(3, 2), (2, 14/5)],
         [(1, 21/5), (2, 21/5)],
         [(3, 3), (2, 21/5)],
         [(3, 4), (2, 21/5)],
         [(3, 5), (2, 21/5)],
         [(1, 28/5), (2, 28/5)],
         [(3, 6), (2, 28/5)],
         [(3, 1), (4, 7/6)],
         [(5, 1), (4, 7/6)],
         [(3, 2), (4, 7/3)],
         [(5, 2), (4, 7/3)],
         [(3, 3), (4, 7/2)],
         [(5, 3), (4, 7/2)],
         [(3, 4), (4, 14/3)],
         [(5, 4), (4, 14/3)],
         [(3, 5), (4, 35/6)],
         [(3, 6), (4, 35/6)],
         [(5, 5), (4, 35/6)],
         [(5, 6), (4, 35/6)],
         [(5, 1), (6, 7/6)],
         [(5, 2), (6, 7/6)],
         [(7, 1), (6, 7/6)],
         [(7, 2), (6, 7/6)],
         [(5, 3), (6, 7/3)],
         [(7, 3), (6, 7/3)],
         [(5, 4), (6, 7/2)],
         [(7, 4), (6, 7/2)],
         [(5, 5), (6, 14/3)],
         [(7, 5), (6, 14/3)],
         [(5, 6), (6, 35/6)],
         [(7, 6), (6, 35/6)],
         [(7, 1), (8, 7/5)],
         [(9, 7/5), (8, 7/5)],
         [(7, 2), (8, 14/5)],
         [(7, 3), (8, 14/5)],
         [(7, 4), (8, 14/5)],
         [(9, 14/5), (8, 14/5)],
         [(7, 5), (8, 21/5)],
         [(9, 21/5), (8, 21/5)],
         [(7, 6), (8, 28/5)],
         [(9, 28/5), (8, 28/5)],
         [(9, 7/5), (10, 7/5)],
         [(9, 14/5), (10, 14/5)],
         [(9, 21/5), (10, 21/5)],
         [(9, 28/5), (10, 28/5)]]


    AUTHORS:
    - Marie-Francoise Roy
    """
    # Initialization of the list
    List_of_segments = [[M[0][i],M[1][i]] for i in range(L[0])] 
    for idx in range(len(L)):
        if Integer(mod(idx,2)) == 1 :
            l=0
            r=0
            for  i in range(L[idx][0]):
                # segments are given by pairs of points
                if i==L[idx][1]-1 :
                    for  k in range(L[idx-1]-L[idx][0]+1):
                        List_of_segments.append([M[idx][l+k],M[idx+1][i]])
                    l=l+L[idx-1]-L[idx][0]+1
                    for  k in range(L[idx+1]-L[idx][0]+1):
                        List_of_segments.append([M[idx+2][r+k],M[idx+1][i]])
                    r=r+L[idx+1]-L[idx][0]+1
                else :
                    List_of_segments.append([M[idx][l],M[idx+1][i]]) 
                    l=l+1
                    List_of_segments.append([M[idx+2][r],M[idx+1][i]])
                    r=r+1
    for i in range(L[len(L)-1]):
        List_of_segments.append([M[len(L)][i],M[len(L)+1][i]])
    return List_of_segments


def drawTopology(L):
    """
    Starting with list of line segments and critical points constructs the graphic output

    EXAMPLES:

    ::

        sage: L=[0,[1,1],0]; drawTopology(L)
        <BLANKLINE>
        sage: L=[0,[1,1],2,[1,1],0]; drawTopology(L)
        <BLANKLINE>
        sage: L=[1, [2, 1], 3, [2, 2], 3, [2, 1], 1]; drawTopology(L)
        <BLANKLINE>
        sage: L=[4, [4, 3], 6, [5, 5], 6, [5, 1], 6, [4, 2], 4]; drawTopology(L)
        <BLANKLINE>
        sage: L=[0,[1,1],0,[1,1],2]; drawTopology(L)
        <BLANKLINE>
        

    AUTHORS:
    - Marie-Francoise Roy
    """
    M=getList_of_points(L)
    Lp = getListLinesegments(L,M)
    Ls=[line(Lp[i]) for i in range(len(Lp))]
    C=getList_of_criticalpoints(L)
    Cr=[point(C[i],rgbcolor="red",size=40) for i in range(len(C))]
    if (Lp ==[] and C==[]):
        return 'empty curve'
    else:
        if not(Lp==[]): 
            Sum=Ls[0]
            for i in range(1,len(Lp)):
                Sum=Sum+Ls[i]
            for i in range(len(Cr)):
                Sum=Sum+Cr[i]
        if not(C==[]): 
            Sum=Cr[0]
            for i in range(len(Lp)):
                Sum=Sum+Ls[i]
            for i in range(1,len(Cr)):
                Sum=Sum+Cr[i]
    return show(plot(Sum),xmin=0,xmax=len(L)+1,ymin=0,ymax=getMax(L),axes=false)
