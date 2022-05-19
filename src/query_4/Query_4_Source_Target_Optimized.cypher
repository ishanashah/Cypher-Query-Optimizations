//Query 4 Source-Target Optimized
CALL gds.graph.project(
    'myGraph',
    'Location',
    {ROAD: {orientation: 'UNDIRECTED'}},
    { relationshipProperties: 'cost' }
);

MATCH (source:Location {name: 'A'}),
      (target:Location {name: 'B'}),
      (u)-[r:ROAD {color: 'RED'}]-(v)
CALL gds.allShortestPaths.dijkstra.stream('myGraph', {
    sourceNode: source,
    relationshipWeightProperty: 'cost'
})
YIELD targetNode AS t1, totalCost as totalCost1
CALL gds.allShortestPaths.dijkstra.stream('myGraph', {
    sourceNode: target,
    relationshipWeightProperty: 'cost'
})
YIELD targetNode AS t2, totalCost as totalCost2
WHERE gds.util.asNode(t1) = u AND gds.util.asNode(t2) = v
RETURN min(totalCost1 + r.cost + totalCost2);

CALL gds.graph.drop('myGraph', false) YIELD graphName;
