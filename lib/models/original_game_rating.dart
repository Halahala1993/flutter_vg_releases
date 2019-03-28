class OriginalGameRating {
    String apiDetailUrl;
    int id;
    String name;

    OriginalGameRating({
        this.apiDetailUrl,
        this.id,
        this.name,
    });

    factory OriginalGameRating.fromJson(Map<String, dynamic> json) => new OriginalGameRating(
        apiDetailUrl: json["api_detail_url"],
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "api_detail_url": apiDetailUrl,
        "id": id,
        "name": name,
    };
}