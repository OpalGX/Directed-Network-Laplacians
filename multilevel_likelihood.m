function [Ln] = multilevel_likelihood(h, G, gamma)
% multilevel_likelihood  Calculate the likelihood of the Graph using the range dependent random
% graph model
%
% INPUTS
%   
% - h   Estimated trophic levels of the nodes
% - G       Graph object of the network
% - gamma   Decay parameter for the Trophic RDRG model
%
% OUTPUTS
% - Ln  Liklihood of directed pRDRG model
Nnodes = length(h); %number of nodes
Ln = 0;
A = adjacency(G);

%loop through all i and j to update the log-likelihood
for i = 1:Nnodes
    for j = 1:Nnodes
        F_ij = (h(j)-h(i)-1)^2;% trophic incoherence of edge i->j
        f_ij = 1/(1+exp(gamma*F_ij));% probability of edge i->j
        lnf = log(f_ij);% log-likelihood of edge i->j
        ln0 = log(1-f_ij);% log-likelihood of absence of edge i->j
        
        %update log-likelihood of the graph by adding up the log-liklihood of edges
        if A(i,j)==1
            Ln = Ln + lnf;
        else
            Ln = Ln + ln0;
        end
        
    end
               
end