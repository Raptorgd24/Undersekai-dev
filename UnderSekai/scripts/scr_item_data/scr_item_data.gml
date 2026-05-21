// Los recursos de Script han cambiado para la v2.3.0 Consulta
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para más información
function scr_item_data(_itemname){
    switch (_itemname) {
        case "FoodTest":
            return {
                name: "FoodTest",
                desc: "FoodTest desc",
                type: "food",
                heal: 20
            };
			
        case "Puerro":
            return {
                name: "Puerro",
                desc: "Parece de 40 yenes.",
                type: "food",
                heal: 100
            };

        case "WeaponTest":
            return {
                name: "WeaponTest",
                desc: "WeaponTest Desc",
                type: "weapon",
                atk: 10
            };

        case "Stick":
            return {
                name: "Palo",
                desc: "Un palo endeble.",
                type: "weapon",
                atk: 1
            };

        case "Micro":
            return {
                name: "Micro",
                desc: "Un microfono roto.",
                type: "weapon",
                atk: 3
            };

        case "Bandage":
            return {
                name: "Tirita",
                desc: "Una tirita usada.",
                type: "food",
                heal: 4
            };

        case "ArmorTest":
            return {
                name: "ArmorTest",
                desc: "ArmorTest desc",
                type: "armor",
                def: 4
            };

        case "KeyTest":
            return {
                name: "KeyTest",
                desc: "KeyTes desct",
                type: "key"
            };

        case "Llave Miku":
            return {
                name: "Llave Miku",
                desc: "Llave con una forma peculiar.",
                type: "key"
            };

    }
    
    return undefined;
}