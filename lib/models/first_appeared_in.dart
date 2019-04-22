class FirstAppearedIn {
  String apiDetailUrl;
  int id;
  String name;
  String siteDetailUrl;

  FirstAppearedIn({
    this.apiDetailUrl,
    this.id,
    this.name,
    this.siteDetailUrl,
  });

  factory FirstAppearedIn.fromJson(Map<String, dynamic> json) => new FirstAppearedIn(
    apiDetailUrl: json["api_detail_url"],
    id: json["id"],
    name: json["name"],
    siteDetailUrl: json["site_detail_url"],
  );

  Map<String, dynamic> toJson() => {
    "api_detail_url": apiDetailUrl,
    "id": id,
    "name": name,
    "site_detail_url": siteDetailUrl,
  };
}