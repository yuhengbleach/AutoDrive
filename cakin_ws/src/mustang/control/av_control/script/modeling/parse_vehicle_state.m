function [ ts, xs, ys, angs, vel_xs, vel_ys, vel_angs, acc_xs, acc_ys, acc_angs ] = parse_vehicle_state( state_file )
ts = [];
xs = [];
ys = [];
angs = [];
vel_xs = [];
vel_ys = [];
vel_angs = [];
acc_xs = [];
acc_ys = [];
acc_angs = [];

f_in = fopen(state_file);
while ~feof(f_in)
    txt_line = fgetl(f_in);
    txt_datas = regexp(txt_line, ';', 'split');
    for i=1:length(txt_datas)
        txt_data = strtrim(txt_datas{i});
        txt_data_split = regexp(txt_data, '\:', 'split');
        data_name = txt_data_split{1};
        data_num = str2double(txt_data_split{2});
        if strcmp(data_name, 't')
            ts = [ts data_num];
        elseif strcmp(data_name, 'x')
            xs = [xs data_num];
        elseif strcmp(data_name, 'y')
            ys = [ys data_num];
        elseif strcmp(data_name, 'ang')
            angs = [angs data_num];
        elseif strcmp(data_name, 'vel_x')
            vel_xs = [vel_xs data_num];
        elseif strcmp(data_name, 'vel_y')
            vel_ys = [vel_ys data_num];
        elseif strcmp(data_name, 'vel_ang')
            vel_angs = [vel_angs data_num];
        elseif strcmp(data_name, 'acc_x')
            acc_xs = [acc_xs data_num];
        elseif strcmp(data_name, 'acc_y')
            acc_ys = [acc_ys data_num];
        elseif strcmp(data_name, 'acc_ang')
            acc_angs = [acc_angs data_num];
        end
    end
end
ts = ts - ts(1);
ts = ts / 1000;
end