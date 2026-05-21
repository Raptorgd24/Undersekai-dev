function scr_has_item(_item_name)
{
    for (var i = 0; i < array_length(global.objects); i++)
    {
        if (global.objects[i] == _item_name)
        {
            return i;
        }
    }

    return -1;
}