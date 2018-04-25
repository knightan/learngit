% 弹出选择文件对话框，获得csv文件名及地址
[filename, pathname] = uigetfile({'*.csv',  'csv Files (*.csv)'},'Pick a csv file');
%判断是否选择文件
if isequal(filename,0)
   disp('User selected Cancel')
else
    filename_csv = fullfile(pathname, filename);
   disp(['User selected', filename_csv])
end

% 弹出选择文件对话框，获得txt文件名及地址
[filename, pathname] = uigetfile({'*.txt',  'para Files (*.txt)'},'Pick a para file');
%判断是否选择文件
if isequal(filename,0)
   disp('User selected Cancel')
else
    filename_txt = fullfile(pathname, filename);
   disp(['User selected', filename_txt])
end




