-- Script name: inserts.sql
-- Author:      Phillip Diec
-- Purpose:     Insert sample data to test the integrity of the aieducationdb system

-- the database used to insert the data into.
USE aieducationdb;

-- User table inserts
INSERT INTO User (user_id, password, registration_date, email) 
VALUES 
(1, 'alicepassword', NOW(), 'alice@email.com'),
(2, 'bobpassword', NOW(), 'bob@email.com'),
(3, 'charliepassword', NOW(), 'charlie@email.com');

-- Educator table inserts
INSERT INTO Educator (educator_id, name, department, tenure_status, specialty) 
VALUES 
(1, 'Dr. Alice', 'AI Department', 1, 'Neural Networks'),
(2, 'Dr. Bob', 'Data Science Department', 0, 'Statistical Analysis'),
(3, 'Dr. Charlie', 'ML Department', 1, 'Reinforcement Learning');

-- Course table inserts
INSERT INTO Course (course_id, title, educator_id, semester, credits) 
VALUES 
(1, 'Introduction to AI', 1, 'Fall 2023', 3),
(2, 'Data Science Basics', 2, 'Spring 2023', 4),
(3, 'Machine Learning 101', 3, 'Summer 2023', 3);


-- Account table inserts
INSERT INTO Account (account_id, user_id, account_status, last_login) 
VALUES 
(1, 1, 'Active', NOW()),
(2, 2, 'Inactive', NOW()),
(3, 3, 'Active', NOW());

-- Student table inserts
INSERT INTO Student (student_id, name, major, enrollment_year, GPA) 
VALUES 
(1, 'Eve', 'AI', '2021-09-01', 3.8),
(2, 'Frank', 'Data Science', '2022-01-15', 3.5),
(3, 'Grace', 'Machine Learning', '2022-05-01', 3.9);

-- AI Algorithm table inserts
INSERT INTO AI_Algorithm (algorithm_id, version, last_updated, `function`) 
VALUES 
(1, '1.0', NOW(), 'Classification using Neural Networks'),
(2, '2.0', NOW(), 'Decision Making using Decision Trees'),
(3, '1.5', NOW(), 'Environment Learning using Reinforcement Learning');

-- Academic Organization table inserts
INSERT INTO Academic_Organization (org_id, org_name, org_type, location, LinkOrganization_link_id) VALUES
(1, 'Tech University', 'University', 'Tech City', 101),
(2, 'Medic Institute', 'Institute', 'Health Town', 102),
(3, 'Edu College', 'College', 'Studyville', 103);

-- UserType table inserts
INSERT INTO UserType (userType_id, type_name, description) VALUES
(1, 'Student', 'User type for students.'),
(2, 'Faculty', 'User type for faculty members.'),
(3, 'Administrator', 'User type for administrative staff.');

-- Course Material table inserts
INSERT INTO Course_Material (material_id, course_id, type, link) VALUES
(1, 1001, 'PDF', 'link_to_pdf_1.com'),
(2, 1001, 'Video', 'link_to_video_1.com'),
(3, 1002, 'PDF', 'link_to_pdf_2.com'),
(4, 1003, 'Video', 'link_to_video_2.com');

-- InputSchedule table inserts
INSERT INTO InputSchedule (input_id, student_id, AIAlgorithm_id) VALUES
(1, 101, 1001),
(2, 102, 1002),
(3, 103, 1003),
(4, 104, 1004);

-- Add/RemoveCourses table inserts
INSERT INTO `Add/RemoveCourses` (action_id, admin_id, course_id) VALUES
(1, 1, 2001),
(2, 2, 2002),
(3, 1, 2003),
(4, 2, 2004);

-- Educational_Trend table inserts
INSERT INTO Educational_Trend (trend_id, name, description, emergence_date, DetectsTrend_detection_id) VALUES
(1, 'Trend_A', 'Description for Trend_A', '2023-10-25 12:00:00', 301),
(2, 'Trend_B', 'Description for Trend_B', '2023-10-20 12:00:00', 302),
(3, 'Trend_C', 'Description for Trend_C', '2023-10-15 12:00:00', 303),
(4, 'Trend_D', 'Description for Trend_D', '2023-10-10 12:00:00', 304);

-- Curriculum_Adjustments table inserts
INSERT INTO Curriculum_Adjustments (adjustment_id, student_id, suggested_changes, reason) VALUES
(1, 201, 'Change in topic order', 'Better flow of topics'),
(2, 202, 'Removal of certain topics', 'Redundancy observed'),
(3, 203, 'Addition of new topics', 'To cover recent developments'),
(4, 204, 'Adjustment in exam pattern', 'Based on feedback');

-- FileUpload table inserts
INSERT INTO FileUpload (file_id, task_id, file_path, upload_timestamp) VALUES
(1, 101, '/path/to/file1.ext', '2023-10-25 14:00:00'),
(2, 102, '/path/to/file2.ext', '2023-10-25 14:05:00'),
(3, 103, '/path/to/file3.ext', '2023-10-25 14:10:00'),
(4, 104, '/path/to/file4.ext', '2023-10-25 14:15:00');

-- Privacy_Settings table inserts
INSERT INTO Privacy_Settings (settings_id, visibility, data_sharing) VALUES
(1, 'Public', 'Yes'),
(2, 'Friends Only', 'No'),
(3, 'Private', 'Yes'),
(4, 'Public', 'No');

-- Parent table inserts
INSERT INTO Parent (parent_id, name, contact_number, relationship, child_student_id) VALUES
(1, 'John Doe', '1234567890', 'Father', 301),
(2, 'Jane Smith', '0987654321', 'Mother', 302),
(3, 'Alan Walker', '1122334455', 'Guardian', 303),
(4, 'Lucy Gray', '6677889900', 'Mother', 304);

-- Group_Task table inserts
INSERT INTO Group_Task (task_id, title, description, due_date) VALUES
(1, 'Group Assignment 1', 'Complete the given assignment on topic A', '2023-11-10'),
(2, 'Group Presentation', 'Prepare a presentation on topic B', '2023-11-15'),
(3, 'Group Project', 'Create a project on topic C', '2023-11-20'),
(4, 'Group Discussion', 'Discuss and submit insights on topic D', '2023-11-25');

-- UserRoles table inserts
INSERT INTO UserRoles (role_id, user_id, userType_id) VALUES
(1, 401, 'Student'),
(2, 402, 'Teacher'),
(3, 403, 'Admin'),
(4, 404, 'Parent');

-- GeneratesCourse table inserts
INSERT INTO GeneratesCourse (generation_id,AI_id, recommendation_id) VALUES
(1, 1, 501),
(2, 1, 502),
(3, 2, 503),
(4, 3, 504);

-- Performance table inserts
INSERT INTO Performance (performance_id, score, feedback) VALUES
(1, 87.5, 'Good performance, but needs improvement in certain areas'),
(2, 92.0, 'Excellent! Keep up the good work'),
(3, 78.5, 'Needs to focus more on foundational topics'),
(4, 90.0, 'Great job, minor issues to address');

-- VoteDiscuss table inserts
INSERT INTO VoteDiscuss (votediscuss_id, student_id, educator_id, comment_id) VALUES
(1, 1001, 2001, 3001),
(2, 1002, 2002, 3002),
(3, 1003, 2003, 3003),
(4, 1004, 2004, 3004);

-- ModerateDiscuss table inserts
INSERT INTO ModerateDiscuss (moderation_id, admin_id, discussionThread_id) VALUES
(1, 4001, 5001),
(2, 4002, 5002),
(3, 4003, 5003),
(4, 4004, 5004);

-- Device table inserts
INSERT INTO Device (device_id, user_id, type, last_access, LoginToDevices_login_id) VALUES
(1, 6001, 'Mobile', '2023-10-25 15:00:00', 7001),
(2, 6002, 'Laptop', '2023-10-25 15:10:00', 7002),
(3, 6003, 'Tablet', '2023-10-25 15:20:00', 7003),
(4, 6004, 'Desktop', '2023-10-25 15:30:00', 7004);

-- Admin table inserts
INSERT INTO Admin (admin_id, name, email, last_login, privilege_level, ModerateDiscuss_moderation_id, `Add/RemoveCourses_action_id`) VALUES
(1, 'Adam Brown', 'adam@email.com', '2023-10-25 16:00:00', 'High', 4001, 8001),
(2, 'Eve White', 'eve@email.com', '2023-10-25 16:05:00', 'Medium', 4002, 8002),
(3, 'Sam Black', 'sam@email.com', '2023-10-25 16:10:00', 'Low', 4003, 8003),
(4, 'Lucy Green', 'lucy@email.com', '2023-10-25 16:15:00', 'High', 4004, 8004);

-- Resources table inserts
INSERT INTO Resources (resource_id, resource_name, resource_path, resource_type, upload_timestamp, uploader_id, DownloadResource_download_id) VALUES
(1, 'Resource A', '/path/to/resourceA.ext', 'PDF', '2023-10-25 17:00:00', 9001, 10001),
(2, 'Resource B', '/path/to/resourceB.ext', 'Video', '2023-10-25 17:05:00', 9002, 10002),
(3, 'Resource C', '/path/to/resourceC.ext', 'Image', '2023-10-25 17:10:00', 9003, 10003),
(4, 'Resource D', '/path/to/resourceD.ext', 'Document', '2023-10-25 17:15:00', 9004, 10004);

-- LabTechnician table inserts
INSERT INTO LabTechnician (technician_id, name, lab_id, qualifications) VALUES
(1, 'John Doe', 101, 'B.Sc in Chemistry'),
(2, 'Jane Smith', 102, 'B.Sc in Biology'),
(3, 'Alice Johnson', 103, 'M.Sc in Organic Chemistry');

-- Address table inserts
INSERT INTO `Address_(Addressing an Issue)` (address_id, feedback_id, issue_description, resolution, status) VALUES
(1, 11, 'Issue with lab equipment', 'Replaced equipment', 'Resolved'),
(2, 12, 'Classroom seating issue', 'Added more chairs', 'Resolved'),
(3, 13, 'Faulty projector in auditorium', 'Sent for repair', 'Pending');

-- Prerequisite table inserts
INSERT INTO Prerequisite (prerequisite_id, course_id, requirements) VALUES
(1, 201, 'Basic Mathematics'),
(2, 202, 'Introduction to Physics'),
(3, 203, 'Fundamentals of Chemistry');

-- AI_Suggestions table inserts
INSERT INTO AI_Suggestions (suggestion_id, course_id, suggestion_reason, GeneratesCourse_generation_id) VALUES
(1, 201, 'Based on previous course completions', 301),
(2, 202, 'Highly rated by other students', 302),
(3, 203, 'Relevant for upcoming semester', 303);

-- Notifications table inserts
INSERT INTO Notifications (notification_id, content, timestamp) VALUES
(1, 'Lab class rescheduled to 4pm', '2023-10-24 10:15:00'),
(2, 'Physics exam on 28th Oct', '2023-10-24 11:05:00'),
(3, 'Guest lecture on Quantum Mechanics', '2023-10-24 12:00:00');

-- Content_Preference table inserts
INSERT INTO Content_Preference (preference_id, content_type, frequency) VALUES
(1, 'Video', 'Daily'),
(2, 'Reading Material', 'Weekly'),
(3, 'Interactive Quiz', 'Bi-weekly');

-- JoinsClub table inserts
INSERT INTO JoinsClub (join_id, user_id, academicClub_id) VALUES
(1, 1001, 501),
(2, 1002, 502),
(3, 1003, 503);

-- Academic Work Schedule table inserts
INSERT INTO Academic_Work_Schedule(schedule_id, student_id, courses, extracurriculars) VALUES
(1, 101, 'Mathematics, English', 'Basketball, Drama Club'),
(2, 102, 'Physics, Chemistry', 'Debate, Soccer'),
(3, 103, 'Biology, History', 'Music, Art Club');

-- TaughtBy table inserts
INSERT INTO TaughtBy(teaching_id, educator_id, course_id) VALUES
(1, 201, 301),
(2, 202, 302),
(3, 203, 303);

-- ProvideFeedback table inserts
INSERT INTO ProvideFeedback(provision_id, feedback_id, courseQualityAssessment_id) VALUES
(1, 401, 501),
(2, 402, 502),
(3, 403, 503);

-- DetectsTrend table inserts
INSERT INTO DetectsTrend(detection_id, system_id, educationalTrend_id) VALUES
(1, 601, 701),
(2, 602, 702),
(3, 603, 703);

-- RespondReview table inserts
INSERT INTO RespondReview(response_id, student_id, performanceReview_id) VALUES
(1, 101, 801),
(2, 102, 802),
(3, 103, 803);

-- LinkOrganization table inserts
INSERT INTO LinkOrganization(link_id, academicHistory_id, academicOrganization_id) VALUES
(1, 901, 1001),
(2, 902, 1002),
(3, 903, 1003);

-- LoginToDevices table inserts
INSERT INTO LoginToDevices(login_id, user_id, device_id) VALUES
(1, 1101, 1201),
(2, 1102, 1202),
(3, 1103, 1203);

-- Academic_History table inserts
INSERT INTO Academic_History(history_id, user_id, courses_taken, grades) VALUES
(1, 101, 'Math,Physics,Chemistry', 'A,B,A'),
(2, 102, 'Biology,Physics,English', 'A,A,B'),
(3, 103, 'Math,History,Geography', 'B,B,A');

-- Tutorials table inserts
INSERT INTO Tutorials(tutorial_id, title, content, creation_date) VALUES
(1, 'Introduction to Physics', 'This is an introduction to physics content...', '2023-10-25 12:00:00'),
(2, 'Basics of Math', 'This is a basic math tutorial content...', '2023-10-20 14:00:00'),
(3, 'History 101', 'An overview of world history...', '2023-10-15 16:00:00');

-- Department table inserts
INSERT INTO Department(department_id, department_name, head) VALUES
(1, 'Physics Department', 'Dr. John Doe'),
(2, 'Math Department', 'Dr. Jane Smith'),
(3, 'History Department', 'Dr. Emily Johnson');

-- LabEquipment table inserts
INSERT INTO LabEquipment(equipment_id, lab_id, equipment_name, status) VALUES
(1, 1, 'Microscope', 'Available'),
(2, 1, 'Test Tube', 'In Use'),
(3, 2, 'Computer', 'Available'),
(4, 2, 'Printer', 'Available'),
(5, 3, 'Bunsen Burner', 'Available'),
(6, 3, 'Flask', 'In Use');

-- LabHours table inserts
INSERT INTO LabHours(hour_id, lab_id, start_time, end_time) VALUES
(1, 1, '2023-10-25 09:00:00', '2023-10-25 11:00:00'),
(2, 1, '2023-10-25 12:00:00', '2023-10-25 14:00:00'),
(3, 2, '2023-10-25 15:00:00', '2023-10-25 17:00:00'),
(4, 2, '2023-10-26 10:00:00', '2023-10-26 12:00:00'),
(5, 3, '2023-10-26 13:00:00', '2023-10-26 15:00:00'),
(6, 3, '2023-10-27 09:00:00', '2023-10-27 11:00:00');

-- DownloadResource table inserts
INSERT INTO DownloadResource(download_id, user_id, resource_id) VALUES
(1, 101, 1001),
(2, 102, 1002),
(3, 103, 1003),
(4, 104, 1004),
(5, 105, 1005),
(6, 106, 1006);

-- CourseDetails table inserts
INSERT INTO CourseDetails(details_id, syllabus, objectives) VALUES
(1, 'Introduction to Biology; Cell Biology; Genetics', 'Understand basics of biology; Grasp cell functions; Learn about genetic variations'),
(2, 'Introduction to Computing; Algorithms; Databases', 'Understand computer operations; Learn algorithm techniques; Understand databases'),
(3, 'Physics Basics; Thermodynamics; Quantum Physics', 'Understand basic principles of physics; Learn about heat and energy; Dive into quantum mechanics');

-- Meeting_Hour table inserts
INSERT INTO Meeting_Hour(meeting_id, educator_id, start_time, end_time, location) VALUES
(1, 201, '2023-10-25 10:00:00', '2023-10-25 11:00:00', 'Room 101'),
(2, 202, '2023-10-25 14:00:00', '2023-10-25 15:00:00', 'Room 102'),
(3, 203, '2023-10-26 11:00:00', '2023-10-26 12:00:00', 'Room 103');

-- Lab table inserts
INSERT INTO Lab(lab_id, lab_name, location, capacity, BookLab_booking_id, LabHours_hour_id, LabEquipment_equipment_id) VALUES
(1, 'Biology Lab', 'First Floor', 30, 1, 1, 1),
(2, 'Computer Lab', 'Second Floor', 25, 2, 3, 3),
(3, 'Chemistry Lab', 'Third Floor', 20, 3, 5, 5);

-- BookLab table inserts
INSERT INTO BookLab(booking_id, student_id, labHour_id) VALUES
(1, 10001, 1),
(2, 10002, 2),
(3, 10003, 3);

-- Course_Recommendation table inserts
INSERT INTO Course_Recommendation (recommendation_id, student_id, course_id, basis) 
VALUES 
(1, 1, 1, 'High performance in prerequisites'),
(2, 2, 2, 'Recommendation by professor'),
(3, 3, 3, 'Interest in subject area');

-- ViewPerformance table inserts
INSERT INTO ViewPerformance (view_id, user_id, performance_id) 
VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Performance_Review table inserts
INSERT INTO Performance_Review (review_id, student_id, strengths, areas_for_improvement) 
VALUES 
(1, 1, 'Excellent team skills', 'Needs to participate more'),
(2, 2, 'Good problem solving', 'Time management'),
(3, 3, 'Strong analytical skills', 'Work on presentation'); 

-- Academic_Club table inserts
INSERT INTO Academic_Club (club_id, club_name, members_count) 
VALUES 
(1, 'Math Club', 100),
(2, 'Literature Club', 85),
(3, 'Science Club', 95);

-- System_Usage table inserts
INSERT INTO System_Usage (usage_id, user_id, last_active, total_hours, platform) 
VALUES 
(1, 1, '2023-10-24 16:00:00', 15.5, 'Web'),
(2, 2, '2023-10-24 17:30:00', 20.0, 'Mobile'),
(3, 3, '2023-10-24 18:00:00', 10.5, 'Web');

-- HasSchedule table inserts
INSERT INTO HasSchedule (has_id, course_id, courseDetails_id) 
VALUES 
(1, 1, 601),
(2, 2, 602),
(3, 3, 603);

-- Articles table inserts
INSERT INTO Articles (article_id, title, author, publication_date) VALUES 
(1, 'First Article', 'John Doe', '2023-10-24'),
(2, 'Second Article', 'Jane Smith', '2023-10-20'),
(3, 'Third Article', 'Robert Johnson', '2023-10-15');

-- DiscussionThread table inserts
INSERT INTO DiscussionThread (thread_id, user_id, topic, post_date) VALUES 
(1, 1, 'First Topic', '2023-10-24 15:30:00'),
(2, 2, 'Second Topic', '2023-10-23 16:30:00'),
(3, 3, 'Third Topic', '2023-10-22 17:30:00');

-- CreatesDiscuss table inserts
INSERT INTO CreatesDiscuss (creation_id, student_id, educator_id, comment_id, discuss_id) VALUES 
(1, 1, 1, 1, 1),
(2, 2, 2, 2, 2),
(3, 3, 3, 3, 3);

-- Feedback table inserts
INSERT INTO Feedback (feedback_id, user_id, content, submission_date) VALUES 
(1, 1, 'This is the first feedback', '2023-10-25 10:30:00'),
(2, 2, 'This is the second feedback', '2023-10-25 11:30:00'),
(3, 3, 'This is the third feedback', '2023-10-25 12:30:00');

-- VoteFeedback table inserts
INSERT INTO VoteFeedback (votefeedback_id, student_id, educator_id, feedback_id) VALUES 
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3);

-- Course_Quality_Assessment table inserts
INSERT INTO Course_Quality_Assessment (assessment_id, AI_id, feedback_id) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Comments table inserts
INSERT INTO Comments (comment_id, content, post_date, user_id) VALUES 
(1, 'This is the first comment', '2023-10-25 10:30:00', 1),
(2, 'This is the second comment', '2023-10-25 11:00:00', 2),
(3, 'This is the third comment', '2023-10-25 12:15:00', 3);

-- ReceivesSchedChange table inserts
INSERT INTO ReceivesSchedChange (receive_id, educator_id, notification_id) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);
