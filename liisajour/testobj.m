% [filename1, pathname1] = uigetfile({'*.csv',  'csv Files (*.csv)'},'Pick a csv file');
% filename_csv = fullfile(pathname1, filename1);
filename_csv = 'C:\Users\wasun\Desktop\新建文件夹\wa01.csv';
test = lissajour(28.2, 2.19, filename_csv);
