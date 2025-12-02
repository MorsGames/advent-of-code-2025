global.day02 =
{
    name: "Day 2: Gift Shop",

    parse_input: function(_raw_text)
    {
        var _range_strings = string_split(_raw_text, ",");
        var _ranges = [];

        for (var i = 0; i < array_length(_range_strings); i++)
        {
            var _range_string = _range_strings[i];
            var _range_array = string_split(_range_string, "-");
            var _start = real(_range_array[0]);
            var _end = real(_range_array[1]);
            array_push(_ranges, [_start, _end]);
        }

        return _ranges;
    },

    solve_part1: function(_parsed)
    {
        var _total = 0;
        for (var i = 0; i < array_length(_parsed); i++)
        {
            var _range = _parsed[i];

            for (var j = _range[0]; j <= _range[1]; j++)
            {
                var _id_string = string(j);
                var _length = string_length(_id_string);
                
                if (_length % 2 != 0)
                    continue;
                
                var _first_half = string_copy(_id_string, 1, _length / 2);
                var _second_half = string_copy(_id_string, _length / 2 + 1, _length / 2);
                
                if (_first_half == _second_half)
                {
                    _total += j;
                }
            }

        }
        return _total;
    },

    solve_part2: function(_parsed)
    {
        var _total = 0;
        for (var i = 0; i < array_length(_parsed); i++)
        {
            var _range = _parsed[i];

            for (var j = _range[0]; j <= _range[1]; j++)
            {
                var _id_string = string(j);
                var _length = string_length(_id_string);

                for (var k = 1; k <= _length / 2; k++)
                {
                    if (_length % k == 0)
                    {
                        var _pattern = string_copy(_id_string, 1, k);
                        var _reconstructed = string_repeat(_pattern, _length / k);

                        if (_reconstructed == _id_string)
                        {
                            _total += j;
                            break;
                        }
                    }
                }
            }
        }
        return _total;
    }
};