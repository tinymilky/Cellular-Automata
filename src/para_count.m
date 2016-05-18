function [v,gap,LUP,LDOWN]=para_count(plaza,v,vmax);
    [L,W]=size(plaza);% The size of the lane, including the boundary
    % speed up for the maximum speed
    for lanes=2:W-1;
        temp=find(plaza(:,lanes)==1); 
        for k=1:length(temp)
            i=temp(k);
            v(i,lanes)=min(v(i,lanes)+1,vmax(i,lanes));
        end
    end
    %step2: gaps betweem current car and the front one
    gap=zeros(L,W);
    for lanes=2:W-1;
        temp=find(plaza(:,lanes)==1);
        nn=length(temp);% The number of cars in this lane
        for k=1:nn;
            i=temp(k);
            if(k==nn)
                gap(i,lanes)=L-(temp(k)-temp(1)+1);% periodic boundary 
                continue;
            end
            gap(i,lanes)=temp(k+1)-temp(k)-1;
        end
    end


    %step3:计算每车左车道的前后车的距离是否在要求范围内
    LUP=zeros(L,W);
    LDOWN=zeros(L,W);
    for lanes=2:W-2;
        temp=find(plaza(:,lanes)==1);
        nn=length(temp);
        for k=1:nn;
            i=temp(k);
            LDOWN(i,lanes)=(plaza(mod(i-2,L)+1,lanes+1)==0);
            if(k==nn)
                if(sum(plaza([i:L],lanes+1))==0 & sum(plaza([1:mod(i+gap(i,lanes),L)+1],lanes+1))==0)
                    LUP(i,lanes)=1;
                end
                continue;
            end
            if(sum(plaza([i:i+gap(i,lanes)+1],lanes+1))==0)
                LUP(i,lanes)=1;
            end
        end
    end
end