enum Service { userinfo, classtable, grades, exams, socialExams, terms }

String getServiceURL(Service type, {String week = "1"}) {
  const jwURL = "http://mjw.cdut.edu.cn/cdlgdxhd";
  switch (type) {
    case Service.userinfo:
      return "$jwURL/initUserInfo2";
    case Service.classtable:
      return "$jwURL/student/curriculum?week=$week&kbjcmsid=";
    case Service.grades:
      return "$jwURL/student/termGPA?semester=&type=1";
    case Service.exams:
      return "$jwURL/student/examinationArrangement";
    case Service.socialExams:
      return "$jwURL/student/socialTestScores";
    case Service.terms:
      return "$jwURL/semesterList";
    default:
      return "";
  }
}
