// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_item_data(_itemname){
    switch (_itemname) {
        case "FoodTest":
            return {
                name: "FoodTest",
                type: "food",
                heal: 20
            };

        case "WeaponTest":
            return {
                name: "WeaponTest",
                type: "weapon",
                atk: 5
            };

        case "ArmorTest":
            return {
                name: "ArmorTest",
                type: "armor",
                def: 4
            };

        case "KeyTest":
            return {
                name: "KeyTest",
                type: "key"
            };
    }
    
    return undefined;
}