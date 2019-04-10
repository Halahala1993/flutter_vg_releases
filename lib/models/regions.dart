class Region {
    String apiDetailUrl;
    int id;
    String name;

    Region({
        this.apiDetailUrl,
        this.id,
        this.name,
    });

    factory Region.fromJson(Map<String, dynamic> json) => new Region(
        apiDetailUrl: json["api_detail_url"] == null ? null : json["api_detail_url"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "api_detail_url": apiDetailUrl,
        "id": id,
        "name": name,
    };
}