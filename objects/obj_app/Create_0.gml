enum State
{
    Menu,
    Running,
    Results
}

function Results(_day_index = -1) constructor
{
    day_index = _day_index;
    day_name = "";
    part1_answer = "";
    part2_answer = "";
}

state = State.Menu;

results = new Results();

global.registry = [];

//array_push(global.registry, global.day00);
array_push(global.registry, global.day01);
array_push(global.registry, global.day02);
array_push(global.registry, global.day03);
array_push(global.registry, global.day04);
array_push(global.registry, global.day05);
//array_push(global.registry, global.day06);
//array_push(global.registry, global.day07);
//array_push(global.registry, global.day08);
//array_push(global.registry, global.day09);
//array_push(global.registry, global.day10);
//array_push(global.registry, global.day11);
//array_push(global.registry, global.day12);

menu_selection = array_length(global.registry)-1;
running_frame_counter = 0;

for (var i = 0; i < array_length(global.registry); i++)
{
    var _day = global.registry[i];
    var _filename = "input_day" + string_replace(string_format(i+1, 2, 0), " ", "0") + ".txt";

    if (file_exists(_filename))
    {
        var _file = file_text_open_read(_filename);
        var _content = "";

        while (!file_text_eof(_file))
        {
            _content += file_text_readln(_file);
        }

        file_text_close(_file);
        _day.input = _content;
    }
    else
    {
        _day.input = "";
    }
}