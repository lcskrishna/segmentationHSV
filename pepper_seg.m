clear all;
close all;
clc;

N= input('Please enter the value of N:');

%%% Reading the Given original Image.
img= imread('peppers.jpg');
figure;
imshow(img);

%%% Convert to HSV.
img_hsv= rgb2hsv(img);

 %%% Initializations.
 colors={'Red', 'Green','Yellow','Orange'} ;
 hue_mean= [0 0 0 0];

%%% Taking input coordinates by clicking on the image and finding the mean of the clicked hue values.
for i=1:length(colors)
   hue_points=[];
   title(['Click the following color:',colors(i)]);
   [Y,X]= ginput(N);
   
   for j=1:N
       hue_points(j)= img_hsv(uint16(X(j)),uint16(Y(j)),1);
   end
   
   hue_mean(i)= mean(hue_points(:))
end

%%% Sorting the Mean values.
sorted_hue= sort(hue_mean)

%%%% Determining the Range values.
range1 = (sorted_hue(1)+ sorted_hue(2))/2
range2 = (sorted_hue(2)+ sorted_hue(3))/2
range3 = (sorted_hue(3)+ sorted_hue(4))/2


[x,y,z]= size(img_hsv);

%%%%% Classification of the pixels and finding the mean RGB values of the
%%%%% pixel groups.
pepperclassficiation(1:x,1:y,1:z)=uint8(0);
final_image(1:x,1:y,1:z)=uint8(0);

s_r1=0;s_r2=0;s_r3=0;s_r4=0;
s_g1=0;s_g2=0;s_g3=0;s_g4=0;
s_b1=0;s_b2=0;s_b3=0;s_b4=0;
count1=0;count2=0;count3=0;count4=0;
for i=1:x
    for j=1:y
        h= img_hsv(i,j,1);
        for k=1:z
            if(h>0 & h<range1)
                pepperclassficiation(i,j,k)=0;
                s_r1= s_r1+double(img(i,j,1));
                s_g1= s_g1+ double(img(i,j,2));
                s_b1= s_b1+ double(img(i,j,3));
                count1= count1+1;
            elseif(h>=range1 & h< range2)
                pepperclassficiation(i,j,k)=1;
                s_r2= s_r2+double(img(i,j,1));
                s_g2= s_g2+ double(img(i,j,2));
                s_b2= s_b2+ double(img(i,j,3));
                count2= count2+1;
            elseif(h>=range2 & h< range3)
                pepperclassficiation(i,j,k)=2;
                s_r3= s_r3+double(img(i,j,1));
                s_g3= s_g3+ double(img(i,j,2));
                s_b3= s_b3+ double(img(i,j,3));
                count3= count3+1;
            else
                pepperclassficiation(i,j,k)=3;
                s_r4= s_r4+double(img(i,j,1));
                s_g4= s_g4+ double(img(i,j,2));
                s_b4= s_b4+ double(img(i,j,3));
                count4= count4+1;
            end
        end
    end
end

%%% Mean RGB values of pixel group 1
mean_r1=floor(s_r1/count1);
mean_g1=floor(s_g1/count1);
mean_b1=floor(s_b1/count1);

%%% Mean RGB values of pixel group 2
mean_r2=floor(s_r2/count2);
mean_g2=floor(s_g2/count2);
mean_b2=floor(s_b2/count2);

%%% Mean RGB values of pixel group 3
mean_r3=floor(s_r3/count3);
mean_g3=floor(s_g3/count3);
mean_b3=floor(s_b3/count3);

%%% Mean RGB values of pixel group 4
mean_r4=floor(s_r4/count4);
mean_g4=floor(s_g4/count4);
mean_b4=floor(s_b4/count4);

%%%%%% Visualizing the pixel groups into a final image with mean values.

for i=1:x
    for j=1:y
        for k=1:z
            if(pepperclassficiation(i,j,k)==0)
                if(k==1)
                    final_image(i,j,k)= mean_r1;
                elseif(k==2)
                    final_image(i,j,k)= mean_g1;
                else
                    final_image(i,j,k)= mean_b1;
                end
            elseif(pepperclassficiation(i,j,k)==1)
                if(k==1)
                    final_image(i,j,k)= mean_r2;
                elseif(k==2)
                    final_image(i,j,k)= mean_g2;
                else
                    final_image(i,j,k)= mean_b2;
                end
            elseif(pepperclassficiation(i,j,k)==2)
                if(k==1)
                    final_image(i,j,k)= mean_r3;
                elseif(k==2)
                    final_image(i,j,k)= mean_g3;
                else
                    final_image(i,j,k)= mean_b3;
                end
            else
                if(k==1)
                    final_image(i,j,k)= mean_r4;
                elseif(k==2)
                    final_image(i,j,k)= mean_g4;
                else
                    final_image(i,j,k)= mean_b4;
                end
            end
        end
    end
end
                    
figure;
imshow(final_image)
title('Segmented Output Image');