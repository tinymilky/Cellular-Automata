function [plaza,v,vmax]=switch_lane(plaza,v,vmax,gap,LUP,LDOWN);
    [L,W]=size(plaza);% The size of the lane
    changeL=zeros(L,W);% can turn left
    changeR=zeros(L,W);% can turn right
    % can turn left?
    for lanes=2:W-2;
        temp=find(plaza(:,lanes)==1);
        nn=length(temp); 
        for k=1:nn;
            i=temp(k);
            if(v(i,lanes)>gap(i,lanes)&LUP(i,lanes)==1&LDOWN(i,lanes)==1)
                  changeL(i,lanes)=1;
            end
        end
    end
    % can turn right?
    for lanes=3:W-1;
        temp=find(plaza(:,lanes)==1);
        nn=length(temp);
        for k=1:nn;
            i=temp(k);
            if(plaza(i,lanes-1)==0&plaza(mod(i-1-1,L)+1,lanes-1)==0&plaza(mod(i-2-1,L)+1,lanes-1)==0&plaza(mod(i,L)+1,lanes-1)==0&plaza(mod(i+1,L)+1,lanes-1)==0)
                changeR(i,lanes)=1;
            end
        end
    end
    % turn right first
    for lanes=3:W-1;
        temp=find(changeR(:,lanes)==1);
        nn=length(temp);
        for k=1:nn;
            i=temp(k);
            plaza(i,lanes-1)=1;
            v(i,lanes-1)=max(v(i,lanes)-1,1);
            vmax(i,lanes-1)=vmax(i,lanes);
            plaza(i,lanes)=0;
            v(i,lanes)=0;
            vmax(i,lanes)=0;          
            
            changeL(i,lanes)=0;
        end
    end
    % turn left
    for lanes=2:W-2
        temp=find(changeL(:,lanes)==1);
        nn=length(temp);
        for k=1:nn;
            i=temp(k);
            plaza(i,lanes+1)=1;
            v(i,lanes+1)=max(v(i,lanes)-1,1);
            vmax(i,lanes+1)=vmax(i,lanes);
            plaza(i,lanes)=0;
            v(i,lanes)=0;
            vmax(i,lanes)=0;
        end
    end
end