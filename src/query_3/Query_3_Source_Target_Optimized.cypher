//Query 3 Source-Target Optimized
CALL gds.graph.project(
    'myGraph',
    'Location',
    {ROAD: {orientation: 'UNDIRECTED'}},
    { relationshipProperties: 'cost' }
);

MATCH (source:Location {name: 'A'}),
      (inter:Location {color: 'RED'}),
      (target:Location {name: 'C'})
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
WHERE gds.util.asNode(t1) = inter AND gds.util.asNode(t2) = inter
RETURN min(totalCost1 + totalCost2);

CALL gds.graph.drop('myGraph', false) YIELD graphName;
