class ProgramDialog {
  String id;
  String alreadyDoneMessage;
  String doneDialogContent;
  String doneDialogTitle;
  String donePositiveMessage;
  bool showDoneIcon;
  String programId;

  ProgramDialog(
      {this.id,
      this.alreadyDoneMessage,
      this.doneDialogContent,
      this.doneDialogTitle,
      this.donePositiveMessage,
      this.programId,
      this.showDoneIcon});

  factory ProgramDialog.fromMap(Map<String, dynamic> map) {
    return ProgramDialog(
        id: map["_id"],
        alreadyDoneMessage: map["alreadyDoneMessage"],
        doneDialogContent: map["doneDialogContent"],
        doneDialogTitle: map["doneDialogTitle"],
        donePositiveMessage: map["donePositiveMessage"],
        programId: map["programId"],
        showDoneIcon: map["showDoneIcon"]);
  }
}
