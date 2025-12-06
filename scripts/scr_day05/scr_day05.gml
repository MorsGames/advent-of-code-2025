global.day05 =
{
    name: "Day 5: Cafeteria",

    parse_input: function(_raw_text)
    {
        var _lines = string_split(_raw_text, "\n");
        var _ranges = [];
        var _ids = [];
        var _is_range = true;

        for (var i = 0; i < array_length(_lines); i++)
        {
            var _line = string_trim(_lines[i]);

            if (_line == "")
            {
                if (_is_range)
                    _is_range = false;
                continue;
            }

            if (_is_range)
            {
                var _parts = string_split(_line, "-");
                var _start = real(_parts[0]);
                var _end = real(_parts[1]);

                array_push(_ranges, [_start, _end]);
            }
            else
            {
                array_push(_ids, real(_line));
            }
        }

        return [_ranges, _ids];
    },

    solve_part1: function(_parsed)
    {
        var _ranges = _parsed[0];
        var _ids = _parsed[1];
        var _fresh_count = 0;

        for (var i = 0; i < array_length(_ids); i++)
        {
            var _id = _ids[i];
            var _is_fresh = false;

            for (var j = 0; j < array_length(_ranges); j++)
            {
                var _range = _ranges[j];
                if (_id >= _range[0] && _id <= _range[1])
                {
                    _is_fresh = true;
                    break;
                }
            }

            if (_is_fresh)
                _fresh_count++;
        }

        return _fresh_count;
    },

    solve_part2: function(_parsed)
    {
        var _ranges = _parsed[0];
        
        array_sort(_ranges, function(a, b)
        {
            if (a[0] < b[0]) return -1;
            if (a[0] > b[0]) return 1;
            if (a[1] < b[1]) return -1;
            if (a[1] > b[1]) return 1;
            return 0;
        });
        
        var _fresh_count = 0;
        var _optimized_ranges = [];
        
        for (var i = 0; i < array_length(_ranges); i++)
        {
            var _range = _ranges[i];
            var _start = _range[0];
            var _end = _range[1];
            
            if (array_length(_optimized_ranges) == 0)
            {
                array_push(_optimized_ranges, [_start, _end]);
            }
            else
            {
                var _last_index = array_length(_optimized_ranges) - 1;
                var _last_end = _optimized_ranges[_last_index][1];
                
                if (_start <= _last_end + 1)
                {
                    _optimized_ranges[_last_index][1] = max(_last_end, _end);
                }
                else
                {
                    array_push(_optimized_ranges, [_start, _end]);
                }
            }
        }
        
        for (var i = 0; i < array_length(_optimized_ranges); i++)
        {
            var _range = _optimized_ranges[i];
            _fresh_count += _range[1] - _range[0] + 1;
        }
        
        return _fresh_count;
    }
};