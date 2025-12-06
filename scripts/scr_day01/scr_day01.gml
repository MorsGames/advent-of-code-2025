global.day01 =
{
    name: "Day 1: Secret Entrance",

    parse_input: function(_raw_text)
    {
        var _lines = string_split(_raw_text, "\n");
        var _instructions = [];

        for (var i = 0; i < array_length(_lines); i++)
        {
            var _line = string_trim(_lines[i]);
            if (_line == "")
                continue;
            var _direction = (string_char_at(_line, 1) == "L") ? -1 : 1;
            var _steps = real(string_digits(_line)) * _direction;
            array_push(_instructions, _steps);
        }

        return _instructions;
    },

    solve_part1: function(_parsed)
    {
        var _dial_position = 50;
        var _zero_times = 0;

        for (var i = 0; i < array_length(_parsed); i++)
        {
            var _steps = _parsed[i];
            _dial_position = _dial_position + _steps;

            while (_dial_position >= 100)
            {
                _dial_position -= 100;
            }
            while (_dial_position < 0)
            {
                _dial_position += 100;
            }

            if (_dial_position == 0)
            {
                _zero_times++;
            }
        }
        return _zero_times;
    },

    solve_part2: function(_parsed)
    {
        var _dial_position = 50;
        var _zero_times = 0;
        
        for (var i = 0; i < array_length(_parsed); i++)
        {
            var _steps = _parsed[i];
            var _start = _dial_position;
            var _end = _dial_position + _steps;
            
            if (_steps > 0)
            {
                _zero_times += floor(_end / 100) - floor(_start / 100);
            }
            else
            {
                _zero_times += floor((_start - 1) / 100) - floor((_end - 1) / 100);
            }
            
            _dial_position = _end;
        }
        return _zero_times;
    }
};