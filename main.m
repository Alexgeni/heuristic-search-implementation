

%Lets create nodes as given as an example in the article
nA=Node('A');
nB=Node('B');
nC= Node('C');
nD= Node('D');
nE= Node('E');
nF= Node('F');
nK=Node('k');
%Create the graph, add nodes, create edges between nodes
g= Graph();
g.addNode(nA,5);%start
g.addNode(nB,6);
g.addNode(nC,13);
g.addNode(nD,3);
g.addNode(nE,20);
g.addNode(nF,0);%goal
g.addNode(nK,10);
g.setRootNode(nA);%root node
%connect nodes
g.connectNode(nA,nB,5);
g.connectNode(nA,nC,6);
g.connectNode(nA,nD,3);

g.connectNode(nB,nE,7);

g.connectNode(nC,nF,8);

g.connectNode(nD,nE,8);
g.connectNode(nD,nK,10);

g.connectNode(nE,nF,13);

g.connectNode(nK,nF,3);
%Perform the traversal of the graph
disp(g.dfs())
disp(g.bfs())
disp(g.greedy)
disp(g.HillClimb())
disp(g.uniform())