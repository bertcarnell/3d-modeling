// Platonic Solids

u = 10;

// tetrahedron
polyhedron([[u, u, u],
            [u, -u, -u],
            [-u, u, -u],
            [-u, -u, u]],
           [[0, 1, 2],
            [0, 1, 3],
            [0, 2, 3],
            [1, 2, 3]]);
            
