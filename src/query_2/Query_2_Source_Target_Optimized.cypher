//Query 2 Source-Target Optimized
CALL gds.graph.project(
    'myGraph',
    'Location',
    {ROAD: {orientation: 'UNDIRECTED'}},
    { relationshipProperties: 'cost' }
);

MATCH (source:Location {name: 'A'}),
      (target:Location {name: 'B'}),
      (u)-[r:ROAD]-(v)
WHERE ID(r) = 1
CALL gds.shortestPath.dijkstra.stream('myGraph', {
    sourceNode: source,
    targetNode: u,
    relationshipWeightProperty: 'cost'
})
YIELD totalCost AS cost_s_u
CALL gds.shortestPath.dijkstra.stream('myGraph', {
    sourceNode: v,
    targetNode: target,
    relationshipWeightProperty: 'cost'
})
YIELD totalCost AS cost_v_t
RETURN r.cost + min(cost_s_u + cost_v_t);

CALL gds.graph.drop('myGraph', false) YIELD graphName;
