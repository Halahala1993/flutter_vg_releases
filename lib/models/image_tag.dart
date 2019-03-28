class ImageTag {
    String apiDetailUrl;
    String name;
    int total;

    ImageTag({
        this.apiDetailUrl,
        this.name,
        this.total,
    });

    factory ImageTag.fromJson(Map<String, dynamic> json) => new ImageTag(
        apiDetailUrl: json["api_detail_url"],
        name: json["name"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "api_detail_url": apiDetailUrl,
        "name": name,
        "total": total,
    };
}