global.day04 =
{
    name: "Day 4: Printing Department",

    parse_input: function(_raw_text)
    {
        var _lines = string_split(_raw_text, "\n");
        var _grid = [];

        for (var i = 0; i < array_length(_lines); i++)
        {
            var _line = string_trim(_lines[i]);
            if (_line == "")
                continue;
            var _row = [];
            for (var j = 0; j < string_length(_line); j++)
            {
                var _char = string_char_at(_line, j + 1);
                array_push(_row, _char == "@");
            }

            array_push(_grid, _row);
        }

        return _grid;
    },

    solve_part1: function(_parsed)
    {
        var _rows = array_length(_parsed);
        var _total_accessible = 0;

        for (var _y = 0; _y < _rows; _y++)
        {
            var _row = _parsed[_y];
            var _cols = array_length(_row);

            for (var _x = 0; _x < _cols; _x++)
            {
                if (!_parsed[_y][_x])
                    continue;

                var _neighbors = 0;
                for (var _look_y = -1; _look_y <= 1; _look_y++)
                {
                    for (var _look_x = -1; _look_x <= 1; _look_x++)
                    {
                        if (_look_x == 0 && _look_y == 0)
                            continue;

                        var _actual_y = _y + _look_y;
                        var _actual_x = _x + _look_x;

                        if (_actual_y < 0 || _actual_y >= _rows || _actual_x < 0 || _actual_x >= _cols)
                            continue;

                        if (_parsed[_actual_y][_actual_x])
                            _neighbors++;
                    }
                }

                if (_neighbors < 4)
                    _total_accessible++;
            }
        }

        return _total_accessible;
    },

    solve_part2: function(_parsed)
    {
        var _rows = array_length(_parsed);
        var _total_removable = 0;
        var _remove_queue = [];

        while (true)
        {
            for (var _y = 0; _y < _rows; _y++)
            {
                var _row = _parsed[_y];
                var _cols = array_length(_row);

                for (var _x = 0; _x < _cols; _x++)
                {
                    if (!_parsed[_y][_x])
                        continue;

                    var _neighbors = 0;
                    for (var _look_y = -1; _look_y <= 1; _look_y++)
                    {
                        for (var _look_x = -1; _look_x <= 1; _look_x++)
                        {
                            if (_look_x == 0 && _look_y == 0)
                                continue;

                            var _actual_y = _y + _look_y;
                            var _actual_x = _x + _look_x;

                            if (_actual_y < 0 || _actual_y >= _rows || _actual_x < 0 || _actual_x >= _cols)
                                continue;

                            if (_parsed[_actual_y][_actual_x])
                                _neighbors++;
                        }
                    }

                    if (_neighbors < 4)
                    {
                        _total_removable++;
                        array_push(_remove_queue, [_y, _x]);
                    }
                }
            }

            if (array_length(_remove_queue) == 0)
                break;

            while (array_length(_remove_queue) > 0)
            {
                var _remove = array_pop(_remove_queue);
                var _y = _remove[0];
                var _x = _remove[1];
                _parsed[_y][_x] = false;
            }
        }

        return _total_removable;
    }
};