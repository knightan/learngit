% ����ѡ���ļ��Ի��򣬻��csv�ļ�������ַ
[filename, pathname] = uigetfile({'*.csv',  'csv Files (*.csv)'},'Pick a csv file');
%�ж��Ƿ�ѡ���ļ�
if isequal(filename,0)
   disp('User selected Cancel')
else
    filename_csv = fullfile(pathname, filename);
   disp(['User selected', filename_csv])
end

% ����ѡ���ļ��Ի��򣬻��txt�ļ�������ַ
[filename, pathname] = uigetfile({'*.txt',  'para Files (*.txt)'},'Pick a para file');
%�ж��Ƿ�ѡ���ļ�
if isequal(filename,0)
   disp('User selected Cancel')
else
    filename_txt = fullfile(pathname, filename);
   disp(['User selected', filename_txt])
end




