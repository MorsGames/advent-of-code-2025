global.day03 =
{
    name: "Day 3: Lobby",

    parse_input: function(_raw_text)
    {
        var _lines = string_split(_raw_text, "\n");
        var _banks = [];

        for (var i = 0; i < array_length(_lines); i++)
        {
            var _line = string_trim(_lines[i]);
            if (_line == "")
                continue;
            var _bank = [];
            for (var j = 0; j < string_length(_line); j++)
            {
                var _char = string_char_at(_line, j + 1);
                array_push(_bank, real(_char));
            }
            array_push(_banks, _bank);
        }

        return _banks;
    },

    solve_part1: function(_parsed)
    {
        var _total_jolts = 0;

        for (var i = 0; i < array_length(_parsed); i++)
        {
            var _bank = _parsed[i];
            var _max_jolts = 0;
            
            for (var j = 0; j < array_length(_bank); j++)
            {
                for (var k = j + 1; k < array_length(_bank); k++)
                {
                    var _jolts = real(string(_bank[j]) + string(_bank[k]));
                    if (_jolts > _max_jolts)
                    {
                        _max_jolts = _jolts;
                    }
                }
            }

            _total_jolts += _max_jolts;
        }
        
        return _total_jolts;
    },

    solve_part2: function(_parsed)
    {
        var _count = 12;
        var _total_jolts = 0;

        for (var i = 0; i < array_length(_parsed); i++)
        {
            var _bank = _parsed[i];
            var _len = array_length(_bank);
            var _pos = 0;
            var _max_jolts = "";
            
            for (var n = 0; n < _count; n++)
            {
                var _jolt = 0;
                var _jolt_pos = _pos;

                for (var j = _pos; j < _len - _count + n + 1; j++)
                {
                    if (_bank[j] > _jolt)
                    {
                        _jolt = _bank[j];
                        _jolt_pos = j;
                    }
                }

                _max_jolts += string(_jolt);
                _pos = _jolt_pos + 1;
            }

            _total_jolts += real(_max_jolts);
        }

        return _total_jolts;
    }
};