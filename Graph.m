classdef Graph < handle
    properties(Access=public)
        rootNode
        nodes
        adjMatrix
    end
    methods
        function this = setRootNode(this,n)
            this.rootNode = n;
        end
        function this = addNode(this,n,h)
            this.nodes=[this.nodes n];
            n.hN=h;
        end
        
        %This method will be called to make connect two nodes
        function this = connectNode(this,startN,endN,g)
            %this.nodes
            if isempty(this.adjMatrix)==1
                s=length(this.nodes);
                this.adjMatrix=zeros(s,s);
            end
            startIndex=this.getIN(startN.label);
            endIndex=this.getIN(endN.label);
            this.adjMatrix(startIndex,endIndex)=g;
            this.adjMatrix(endIndex,startIndex)=g;
        end
        function node = getUnvisitedChildNode(this,n)
            index=this.getIN(n.label);
            j=1;
            while(j<=length(this.nodes))
                if(this.adjMatrix(index,j)>0)&&(this.nodes(j).visited==0)
                    node=this.nodes(j);
                    return;
                end
                j=j+1;
            end
            node=false;
            return
        end
        function ns = getAllUnvChildNodes(this,n)
            ns=[];
            index=this.getIN(n.label);
            for i=1:length(this.nodes)
                if(this.adjMatrix(index,i)>0&&this.nodes(i).visited==0)
                    ns=[ns this.nodes(i)];
                end
            end
        end
        function this = clearNodes(this)
            i=1;
            while(i<=length(this.nodes))
                n=this.nodes(i);
                n.visited=false;
                i=i+1;
            end
        end
        %BFS traversal of a tree is performed by the bfs() function
        function ansA = bfs(this)
            disp('breadth')
            %BFS uses Queue data structure
            q=[];
            q=this.rootNode;
            ansA=this.rootNode.label;
            this.rootNode.visited=true;
            while(isempty(q)==0)
                n=q(1);
                q=q(2:end);
                while(1)
                    child=this.getUnvisitedChildNode(n);
                    if isequal (child, false)
                        break
                    end
                    child.visited=true;
                    ansA=[ansA child.label];
                    q=[q child];
                end
            end
            %Clear visited property of nodes
            this.clearNodes();
        end
        
        
        function ansA = dfs(this)
            disp('Depth')
            %DFS uses Stack data structure
            q=[];
            q=this.rootNode;
            ansA=this.rootNode.label;
            this.rootNode.visited=true;
            while(isempty(q)==0)
                n=q(end);
                child=this.getUnvisitedChildNode(n);
                if isequal (child, false)
                    q=q(1:end-1);
                else
                    child.visited=true;
                    ansA=[ansA child.label];
                    q=[q child];
                end
                
            end
            %Clear visited property of nodes
            this.clearNodes();
            return
        end
        function ansA = greedy(this)
            disp('Greedy')
            q=[];
            cNode=this.rootNode;
            ansA=this.rootNode.label;
            this.rootNode.visited=true;
            while(cNode.hN~=0)
                childNodes=this.getAllUnvChildNodes(cNode);
                if(childNodes==false)
                    ansA='no ans';
                    break;
                end
                cNode=childNodes(1);
                for i=2:length(childNodes)
                    if cNode.hN>childNodes(i).hN
                        cNode=childNodes(i);
                    end
                end
                cNode.visited=true;
                ansA=[ansA cNode.label];
            end
            %Clear visited property of nodes
            this.clearNodes();
            return
        end
        %Sort function
        function ansA=HillClimb(this)
            disp('HillClimb')
            array=this.rootNode;%array
            this.rootNode.visited=true;
            ansA=[];
            while(1)
                cNode=array(1);%take the first element the least cost node
                ansA=[ansA cNode.label];
                if(cNode.hN==0)%check if this node is the goal == h(0)
                    ansA=['Nodes tested in order are " ' ansA ];
                    this.clearNodes();
                    return;
                else
                    array=[this.getAllUnvChildNodes(cNode) array(2:end)];
                   if(~isempty(array))
                        cNode=array(1);
                    end
                    for i=2:length(array)
                        if(cNode.hN>array(i).hN)
                            cNode=array(i);
                            array=[array(i) array(1:i-1) array(i+1:end)];
                        end
                    end
                    %choose the lowest node and put it at the start of the
                    %array
                    %replace first array node by it's unvisited children
                    for i=1:length(array)%make them visited
                        array(i).visited=true;
                    end
                end
            end
        end
        %Uniform
        function ansA = uniform(this)
            ansA=[];
            disp('Uniform')
            array=this.rootNode;
            this.rootNode.visited=true;
            cNode=array(1);
            while(1)
                ansA=[ansA cNode.label];
                if(cNode.hN==0)
                    ansA=['Nodes tested in order are " ' ansA ' With cost g(n) = ' num2str(cNode.currentGN)];
                    this.clearNodes();
                    return
                else
                    array=[this.getAllUnvChildNodes(cNode) array(2:end)];
                    %replace first array node by it's unvisited children
                    for i=1:length(array)
                        if array(i).visited==false
                            array(i).visited=true;
                            array(i).currentGN=this.adjMatrix(this.getIN(cNode.label),this.getIN(array(i).label))+cNode.currentGN;
                        end
                    end
                    if(~isempty(array))
                        cNode=array(1);
                    end
                    for i=2:length(array)
                        if(cNode.currentGN>array(i).currentGN)
                            cNode=array(i);
                            array=[array(i) array(1:i-1) array(i+1:end)];
                        end
                    end
                    %choose the lowest node
                end
            end
        end
        function i = getIN(this,c)
            i=1;
            while i<length(this.nodes)
                if c==this.nodes(i).label
                    break;
                end
                i=i+1;
            end
            return
        end
    end
end