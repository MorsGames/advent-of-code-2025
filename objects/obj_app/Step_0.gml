switch (state)
{
    case State.Menu:
        var day_count = array_length(global.registry);
        
        if (day_count > 0)
        {
            if (keyboard_check_pressed(vk_up))
            {
                menu_selection--;
                if (menu_selection < 0)
                {
                    menu_selection = day_count - 1;
                }
            }
            
            if (keyboard_check_pressed(vk_down))
            {
                menu_selection++;
                if (menu_selection >= day_count)
                {
                    menu_selection = 0;
                }
            }
            
            if (keyboard_check_pressed(vk_enter))
            {
                state = State.Running;
            }
        }

        if (keyboard_check_pressed(vk_escape))
        {
            game_end();
        }
        break;
        
    case State.Running:
        running_frame_counter++;
        if (running_frame_counter >= 1)
        {
            var _index = menu_selection;
            results = new Results(_index);

            var _solution = global.registry[_index];
            if (_solution == undefined)
            {
                return results;
            }
        
            results.day_name = _solution.name;

            var _answer1 = _solution.solve_part1(_solution.parse_input(_solution.input, 0));
            results.part1_answer = string(_answer1);
        
            var _answer2 = _solution.solve_part2(_solution.parse_input(_solution.input, 1));
            results.part2_answer = string(_answer2);

            running_frame_counter = 0;

            state = State.Results;
        }
        break;
        
    case State.Results:
        if (keyboard_check_pressed(vk_enter))
        {
            state = State.Menu;
        }
        if (keyboard_check_pressed(ord("1")))
        {
            clipboard_set_text(results.part1_answer);
        }
        if (keyboard_check_pressed(ord("2")))
        {
            clipboard_set_text(results.part2_answer);
        }
        break;
}

