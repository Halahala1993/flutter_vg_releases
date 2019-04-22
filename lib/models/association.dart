class Association {
  String apiDetailUrl;
  String guid;
  int id;
  String name;
  String siteDetailUrl;

  Association({
    this.apiDetailUrl,
    this.guid,
    this.id,
    this.name,
    this.siteDetailUrl,
  });

  factory Association.fromJson(Map<String, dynamic> json) => new Association(
    apiDetailUrl: json["api_detail_url"] == null ? null : json["api_detail_url"],
    guid: json["guid"] == null ? null : json["guid"],
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    siteDetailUrl: json["site_detail_url"] == null ? null : json["site_detail_url"],
  );

  Map<String, dynamic> toJson() => {
    "api_detail_url": apiDetailUrl,
    "guid": guid == null ? null : guid,
    "id": id,
    "name": name,
    "site_detail_url": siteDetailUrl,
  };
}