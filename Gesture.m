
im=imread('4.1.jpg');                                                        % Reading the image
figure(1);
imshow(im); 
title('Orginal Image');
    
                                                        
    
se = strel('ball',5,5);                                                    % creates a structuring element, SE, of the type specified by shape
img = imdilate(im,se);                                                     % dilates the image
figure(2);
imshow(img);
title('Dilated image to make Surface smooth');


im1=rgb2gray(img);                                                         %rgb to gray conversion
figure(3);
imshow(im1);
title('RGB image To greylevel image');


th=graythresh(im1);                                                        %computes a global threshold that can be used to convert intensity image to binary image
im2=im2bw(im1,th);                                                         %Convert image to binary image, based on threshold value
figure(4);
imshow(im2);
title('GreyLevel to Binary');


im3=imcomplement(im2);                                                     %complements the image
figure(5);
imshow(im3);
title('Compliment of binary');

im3=imfill(im3,'holes');                                                   %fills holes in the image
figure(6);
imshow(im3);
title('Image with holes removed');

im4=bwareaopen(im3,10000);                                                 %removes all binary components less than 10000 pixels
figure(7);
imshow(im4); 
title('Removes objects less than 10000 pixels ');

figure(8);
imshow(im4);
title('Centroid is found');
s1 = regionprops(im4,'Centroid');                                          %returns measurements for the 'Centroid' for each labeled region in the label matrix L.
centroids = cat(1, s1.Centroid);                                           %To concatenate s1.Centroid into a matrix, specify dimension dim as 1.
hold(imgca,'on')                                                           %displaying the image  and superimposing the  centroids
plot(centroids(1),centroids(2),'r*') 
hold(imgca,'off')



im5=bwmorph(im4,'thin',inf);                                               %thinning the image im4
figure(9);
imshow(im5);
title('Image is made infinitly thin');


[r,c]=size(im5);
for i=1:r                                                                  %removing the portion on the left side of centroid
    for j=1:c
        if j<centroids(1)
            im5(i,j)= 0;
        end
        
    end
end
 figure(10);
 imshow(im5);
 title('Portion left to the centroid is cutoff');

 


                                                                          %calculate end points

cnt=0;
pt=0;
[g h]=size(im5);
for i=1:g    
    for j=1:h
        
            if(im5(i,j)==1)                                       
                cnt=0;
                m=i;
                n=j;
                m=m-2;
                n=n-2;
                 for x=1:3                   
                        for y=1:3
                            %disp(y)
                            if(im5(m+x,n+y)==1)
                                cnt=cnt+1;
                            end                                                    
                        
                        end
        
                 end
                 
        
                   
          if(cnt==2)                                                        %checking whether its an end point
                   pt=pt+1;
     
                  
                end
               
            end
            
             
                
    end
    
end

disp('Number of fingers=');
a=pt/2; 
disp(a)


if (a==1)
    disp('Move Forward')
end

if (a==2)
    disp('Move Backward')
end
  

if (a==3)
    disp('Move Left')
end
  

if (a==4)
    disp('Move Right')
end
  
  
  
