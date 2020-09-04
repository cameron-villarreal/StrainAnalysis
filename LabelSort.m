function [finalcent,Labels] = LabelSort(Mat)
%% Will create a Label function of connected componenets in given 4D matrix
%Will also find the nuclei of those connected components and sort them
%based on x vallue

%% Establish 4D matrix of labels
for p = 1:length(Mat(1,1,1,:))
    cc = bwconncomp(Mat(:,:,:,p));
    L1 = labelmatrix(cc);
    if p ==1
        Labels = L1;
    else
        Labels = cat(4,Labels,L1);
    end
end

%Will need to update this later to always take the dimension of the
%smallest component
minval = 1000;
for i1 = 1:length(Mat(1,1,1,:))
    c1 = bwconncomp(Mat(:,:,:,i1));
    if length(c1.PixelIdxList) <minval
        minval = length(c1.PixelIdxList);
    end
end
for l = 1:length(Mat(1,1,1,:))
    c = bwconncomp(Mat(:,:,:,l));
    s = regionprops3(c,'Centroid');
    cents = table2array(s);
    
%     for z = 1:length(cents)
%         if cents(:,:,z) <10
%             cents(:,:,z) = finalcent(:,:,z,l-1);
%         end
%     end
    if length(c.PixelIdxList)>minval
        if l == 1
            finalcent = cents(1:minval,:);
        end
        
        finalcent = cat(3,finalcent,cents(1:minval,:));
    else
        finalcent = cat(3,finalcent,cents);
    end
end
% soretedcent = finalcent;
%Sort the nuclei based on x value
% for q = 1:length(finalcent(1,1,:))-2
%     [~,idx] = sort(finalcent(:,1,q)); 
%     sortmat = finalcent(idx,:,q);
%         if q ==1
%             sortedcent = sortmat;
%         end
%         sortedcent = cat(3,sortedcent,sortmat);
% 
% end
end
