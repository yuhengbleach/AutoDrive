function [ ts, acc_pedals, brake_pedals, steer_angles ] = parse_control_signal( control_file )
ts = [];
acc_pedals = [];
brake_pedals = [];
steer_angles = [];

f_in = fopen(control_file);
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
        elseif strcmp(data_name, 'acc_pedal')
            acc_pedals = [acc_pedals data_num];
        elseif strcmp(data_name, 'brake_pedal')
            brake_pedals = [brake_pedals data_num];
        elseif strcmp(data_name, 'steer_angle')
            steer_angles = [steer_angles data_num];
        end
    end
end
ts = ts - ts(1);
ts = ts / 1000;
end