class AComm {
  static final AComm instance = AComm._internal();

  factory AComm() {
    return instance;
  }

  AComm._internal();
}