"""
In this file you must implement all your database models.
If you need to use the methods from your database.py call them
statically. For instance:
       # opens a new connection to your database
       connection = Database.connect()
       # closes the previous connection to avoid memory leaks
       connection.close()
"""
import random
import datetime
from database import Database


class TestModel:
  """
    This is an object model example. Note that
    this model doesn't implement a DB connection.
    """

  def __init__(self, ctx):
    self.ctx = ctx
    self.author = ctx.message.author.name

  def response(self):
    return f'Hi, {self.author}. I am alive'


class StudentModel:

  @staticmethod
  def get_average_gpa_by_major(major, minimum_students):
    query = """
          SELECT major, AVG(GPA) AS average_gpa
          FROM Student
          WHERE major = %s
          GROUP BY major
          HAVING COUNT(student_id) >= %s
      """
    result = Database.select(query, (major, minimum_students))
    if result:
      return "\n".join([
          f"Major: {row['major']}, Average GPA: {row['average_gpa']:.2f}"
          for row in result
      ])
    else:
      return f"No results found for major '{major}' with at least {minimum_students} students."

  @staticmethod
  def enroll_new_student(major):
    # Assuming generate_student_details() and get_mandatory_courses() are defined within this class or imported

    student_details = StudentModel.generate_student_details(major)
    insert_student_query = "INSERT INTO Student (name, major, enrollment_year, GPA) VALUES (%s, %s, %s, %s)"
    Database.insert(insert_student_query, student_details)

    mandatory_courses = StudentModel.get_mandatory_courses(major)
    for course_id in mandatory_courses:
      enrollment_query = "INSERT INTO Academic_History (user_id, courses_taken) VALUES (%s, %s)"
      Database.insert(enrollment_query,
                      (student_details['student_id'], course_id))

    return f"New student enrolled in major {major} and assigned to mandatory courses."

  @staticmethod
  def generate_student_details(major):
    # Logic to generate student details
    names = ['Alice', 'Bob', 'Charlie', 'Diana', 'Ethan']
    name = random.choice(names) + ' ' + random.choice(names)  # Random name
    enrollment_year = datetime.date.today().year
    gpa = round(random.uniform(2.0, 4.0), 2)  # Random GPA between 2.0 and 4.0

    return {
        'name': name,
        'major': major,
        'enrollment_year':
        f"{enrollment_year}-09-01",  # Assuming enrollment in September
        'GPA': gpa
    }

  @staticmethod
  def get_mandatory_courses(major):
    # Query to fetch mandatory courses for a major
    query = "SELECT course_id FROM Course WHERE major_requirement = %s"
    result = Database.select(query, (major, ))

    mandatory_courses = []
    if result:
      for course in result:
        mandatory_courses.append(course['course_id'])

    return mandatory_courses

  @staticmethod
  def expel_student(criteria):
    if criteria == 'poor_performance':
      expel_query = "DELETE FROM Student WHERE GPA < %s"
      threshold = 2.0  # Threshold for poor performance
      Database.delete(expel_query, (threshold, ))
      return f"Students with GPA below {threshold} have been expelled."

    elif criteria == 'disciplinary_issues':
      expel_query = "DELETE FROM Student WHERE disciplinary_flag = %s"
      flag_value = 1  # 1 indicates a disciplinary issue
      Database.delete(expel_query, (flag_value, ))
      return "Students with disciplinary issues have been expelled."

    else:
      return "Invalid criteria specified for expulsion."


class CourseModel:

  @staticmethod
  def get_enrollment_report(minimum_students):
    query = """
          SELECT Course.title, COUNT(Academic_History.user_id) AS enrolled_students
          FROM Course
          JOIN Academic_History ON Course.course_id = Academic_History.course_id
          GROUP BY Course.course_id
          HAVING COUNT(Academic_History.user_id) >= %s
      """
    result = Database.select(query, (minimum_students, ))
    if result:
      return "\n".join([
          f"Course: {row['title']}, Enrolled Students: {row['enrolled_students']}"
          for row in result
      ])
    else:
      return f"No courses found with at least {minimum_students} students enrolled."

  @staticmethod
  def add_new_course(department):
    course_details = CourseModel.generate_course_details(department)
    insert_course_query = "INSERT INTO Course (title, semester, credits) VALUES (%s, %s, %s)"
    course_id = Database.insert(
        insert_course_query,
        (course_details['title'], course_details['semester'],
         course_details['credits']))

    if course_id is None:
      return "Error adding new course."

    default_teacher_id = CourseModel.get_default_teacher(department)
    if default_teacher_id is None:
      return "No default teacher found for department."

    assign_teacher_query = "INSERT INTO TaughtBy (educator_id, course_id) VALUES (%s, %s)"
    Database.insert(assign_teacher_query, (default_teacher_id, course_id))

    return f"New course '{course_details['title']}' added to the {department} department."

  @staticmethod
  def get_default_teacher(department):
    # Query to fetch default teacher for a department
    query = "SELECT educator_id FROM Educator WHERE department = %s AND tenure_status = 1 LIMIT 1"
    result = Database.select(query, (department, ))

    if result:
      return result[0]['educator_id']
    else:
      return None

  @staticmethod
  def remove_course(course_code):
    # Check if any students are enrolled in the course
    check_query = "SELECT COUNT(*) AS count FROM Academic_History WHERE course_id = %s"
    check_result = Database.select(check_query, (course_code, ))
    if check_result and check_result[0]['count'] == 0:
      delete_query = "DELETE FROM Course WHERE course_id = %s"
      Database.delete(delete_query, (course_code, ))
      return f"Course with ID {course_code} has been removed."
    else:
      return f"Cannot remove course {course_code} as it still has enrolled students."


class EducatorModel:

  @staticmethod
  def get_teachers_above_threshold(score_threshold):
    query = """
          SELECT Educator.name, AVG(Performance.score) AS average_score
          FROM Educator
          JOIN Performance ON Educator.educator_id = Performance.educator_id
          GROUP BY Educator.educator_id
          HAVING AVG(Performance.score) > %s
      """
    result = Database.select(query, (score_threshold, ))
    if result:
      return "\n".join([
          f"Teacher: {row['name']}, Average Score: {row['average_score']}"
          for row in result
      ])
    else:
      return f"No teachers found with an average student performance score above {score_threshold}."


class ClassroomModel:

  @staticmethod
  def get_classroom_usage(minimum_usage):
    query = """
          SELECT Classroom.name, COUNT(Booking.booking_id) AS weekly_usage_count
          FROM Classroom
          JOIN Booking ON Classroom.classroom_id = Booking.classroom_id
          WHERE Booking.date BETWEEN DATE_SUB(NOW(), INTERVAL 1 WEEK) AND NOW()
          GROUP BY Classroom.classroom_id
          HAVING COUNT(Booking.booking_id) > %s
      """
    result = Database.select(query, (minimum_usage, ))
    if result:
      return "\n".join([
          f"Classroom: {row['name']}, Weekly Usage: {row['weekly_usage_count']} times"
          for row in result
      ])
    else:
      return f"No classrooms found with weekly usage above {minimum_usage} times."


class GradeModel:
  # Mapping of letter grades to numerical values
  grade_mapping = {
      'A': 4.0,
      'A-': 3.7,
      'B+': 3.3,
      'B': 3.0,
      'B-': 2.7,
      'C+': 2.3,
      'C': 2.0,
      'C-': 1.7,
      'D+': 1.3,
      'D': 1.0,
      'F': 0.0
  }

  @staticmethod
  def update_course_grades(course_id, criteria):
    updated_grades = GradeModel.calculate_new_grades(course_id, criteria)

    # Loop through and update each grade
    for grade, student_id in updated_grades:
      update_query = "UPDATE Academic_History SET grades = %s WHERE student_id = %s AND course_id = %s"
      Database.update(update_query, (grade, student_id, course_id))

    return f"Grades updated for course ID {course_id} based on criteria: {criteria}"

  @staticmethod
  def calculate_new_grades(course_id, criteria):
    select_query = "SELECT student_id, grades FROM Academic_History WHERE course_id = %s"
    current_grades = Database.select(select_query, (course_id, ))

    if not current_grades:  # Check if current_grades is None or empty
      return []  # Return an empty list if no grades are found

    updated_grades = []
    for record in current_grades:
      student_id = record['student_id']
      letter_grade = record['grades']

      # Convert the letter grade to a numerical value
      numerical_grade = GradeModel.grade_mapping.get(letter_grade, 0)

      # Adjust the numerical grade based on criteria
      if criteria == 'excellent_attendance':
        numerical_grade = min(numerical_grade + 0.3, 4.0)  # Cap at 4.0
      elif criteria == 'poor_attendance':
        numerical_grade = max(numerical_grade - 0.3,
                              0.0)  # Minimum grade is 0.0

      # Convert the numerical grade back to a letter grade
      updated_grade = GradeModel.get_letter_grade(numerical_grade)
      updated_grades.append((updated_grade, student_id))

    return updated_grades

  @staticmethod
  def get_letter_grade(numerical_grade):
    # Reverse the mapping to find the closest lower bound
    for grade, value in sorted(GradeModel.grade_mapping.items(),
                               key=lambda x: x[1],
                               reverse=True):
      if numerical_grade >= value:
        return grade
    return 'F'


class TeacherModel:

  @staticmethod
  def reassign_teacher(needs, expertise):
    # Reassigns a teacher to a course based on departmental needs and expertise
    query = """
          UPDATE Educator
          SET course_id = (
              SELECT course_id FROM Course
              WHERE department = %s AND educator_id IN (
                  SELECT educator_id FROM Educator WHERE specialty = %s
              )
          )
          WHERE specialty = %s
      """
    Database.update(query, (needs, expertise, expertise))
    return f"Teacher with expertise in {expertise} reassigned based on departmental needs: {needs}"


class AttendanceModel:

  @staticmethod
  def set_attendance_alert(threshold):
    # Ensure the threshold is a valid percentage
    if 0 <= threshold <= 100:
      update_query = "UPDATE AttendanceThreshold SET threshold = %s"
      Database.update(update_query, (threshold, ))
      return f"Attendance alert threshold set to {threshold}%."
    else:
      return "Invalid threshold. Please provide a value between 0 and 100."


class GradeAlertModel:

  @staticmethod
  def set_grade_alert(change_threshold):
    # Ensure the threshold is a valid percentage
    if 0 <= change_threshold <= 100:
      update_query = "UPDATE GradeChangeThreshold SET threshold = %s"
      Database.update(update_query, (change_threshold, ))
      return f"Grade change notification threshold set to {change_threshold}%."
    else:
      return "Invalid threshold. Please provide a value between 0 and 100."


class StudentPromotionModel:

  @staticmethod
  def auto_promote(criteria):
    # Call the stored procedure
    call_procedure = "CALL PromoteStudents(%s)"
    Database.execute(call_procedure, (criteria, ))
    return "Procedure to promote students has been executed."


class GPAModel:

  @staticmethod
  def calculate_gpa(weightings):
    # Call the function in the database that calculates GPA
    call_function = "SELECT CalculateGPA(%s)"
    result = Database.select(call_function, (weightings, ))
    if result:
      return f"The calculated GPA is: {result[0]['CalculateGPA']}"
    else:
      return "Unable to calculate GPA."


class CourseRecommendationModel:

  @staticmethod
  def recommend_courses(interests, performance):
    # Call the function in the database that recommends courses
    call_function = "SELECT RecommendCourses(%s, %s)"
    result = Database.select(call_function, (interests, performance))
    if result:
      recommendations = "\n".join(
          [f"Course: {row['course_name']}" for row in result])
      return f"Recommended Courses: \n{recommendations}"
    else:
      return "No course recommendations available."
