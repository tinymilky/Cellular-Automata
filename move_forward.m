function [plaza,v,vmax]=move_forward(plaza,v,vmax);
    [L,W]=size(plaza);% The size of the lane
     % Compute values to get type of cars: turn left or stay
    gap=zeros(L,W);
    for lanes=2:W-1;
        temp=find(plaza(:,lanes)==1); 
        nn=length(temp);% The number of the cars in the lane
        for k=1:nn;
            i=temp(k);
            if(k==nn)
                gap(i,lanes)=L-(temp(k)-temp(1)+1);% periodic boundary 
                continue;
            end
            gap(i,lanes)=temp(k+1)-temp(k)-1;
        end
    end

     for lanes=2:W-1;
         temp=find(plaza(:,lanes)==1);
         nn=length(temp);
         for k=1:nn;
             i=temp(k);
             if(v(i,lanes)<=gap(i,lanes))
                pos=mod(i+v(i,lanes)-1,L)+1;
             end
             if(v(i,lanes)>gap(i,lanes))
                pos=mod(i+gap(i,lanes)-1,L)+1;
             end
             if(pos~=i)
                plaza(pos,lanes)=1;
                v(pos,lanes)=v(i,lanes);
                vmax(pos,lanes)=vmax(i,lanes);
                 plaza(i,lanes)=0;
                 v(i,lanes)=0;
                 vmax(i,lanes)=0;
             end
         end
     end

end