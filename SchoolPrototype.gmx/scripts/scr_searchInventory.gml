///scr_searchInventory(Inventory, desired item's object id)
var _inventory = argument0;
var _item = argument1;

var _lcache = ds_list_size(_inventory)
for (i = 0; i < _lcache; ++i)
{
    if (_inventory[| i].object_index == _item)
        return i;
}
return -1;
