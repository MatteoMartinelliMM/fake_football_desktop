class EventJson {
  late String clickTime;
  late String clipStart;
  late String endClip;
  late String evento;
  late int id;
  late String partita;

  EventJson(this.clickTime, this.clipStart, this.endClip, this.evento, this.id, this.partita);

  EventJson.fromJson(Map<String, dynamic> json) {
    clickTime = json['clickTime'];
    clipStart = json['clipStart'];
    endClip = json['endClip'];
    evento = json['evento'];
    id = json['id'];
    partita = json['partita'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clickTime'] = this.clickTime;
    data['clipStart'] = this.clipStart;
    data['endClip'] = this.endClip;
    data['evento'] = this.evento;
    data['id'] = this.id;
    data['partita'] = this.partita;
    return data;
  }
}
