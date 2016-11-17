classdef Node < handle
    properties(Access=public)
        label
        visited=false
        hN
        currentGN
    end
    methods
        function this = Node(label)
            this.label=label;
            this.currentGN=0;
        end 
        function l=getLabel(this)
            l=this.label;
            return
        end
    end
end