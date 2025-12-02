var _w = display_get_gui_width();
var _h = display_get_gui_height();
var _cx = _w / 2; // Center X

draw_set_font(fnt_main);

draw_set_color(UI_BG_COLOR);
draw_rectangle(0, 0, _w, _h, false);

draw_set_color(UI_HIGHLIGHT_COLOR);
draw_rectangle(0, 0, _w, UI_HEADER_HEIGHT, false);

draw_set_color(UI_ACCENT_COLOR);
draw_rectangle(0, _h - UI_FOOTER_HEIGHT, _w, _h, false);

switch (state)
{
    case State.Menu:
        var _selection = obj_app.menu_selection;

        // Title
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(UI_TEXT_COLOR);
        draw_text_transformed(_cx, UI_Y_TITLE, "mors advent of code 2025 epic", UI_TITLE_SIZE, UI_TITLE_SIZE, 0);

        // Separator
        draw_set_color(UI_ACCENT_COLOR);
        var _sep_half_w = UI_SEPARATOR_WIDTH / 2;
        draw_rectangle(_cx - _sep_half_w, UI_Y_SEPARATOR, _cx + _sep_half_w, UI_Y_SEPARATOR + UI_SEPARATOR_HEIGHT, false);

        var _day_count = array_length(global.registry);

        var _menu_start_y = UI_Y_CONTENT_START;
        var _line_height = UI_LINE_HEIGHT;

        // Menu items
        draw_set_halign(fa_center);
        var _hl_half_w = UI_MENU_HIGHLIGHT_WIDTH / 2;

        for (var i = 0; i < _day_count; i++)
        {
            var _entry = global.registry[i];
            var _y = _menu_start_y + (i * _line_height);

            if (i == _selection)
            {
                draw_set_color(UI_ACCENT_COLOR);
                draw_rectangle(_cx - _hl_half_w, _y - UI_MENU_HIGHLIGHT_PADDING, _cx + _hl_half_w, _y + UI_MENU_HIGHLIGHT_PADDING, false);
                draw_set_color(UI_HIGHLIGHT_COLOR);
            }
            else
            {
                draw_set_color(UI_TEXT_COLOR);
            }

            draw_text_transformed(_cx, _y, _entry.name, UI_TEXT_SIZE, UI_TEXT_SIZE, 0);
        }

        // Prompts
        draw_set_color(UI_TEXT_COLOR);
        draw_set_halign(fa_center);
        draw_text_transformed(_cx, _h - UI_FOOTER_TEXT_Y, "<up>/<down>: navigate | <enter>: run | <esc>: quit", UI_TEXT_SIZE, UI_TEXT_SIZE, 0);
        break;

    case State.Running:
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(UI_HIGHLIGHT_COLOR);
        draw_text_transformed(_cx, _h / 2, "running...", UI_TEXT_SIZE, UI_TEXT_SIZE, 0);
        break;

    case State.Results:
        var _results = obj_app.results;

        // Title
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(UI_TEXT_COLOR);
        draw_text_transformed(_cx, UI_Y_TITLE,  _results.day_name, UI_TITLE_SIZE, UI_TITLE_SIZE, 0);

        // Separator
        draw_set_color(UI_ACCENT_COLOR);
        var _sep_half_w = UI_SEPARATOR_WIDTH / 2;
        draw_rectangle(_cx - _sep_half_w, UI_Y_SEPARATOR, _cx + _sep_half_w, UI_Y_SEPARATOR + UI_SEPARATOR_HEIGHT, false);

        // Results box
        var _box_w = UI_RESULTS_BOX_WIDTH;
        var _box_h = UI_RESULTS_BOX_HEIGHT;
        var _box_x = _cx - (_box_w / 2);
        var _box_y = UI_Y_CONTENT_START;

        draw_set_color(UI_ACCENT_COLOR);
        draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, false);

        // Part 1 results
        draw_set_halign(fa_center);
        var _y = _box_y + UI_SPACING;

        draw_set_color(UI_SUCCESS_COLOR);
        draw_text_transformed(_box_x + _box_w / 2, _y, "part 1:", UI_TEXT_SIZE, UI_TEXT_SIZE, 0);

        _y += UI_SPACING;
        draw_set_color(UI_TEXT_COLOR);
        draw_text_transformed(_box_x + _box_w / 2, _y, _results.part1_answer, UI_TEXT_SIZE, UI_TEXT_SIZE, 0);

        // Part 2 results
        _y += UI_SPACING * 2;

        draw_set_color(UI_SUCCESS_COLOR);
        draw_text_transformed(_box_x + _box_w / 2, _y, "part 2:", UI_TEXT_SIZE, UI_TEXT_SIZE, 0);

        _y += UI_SPACING;
        draw_set_color(UI_TEXT_COLOR);
        draw_text_transformed(_box_x + _box_w / 2, _y, _results.part2_answer, UI_TEXT_SIZE, UI_TEXT_SIZE, 0);

        // Prompts
        draw_set_halign(fa_center);
        draw_set_color(UI_TEXT_COLOR);
        draw_text_transformed(_cx, _h - UI_FOOTER_TEXT_Y, "<1>: copy part 1 | <2>: copy part 2 | <enter>: return to menu", UI_TEXT_SIZE, UI_TEXT_SIZE, 0);
        break;
}

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
