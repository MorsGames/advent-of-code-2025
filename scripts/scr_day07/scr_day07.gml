global.day07 =
{
    name: "Day 7: Laboratories",

    parse_input: function(_raw_text, _part)
    {
        var _grid = [];
        var _start_x = -1;
        var _start_y = -1;
        var _max_width = 0;

        var _lines = string_split(_raw_text, "\n");

        for (var _line_index = 0; _line_index < array_length(_lines); _line_index++)
        {
            var _line = string_trim(_lines[_line_index]);
            if (_line == "")
                continue;

            var _row = [];
            var _row_y = array_length(_grid);
            var _row_width = string_length(_line);
            _max_width = max(_max_width, _row_width);

            for (var _x = 0; _x < _row_width; _x++)
            {
                var _char = string_char_at(_line, _x + 1);

                switch (_char)
                {
                    case "S":
                        _start_x = _x;
                        _start_y = _row_y;
                        array_push(_row, false);
                        break;

                    case "^":
                        array_push(_row, true);
                        break;

                    default:
                        array_push(_row, false);
                        break;
                }
            }

            array_push(_grid, _row);
        }

        return {
            start_x: _start_x,
            start_y: _start_y,
            grid: _grid,
            width: _max_width,
            height: array_length(_grid)
        };
    },

    solve_part1: function(_parsed)
    {
        var _grid = _parsed.grid;
        var _height = _parsed.height;
        var _lasers = [{ x: _parsed.start_x, y: _parsed.start_y }];
        var _total_splits = 0;
        
        while (array_length(_lasers) > 0)
        {
            var _pending_lasers = [];
            
            for (var _i = 0; _i < array_length(_lasers); _i++)
            {
                var _laser = _lasers[_i];

                var _x = _laser.x;
                var _next_y = _laser.y + 1;

                if (_next_y >= _height)
                    continue;

                if (_grid[_next_y][_x])
                {
                    _total_splits++;

                    var _left_x = _x - 1;
                    var _right_x = _x + 1;

                    array_push(_pending_lasers, { x: _left_x, y: _next_y });
                    array_push(_pending_lasers, { x: _right_x, y: _next_y });
                }
                else
                {
                    array_push(_pending_lasers, { x: _x, y: _next_y });
                }
            }

            var _unique_lasers = [];
            for (var _i = 0; _i < array_length(_pending_lasers); _i++)
            {
                var _laser = _pending_lasers[_i];
                var _is_duplicate = false;
                
                for (var _j = 0; _j < array_length(_unique_lasers); _j++)
                {
                    if (_unique_lasers[_j].x == _laser.x && _unique_lasers[_j].y == _laser.y)
                    {
                        _is_duplicate = true;
                        break;
                    }
                }
                
                if (!_is_duplicate)
                {
                    array_push(_unique_lasers, _laser);
                }
            }
            
            _lasers = _unique_lasers;
        }

        return _total_splits;
    },

    solve_part2: function(_parsed)
    {
        var _grid = _parsed.grid;
        var _height = _parsed.height;
        var _lasers = [{ x: _parsed.start_x, y: _parsed.start_y, timelines: 1 }];
        var _timeline_count = 0;
        
        while (array_length(_lasers) > 0)
        {
            var _pending_lasers = [];
            
            for (var _i = 0; _i < array_length(_lasers); _i++)
            {
                var _laser = _lasers[_i];

                var _x = _laser.x;
                var _next_y = _laser.y + 1;

                if (_next_y >= _height)
                {
                    _timeline_count += _laser.timelines;
                    continue;
                }

                if (_grid[_next_y][_x])
                {
                    var _left_x = _x - 1;
                    var _right_x = _x + 1;

                    array_push(_pending_lasers, { x: _left_x, y: _next_y, timelines: _laser.timelines });
                    array_push(_pending_lasers, { x: _right_x, y: _next_y, timelines: _laser.timelines });
                }
                else
                {
                    array_push(_pending_lasers, { x: _x, y: _next_y, timelines: _laser.timelines });
                }
            }

            var _unique_lasers = [];
            for (var _i = 0; _i < array_length(_pending_lasers); _i++)
            {
                var _laser = _pending_lasers[_i];
                var _is_duplicate = false;
                
                for (var _j = 0; _j < array_length(_unique_lasers); _j++)
                {
                    if (_unique_lasers[_j].x == _laser.x && _unique_lasers[_j].y == _laser.y)
                    {
                        _unique_lasers[_j].timelines += _laser.timelines;
                        _is_duplicate = true;
                        break;
                    }
                }
                
                if (!_is_duplicate)
                {
                    array_push(_unique_lasers, _laser);
                }
            }
            
            _lasers = _unique_lasers;
        }

        return _timeline_count;
    }
};