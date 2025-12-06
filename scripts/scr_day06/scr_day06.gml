global.day06 =
{
    name: "Day 6: Trash Compactor",

    parse_input: function(_raw_text, _part)
    {
        var _problems = [];
        var _lines = string_split(_raw_text, "\n");
        var _line_count = array_length(_lines);

        switch (_part)
        {
            case 0:
                var _pieces_per_line = [];

                for (var i = 0; i < _line_count; i++)
                {
                    var _pieces = [];
                    var _rough_pieces = string_split(_lines[i], " ");
                    
                    for (var j = 0; j < array_length(_rough_pieces); j++)
                    {
                        var _piece = string_trim(_rough_pieces[j]);
                        if (_piece != "")
                            array_push(_pieces, _piece);
                    }
                    array_push(_pieces_per_line, _pieces);
                }

                var _operations = _pieces_per_line[_line_count - 1];

                for (var _col = 0; _col < array_length(_operations); _col++)
                {
                    var _numbers = [];
                    var _operation = _operations[_col];

                    for (var _row = 0; _row < _line_count - 1; _row++)
                    {
                        if (_col < array_length(_pieces_per_line[_row]))
                        {
                            var _num_str = _pieces_per_line[_row][_col];
                            array_push(_numbers, real(_num_str));
                        }
                    }

                    array_push(_problems, [_numbers, _operation]);
                }
                break;

            case 1:  
                var _get_the_damn_problem = function(_cols, _lines, _line_count)
                {
                    var _numbers = [];
                    var _operation = " ";

                    for (var i = 0; i < array_length(_cols); i++)
                    {
                        var _col = _cols[i];
                        var _digits = "";

                        for (var row = 0; row < _line_count - 1; row++)
                        {
                            var _ch = string_char_at(_lines[row], _col);
                            if (_ch != " ")
                                _digits += _ch;
                        }

                        array_push(_numbers, real(_digits));

                        if (_operation == " ")
                        {
                            _operation = string_char_at(_lines[_line_count - 1], _col);
                        }
                    }

                    return [_numbers, _operation];
                };
                
                var _width = 0;
                for (var i = 0; i < _line_count; i++)
                {
                    _width = max(_width, string_length(_lines[i]));
                }

                var _current_cols = [];

                for (var _col = _width; _col >= 1; _col--)
                {
                    var _is_separator = true;
                    for (var _row = 0; _row < _line_count; _row++)
                    {
                        if (string_char_at(_lines[_row], _col) != " ")
                        {
                            _is_separator = false;
                            break;
                        }
                    }

                    if (_is_separator)
                    {
                        var _problem = _get_the_damn_problem(_current_cols, _lines, _line_count);
                        array_push(_problems, _problem);

                        _current_cols = [];
                        continue;
                    }

                    array_push(_current_cols, _col);
                }

                var _final_problem = _get_the_damn_problem(_current_cols, _lines, _line_count);
                array_push(_problems, _final_problem);
        }

        return _problems;
    },

    solve_part1: function(_parsed)
    {
        var _problems = _parsed;
        var _total = 0;

        for (var i = 0; i < array_length(_problems); i++)
        {
            var _problem = _problems[i];
            var _numbers = _problem[0];
            var _operation = _problem[1];
            var _result = _numbers[0];
            
            for (var j = 1; j < array_length(_numbers); j++)
            {
                switch (_operation)
                {
                    case "*":
                        _result *= _numbers[j];
                        break;
                    case "+":
                        _result += _numbers[j];
                        break;
                }
            }

            _total += _result;
        }

        return _total;
    },

    solve_part2: function(_parsed)
    {
        return solve_part1(_parsed);
    }
};