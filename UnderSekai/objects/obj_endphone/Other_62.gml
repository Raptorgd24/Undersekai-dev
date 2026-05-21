if (!variable_global_exists("api_pending")) exit;
if (!ds_map_exists(global.api_pending, async_load[? "id"])) exit;

var req_type = ds_map_find_value(global.api_pending, async_load[? "id"]);
ds_map_delete(global.api_pending, async_load[? "id"]);

if (req_type == "savefile") {
    api_done = true;
    fading = true;
}