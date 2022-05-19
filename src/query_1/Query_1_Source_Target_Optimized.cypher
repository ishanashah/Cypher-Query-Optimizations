//Query 1 Source-Target Optimized
CALL gds.graph.project(
    'myGraph',
    'Location',
    {ROAD: {orientation: 'UNDIRECTED'}},
    { relationshipProperties: 'cost' }
);

MATCH (source:Location {name: 'A'}),
	  (inter:Location {name: 'B'}),
      (target:Location {name: 'C'})
CALL gds.shortestPath.dijkstra.stream('myGraph', {
    sourceNode: source,
    targetNode: inter,
    relationshipWeightProperty: 'cost'
})
YIELD totalCost AS totalCost1
CALL gds.shortestPath.dijkstra.stream('myGraph', {
    sourceNode: inter,
    targetNode: target,
    relationshipWeightProperty: 'cost'
})
YIELD totalCost AS totalCost2
RETURN totalCost1 + totalCost2;

CALL gds.graph.drop('myGraph', false) YIELD graphName;
