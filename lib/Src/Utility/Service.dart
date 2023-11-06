enum Service { userinfo, classtable, grades, exams, socialExams, terms }

String getServiceURL(Service type) {
  switch (type) {
    case Service.userinfo:
      return "/initUserInfo2";
    case Service.classtable:
      return "/student/curriculum?week=&kbjcmsid=";
    case Service.grades:
      return "/student/termGPA?semester=&type=1";
    case Service.exams:
      return "/student/examinationArrangement";
    case Service.socialExams:
      return "/student/socialTestScores";
    case Service.terms:
      return "/semesterList";
    default:
      return "";
  }
}
