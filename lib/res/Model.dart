class Model {
  Model(Map data) {
    this.id = data["id"];
    this.imgUrl = data["imgUrl"];
    this.hrefUrl = data["hrefUrl"];
    this.type = data["type"];
    this.state = data["state"];
    this.created = data["created"];
    this.modified = data["modified"];
    this.remark = data["remark"];
    this.title = data["title"];
    this.role = data["role"];
    this.siteNo = data["siteNo"];
    this.contents = data["contents"];
  }
  int id;
  String imgUrl;
  String hrefUrl;
  int type;
  int state;
  String created;
  String modified;
  String remark;
  String title;
  int role;
  String siteNo;
  Map contents;
}
