function p= find_burst_duration(data,amplitude_min,amplitude_non)

nor=[];
for j =1:length(data(1,:))
    if data(1,j)<=amplitude_min
        nor=[nor;[j data(1,j) 0]];
    else
        nor=[nor;[j data(1,j) 1]];
    end
end

%to find where the first whole burst start
for i=2:length(nor(:,1))
    if nor(i-1,3)==1 && nor(i,3)==0
        start=i;
        break
    end
end

%to find where the last whole burst end
for i=(length(nor(:,1))-1):(-1):1
    if nor(i+1,3)==0 &&nor(i,3)==1
        end_Last=i;
        break
    end
end

burst=[];
for i =start:(end_Last-1)
    if nor(i+1,3)==1 && nor(i,3)==0
        burst=[burst;[nor(start,1) nor(i+1,1)]];
    end
    if nor(i+1,3)==0 && nor(i,3)==1
       start=i+1;
    end
end

end_=[];
for i=2:length(burst(:,1))
    end_=[end_;burst(i,1)-1];
end
end_=[end_;nor(end_Last,1)];
burst=[burst end_];


%filtered non EMG signals by elevating duration 
burst_filtered=[];
for i=1:length(burst(:,1))
    duration= burst(i,3)-burst(i,2);
    if duration >= amplitude_non
        burst_filtered=[burst_filtered; burst(i,:)];
    end
    
p=burst_filtered;
end