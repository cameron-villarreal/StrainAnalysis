function stack4d = filereader(n,m)
%% Will load all image files and stack them
%Need to adjust for files that contain the wrong number of elements or 
%remove imporperly loaded files by hand

%% Get user input and instantiate variables
str = input('Input File Name \n:','s');
stack = uint8.empty;
stack4d = uint8.empty;

%% Load directory and files within directory
for j =n:m
myFolder = ['C:\Users\camer\Desktop\Research\Stain Analysis\' str '\' num2str(j)];
over_file = fullfile(myFolder, '*.tif');
tiffile = dir(over_file);
        %Error if file is not there
        if ~isfolder(myFolder)
          errorMessage = sprintf('Error: Folder: %s does not exist:\n', myFolder);
          uiwait(warndlg(errorMessage));
          return;
        end
        
        %Update user with progress
 fprintf(1, 'Now reading %s\n', myFolder);
    % Read all elements stored in folder
    for i = 1:length(tiffile)
      baseFileName = tiffile(i).name;
      fullFileName = fullfile(myFolder, baseFileName);

      imageArray = imread(fullFileName);

      stack(:,:,i) = imageArray;

    end
    if j ==n
        stack4d = stack;
        elseif j ~=18
            stack4d = cat(4,stack4d,stack);
        else
    end    
end