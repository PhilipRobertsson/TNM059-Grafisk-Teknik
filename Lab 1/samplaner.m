function ut=samplaner(in)
%% LAB1, TASK3
%% Samplar ner en bild till halva storleken i varje led
%
% Sampla ner originalbilden, in, till halva storleken i varje led genom att
% ta medelvärdet av varje 2x2 område i inbilden (in) och sparar värdet som ett pixelvärd
% i den nedsamplade bilden (ut).
% Observera att inbilden (in) är tänkt att vara normaliserad mellan 0 coh
% 1.
%% Who has done it:
%
% Author: Philip Robertsson - phiro138
% Author: Alma Linder - almli825
%
%% Syntax of the function
%      Input arguments:
%           in: the original input grayscale image of type double scaled
%               between 0 and 1
%      Output arguments:
%            ut: The down-sampled image
%
% You MUST NEVER change the first line
%
%% Basic version control (in case you need more than one attempt)
%
% Version: 1
% Date: 2023-02-01
%
% Gives a history of your submission to Lisam.
% Version and date for this function have to be updated before each
% submission to Lisam (in case you need more than one attempt)
%
%% General rules
%
% 1) Don't change the structure of the template by removing %% lines
%
% 2) Document what you are doing using comments
%
% 3) Before submitting make the code readable by using automatic indentation
%       ctrl-a / ctrl-i
%
% 4) your code should work for any given input arguments, if they are
%    fulfilling the conditions specified in the syntax of the function
%
% 5) Often you must do something else between the given commands in the
%       template
%
%% Here starts your code.
% Write the appropriate MATLAB commands right after each comment below.
%
%% Figuring out the number of rows and columns of the input image
%
% Since your code is supposed to an image of any size, you are suppsed
% to find the size of the image. Use the function size in MATLAB.
%
[rad, kolumn] = size(in(:,:)); % using the ':' gives the lengths of the rows and columns
%
%% Create counters
% Probably you might need to create two counters, if you are going to use
% two nested for loops. The counters are incremented inside the loops.
%
rad_counter = 2; % Row counter
ut = zeros(round(rad/2),round(kolumn/2)); % Creat a matrix containing only zeros based on the size of the image
kolumn_counter = 2; % Column counter
%
%% Two nested for-loops
%
rad = rad - mod(rad,2);                     % If "in" has any uneven sides mod(rad/kolumn,2) will negate 1 to make it even.
kolumn = kolumn - mod(kolumn,2);     % The missing pixels will be added back later to be calculated in a diffrent way
%
for i= 1:rad/2 % Go through half of the width of the image
    for j= 1:kolumn/2 % Go through half of the hight of the image
        % For each pixel in "ut" (which will be a fourth of the pixels from
        % "in") a mean value of each 2x2 square in "in" is saved at the
        % current location from (i,j).
        ut(i,j) = mean(in(rad_counter-1,kolumn_counter-1) + in(rad_counter,kolumn_counter-1) + in(rad_counter-1,kolumn_counter) + in(rad_counter,kolumn_counter)) /3;
        kolumn_counter = kolumn_counter * (kolumn_counter < kolumn); % If kolumn_counter is bigger than kolumn, set the value of kolumn_counter to zero, if its smaller its value will be the same
        kolumn_counter = kolumn_counter + 2; % Increase the value of kolumn_counter by 2
    end
    rad_counter = rad_counter * (rad_counter < rad); % Same as before
    rad_counter =rad_counter + 2; % Increase the value of rad_counter by 2
end

if mod(size(in(:,:)),2) % if the original picture is uneven on any side this method will be run in the end
    for i=  1:kolumn/2
        ut(i,round(kolumn/2)) = mean(in(i+1,kolumn) + in(i,kolumn) + in(i+1,kolumn-1) + in(i,kolumn-1)) / 3; % The value of "kolumn" goes between the right most column and the column left to that
    end
    for j=  1:rad/2
        ut(round(rad/2),i) =  mean(in(rad,j+1) + in(rad,j) + in(rad-1,j+1) + in(rad-1,j)) /3; % The value of "rad" goes between the bottom row and the row above that
    end
end
%
%
%% Test your code
% Notice that your code has to work for a gray scale image of any size.
% For example the image mygray (from assigment 5.1 in part 2) is 280x420 pixels. Your
% result after running this code should be a down-sampled version of this
% image, that is it should look like mygray but be of size 140x210.
% Notice that your input image (in) is supposed to be normalized between 0 and
% 1, so don't forget to do that before you call this function.
% Test your code on at least on pne image, where either the row number or
% the column number is an odd integer (for example kvarn_udda.tif). Explain how your code handle
% images whos number of rows/columns are odd: (answer here as a comment).
%
% By utilizing the mod() function we always make each image have even sides.
% If an uneven picture comes in, the last column and the last row gets removed
% before the 2x2 sampler loop. After that loop is done the last row and the
% last column gets sampled in individual loops where the column/row
% cordinate is set to a constant value and added to the output image which .