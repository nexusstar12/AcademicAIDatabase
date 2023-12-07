"""
The code below is just representative of the implementation of a Bot. 
However, this code was not meant to be compiled as it. It is the responsability 
of all the students to modifify this code such that it can fit the 
requirements for this assignments.
"""

import discord
import os
from discord.ext import commands
from models import *
from database import Database

TOKEN = os.environ["DISCORD_TOKEN"]

intents = discord.Intents.all()

bot = commands.Bot(command_prefix='!', intents=discord.Intents.all())


@bot.event
async def on_ready():
  print(f"Bot {bot.user} has joined the room")
  Database.connect()


@bot.command(
    name="test",
    description="write your database business requirement for this command here"
)
async def _test(ctx, arg1):
  testModel = TestModel(ctx, arg1)
  response = testModel.response()
  await ctx.send(response)


# TODO: complete the following tasks:
#       (1) Replace the commands' names with your own commands
#       (2) Write the description of your business requirement in the description parameter
#       (3) Implement your commands' methods.


@bot.command(name="studentPerf")
async def student_perf(ctx, major, minimum_students: int):
  result = StudentModel.get_average_gpa_by_major(major, minimum_students)
  await ctx.send(result)


@bot.command(
    name="courseEnroll",
    description=
    "Generate a report showing the number of students enrolled in each course")
async def course_enroll(ctx, minimum_students: int):
  response = CourseModel.get_enrollment_report(minimum_students)
  await ctx.send(response)


@bot.command(
    name="teacherReview",
    description=
    "List teachers whose students' average scores are above a certain score threshold"
)
async def teacher_review(ctx, score_threshold: int):
  response = EducatorModel.get_teachers_above_threshold(score_threshold)
  await ctx.send(response)


@bot.command(
    name="classroomUtil",
    description=
    "Report on the number of classes held in each classroom per week, excluding those used less than a specified number of times"
)
async def classroom_util(ctx, minimum_usage: int):
  response = ClassroomModel.get_classroom_usage(minimum_usage)
  await ctx.send(response)


@bot.command(name="newStudent",
             description=
             "Enroll a new student and assign mandatory courses based on major"
             )
async def new_student(ctx, major):
  response = StudentModel.enroll_new_student(major)
  await ctx.send(response)


@bot.command(
    name="addCourse",
    description="Add a new course to a department and assign a default teacher"
)
async def add_course(ctx, department):
  response = CourseModel.add_new_course(department)
  await ctx.send(response)


@bot.command(
    name="updateGrade",
    description="Update grades for a specific course based on certain criteria"
)
async def update_grade(ctx, course_id, criteria):
  response = GradeModel.update_course_grades(course_id, criteria)
  await ctx.send(response)


@bot.command(
    name="reassignTeacher",
    description=
    "Reassign a teacher to a different course based on departmental needs and teacher's expertise"
)
async def reassign_teacher(ctx, needs, expertise):
  result = TeacherModel.reassign_teacher(needs, expertise)
  await ctx.send(result)


@bot.command(name="removeCourse",
             description="Remove a course if no students are enrolled")
async def remove_course(ctx, course_code):
  result = CourseModel.remove_course(course_code)
  await ctx.send(result)


@bot.command(name="expelStudent",
             description="Expel a student based on specific criteria")
async def expel_student(ctx, criteria):
  result = StudentModel.expel_student(criteria)
  await ctx.send(result)


@bot.command(name="setAttendanceAlert",
             description=
             "Set an alert for when attendance drops below a certain threshold"
             )
async def set_attendance_alert(ctx, threshold: float):
  result = AttendanceModel.set_attendance_alert(threshold)
  await ctx.send(result)


@bot.command(name="setGradeAlert",
             description="Set a notification alert for grade changes")
async def set_grade_alert(ctx, change_threshold: float):
  result = GradeAlertModel.set_grade_alert(change_threshold)
  await ctx.send(result)


@bot.command(name="autoPromote",
             description="Automatically promote students based on criteria")
async def auto_promote(ctx, criteria):
  result = StudentPromotionModel.auto_promote(criteria)
  await ctx.send(result)


@bot.command(name="calcGPA",
             description="Calculate GPA based on specific weightings")
async def calc_gpa(ctx, weightings):
  result = GPAModel.calculate_gpa(weightings)
  await ctx.send(result)


@bot.command(name="recommendCourse",
             description="Recommend courses based on interests and performance"
             )
async def recommend_course(ctx, interests, performance):
  recommendations = CourseRecommendationModel.recommend_courses(
      interests, performance)
  await ctx.send(recommendations)


bot.run(TOKEN)
