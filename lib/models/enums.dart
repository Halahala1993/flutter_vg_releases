
class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}


enum ImageTags { ALL_IMAGES, ALL_IMAGES_VIRTUAL_REALITY, ALL_IMAGES_BOX_ART, ALL_IMAGES_COVER_ART }

final imageTagsValues = new EnumValues({
    "All Images": ImageTags.ALL_IMAGES,
    "All Images,Box Art": ImageTags.ALL_IMAGES_BOX_ART,
    "All Images,Cover Art": ImageTags.ALL_IMAGES_COVER_ART,
    "All Images,Virtual Reality": ImageTags.ALL_IMAGES_VIRTUAL_REALITY
});

// enum Abbreviation { PC, XONE, PS4, NSW}
enum Abbreviation { PC, XONE, PS4, NSW, IPHN, ANDR, MAC, LIN, IPAD, ARC, PSNV, THE_3_DS, VITA, APTV, XBOX }

final abbreviationValues = new EnumValues({
    "ANDR": Abbreviation.ANDR,
    "APTV": Abbreviation.APTV,
    "ARC": Abbreviation.ARC,
    "IPAD": Abbreviation.IPAD,
    "IPHN": Abbreviation.IPHN,
    "LIN": Abbreviation.LIN,
    "MAC": Abbreviation.MAC,
    "NSW": Abbreviation.NSW,
    "PC": Abbreviation.PC,
    "PS4": Abbreviation.PS4,
    "PSNV": Abbreviation.PSNV,
    "3DS": Abbreviation.THE_3_DS,
    "VITA": Abbreviation.VITA,
    "XBOX": Abbreviation.XBOX,
    "XONE": Abbreviation.XONE
});


enum Name { PC, XBOX_ONE, PLAY_STATION_4, NINTENDO_SWITCH, I_PHONE, ANDROID, MAC, LINUX, I_PAD, ARCADE, PLAY_STATION_NETWORK_VITA, NINTENDO_3_DS, PLAY_STATION_VITA, APPLE_TV, XBOX }

final nameValues = new EnumValues({
    "Android": Name.ANDROID,
    "Apple TV": Name.APPLE_TV,
    "Arcade": Name.ARCADE,
    "iPad": Name.I_PAD,
    "iPhone": Name.I_PHONE,
    "Linux": Name.LINUX,
    "Mac": Name.MAC,
    "Nintendo 3DS": Name.NINTENDO_3_DS,
    "Nintendo Switch": Name.NINTENDO_SWITCH,
    "PC": Name.PC,
    "PlayStation 4": Name.PLAY_STATION_4,
    "PlayStation Network (Vita)": Name.PLAY_STATION_NETWORK_VITA,
    "PlayStation Vita": Name.PLAY_STATION_VITA,
    "Xbox": Name.XBOX,
    "Xbox One": Name.XBOX_ONE
});

enum Categories {VIDEOS, IMAGES, SIMILAR_GAMES, CHARACTERS}

//final categoryValues = new EnumValues({
//   "Videos" : Categories.VIDEOS,
//   "Images" : Categories.IMAGES,
//   "Similar Games" : Categories.SIMILAR_GAMES,
//   "Characters" : Categories.CHARACTERS,
//});

final Map<Categories, String> categoryValues = ({
    Categories.VIDEOS : "Videos",
    Categories.IMAGES : "Images",
    Categories.SIMILAR_GAMES : "Similar Games",
    Categories.CHARACTERS : "Characters",
});