-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema aieducationdb
-- -----------------------------------------------------
DROP DATABASE IF EXISTS aieducationdb; 

CREATE DATABASE IF NOT EXISTS aieducationdb; 

USE aieducationdb;
-- -----------------------------------------------------
-- Table `Feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Feedback` ;

CREATE TABLE IF NOT EXISTS `Feedback` (
  `feedback_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `content` TEXT NOT NULL,
  `submission_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`feedback_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `feedback_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Notifications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Notifications` ;

CREATE TABLE IF NOT EXISTS `Notifications` (
  `notification_id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (`notification_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ReceivesSchedChange`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ReceivesSchedChange` ;

CREATE TABLE IF NOT EXISTS `ReceivesSchedChange` (
  `receive_id` INT NOT NULL AUTO_INCREMENT,
  `educator_id` INT NOT NULL,
  `notification_id` INT NOT NULL,
  PRIMARY KEY (`receive_id`),
  INDEX `educator_id_idx` (`educator_id` ASC) VISIBLE,
  INDEX `notification_id_idx` (`notification_id` ASC) INVISIBLE,
  CONSTRAINT `schedchange_educator_id`
    FOREIGN KEY (`educator_id`)
    REFERENCES `Educator` (`educator_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `schedchange_notification_id`
    FOREIGN KEY (`notification_id`)
    REFERENCES `Notifications` (`notification_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Course_Recommendation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Course_Recommendation` ;

CREATE TABLE IF NOT EXISTS `Course_Recommendation` (
  `recommendation_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `course_id` INT NOT NULL,
  `basis` TEXT NOT NULL,
  PRIMARY KEY (`recommendation_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `course_id_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `student_id_recommendation`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `course_id_recommendation`
    FOREIGN KEY (`course_id`)
    REFERENCES `Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GeneratesCourse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeneratesCourse` ;

CREATE TABLE IF NOT EXISTS `GeneratesCourse` (
  `generation_id` INT NOT NULL AUTO_INCREMENT,
  `AI_id` INT NOT NULL,
  `recommendation_id` INT NOT NULL,
  PRIMARY KEY (`generation_id`),
  INDEX `AI_id_idx` (`AI_id` ASC) VISIBLE,
  INDEX `recommendation_id_idx` (`recommendation_id` ASC) VISIBLE,
  CONSTRAINT `coursegenerate_AI_id`
    FOREIGN KEY (`AI_id`)
    REFERENCES `AI_Algorithm` (`algorithm_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `coursegenerate_recommendation_id`
    FOREIGN KEY (`recommendation_id`)
    REFERENCES `Course_Recommendation` (`recommendation_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Admin` ;

CREATE TABLE IF NOT EXISTS `Admin` (
  `admin_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `last_login` TIMESTAMP NOT NULL,
  `privilege_level` VARCHAR(255) NOT NULL,
  `ModerateDiscuss_moderation_id` INT NULL,
  `Add/RemoveCourses_action_id` INT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_Admin_Add/RemoveCourses1_idx` (`Add/RemoveCourses_action_id` ASC) VISIBLE,
  CONSTRAINT `fk_Admin_Add/RemoveCourses1`
    FOREIGN KEY (`Add/RemoveCourses_action_id`)
    REFERENCES `Add/RemoveCourses` (`action_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Add/RemoveCourses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Add/RemoveCourses` ;

CREATE TABLE IF NOT EXISTS `Add/RemoveCourses` (
  `action_id` INT NOT NULL AUTO_INCREMENT,
  `admin_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`action_id`),
  INDEX `admin_id_idx` (`admin_id` ASC) VISIBLE,
  INDEX `course_id_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `add_remove_admin_id`
    FOREIGN KEY (`admin_id`)
    REFERENCES `Admin` (`admin_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `add_remove_course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Course_Material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Course_Material` ;

CREATE TABLE IF NOT EXISTS `Course_Material` (
  `material_id` INT NOT NULL AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `link` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`material_id`),
  INDEX `course_id_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `coursematerial_course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Educational_Trend`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Educational_Trend` ;

CREATE TABLE IF NOT EXISTS `Educational_Trend` (
  `trend_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `emergence_date` TIMESTAMP NULL,
  `DetectsTrend_detection_id` INT NOT NULL,
  PRIMARY KEY (`trend_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `fk_Educational Trend_DetectsTrend1_idx` (`DetectsTrend_detection_id` ASC) VISIBLE,
  CONSTRAINT `fk_Educational Trend_DetectsTrend1`
    FOREIGN KEY (`DetectsTrend_detection_id`)
    REFERENCES `DetectsTrend` (`detection_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DetectsTrend`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DetectsTrend` ;

CREATE TABLE IF NOT EXISTS `DetectsTrend` (
  `detection_id` INT NOT NULL AUTO_INCREMENT,
  `system_id` INT NOT NULL,
  `educationalTrend_id` INT NULL,
  PRIMARY KEY (`detection_id`),
  INDEX `educationalTrend_id_idx` (`educationalTrend_id` ASC) VISIBLE,
  INDEX `system_id_idx` (`system_id` ASC) VISIBLE,
  CONSTRAINT `detect_educationalTrend_id`
    FOREIGN KEY (`educationalTrend_id`)
    REFERENCES `Educational_Trend` (`trend_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `detect_system_id`
    FOREIGN KEY (`system_id`)
    REFERENCES `System` (`system_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CourseDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CourseDetails` ;

CREATE TABLE IF NOT EXISTS `CourseDetails` (
  `details_id` INT NOT NULL AUTO_INCREMENT,
  `syllabus` TEXT NOT NULL,
  `objectives` TEXT NOT NULL,
  PRIMARY KEY (`details_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Content_Preference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Content_Preference` ;

CREATE TABLE IF NOT EXISTS `Content_Preference` (
  `preference_id` INT NOT NULL AUTO_INCREMENT,
  `content_type` VARCHAR(255) NOT NULL,
  `frequency` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`preference_id`),
  UNIQUE INDEX `content_type_UNIQUE` (`content_type` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Articles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Articles` ;

CREATE TABLE IF NOT EXISTS `Articles` (
  `article_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `author` VARCHAR(255) NOT NULL,
  `publication_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`article_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Group_Task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Group_Task` ;

CREATE TABLE IF NOT EXISTS `Group_Task` (
  `task_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `due_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`task_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Course` ;

CREATE TABLE IF NOT EXISTS `Course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `educator_id` INT NULL,
  `semester` VARCHAR(255) NOT NULL,
  `credits` INT NOT NULL,
  `GeneratesCourse_generation_id` INT NULL,
  `TaughtBy_teaching_id` INT NULL,
  `Add/RemoveCourses_action_id` INT NULL,
  `Course Material_material_id` INT NULL,
  `Course Recommendation_recommendation_id` INT NULL,
  `DetectsTrend_detection_id` INT NULL,
  `CourseDetails_details_id` INT NULL,
  `Content Preference_preference_id` INT NULL,
  `Articles_article_id` INT NULL,
  `Group Task_task_id` INT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `educator_id_idx` (`educator_id` ASC) VISIBLE,
  INDEX `fk_Course_GeneratesCourse1_idx` (`GeneratesCourse_generation_id` ASC) VISIBLE,
  INDEX `fk_Course_TaughtBy1_idx` (`TaughtBy_teaching_id` ASC) VISIBLE,
  INDEX `fk_Course_Add/RemoveCourses1_idx` (`Add/RemoveCourses_action_id` ASC) VISIBLE,
  INDEX `fk_Course_Course Material1_idx` (`Course Material_material_id` ASC) VISIBLE,
  INDEX `fk_Course_Course Recommendation1_idx` (`Course Recommendation_recommendation_id` ASC) VISIBLE,
  INDEX `fk_Course_DetectsTrend1_idx` (`DetectsTrend_detection_id` ASC) VISIBLE,
  INDEX `fk_Course_CourseDetails1_idx` (`CourseDetails_details_id` ASC) VISIBLE,
  INDEX `fk_Course_Content Preference1_idx` (`Content Preference_preference_id` ASC) VISIBLE,
  INDEX `fk_Course_Articles1_idx` (`Articles_article_id` ASC) VISIBLE,
  INDEX `fk_Course_Group Task1_idx` (`Group Task_task_id` ASC) VISIBLE,
  CONSTRAINT `course_educator_id`
    FOREIGN KEY (`educator_id`)
    REFERENCES `Educator` (`educator_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_GeneratesCourse1`
    FOREIGN KEY (`GeneratesCourse_generation_id`)
    REFERENCES `GeneratesCourse` (`generation_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_TaughtBy1`
    FOREIGN KEY (`TaughtBy_teaching_id`)
    REFERENCES `TaughtBy` (`teaching_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_Add/RemoveCourses1`
    FOREIGN KEY (`Add/RemoveCourses_action_id`)
    REFERENCES `Add/RemoveCourses` (`action_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_Course Material1`
    FOREIGN KEY (`Course Material_material_id`)
    REFERENCES `Course_Material` (`material_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_Course Recommendation1`
    FOREIGN KEY (`Course Recommendation_recommendation_id`)
    REFERENCES `Course_Recommendation` (`recommendation_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_DetectsTrend1`
    FOREIGN KEY (`DetectsTrend_detection_id`)
    REFERENCES `DetectsTrend` (`detection_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_CourseDetails1`
    FOREIGN KEY (`CourseDetails_details_id`)
    REFERENCES `CourseDetails` (`details_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_Content Preference1`
    FOREIGN KEY (`Content Preference_preference_id`)
    REFERENCES `Content_Preference` (`preference_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_Articles1`
    FOREIGN KEY (`Articles_article_id`)
    REFERENCES `Articles` (`article_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Course_Group Task1`
    FOREIGN KEY (`Group Task_task_id`)
    REFERENCES `Group_Task` (`task_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TaughtBy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `TaughtBy` ;

CREATE TABLE IF NOT EXISTS `TaughtBy` (
  `teaching_id` INT NOT NULL AUTO_INCREMENT,
  `educator_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`teaching_id`),
  INDEX `educator_id_idx` (`educator_id` ASC) VISIBLE,
  INDEX `course_id_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `taughtby_educator_id`
    FOREIGN KEY (`educator_id`)
    REFERENCES `Educator` (`educator_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `taughtby_course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VoteFeedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VoteFeedback` ;

CREATE TABLE IF NOT EXISTS `VoteFeedback` (
  `votefeedback_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `educator_id` INT NOT NULL,
  `feedback_id` INT NOT NULL,
  PRIMARY KEY (`votefeedback_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `educator_id_idx` (`educator_id` ASC) VISIBLE,
  INDEX `feedback_id_idx` (`feedback_id` ASC) VISIBLE,
  CONSTRAINT `votefeedback_student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `votefeedback_educator_id`
    FOREIGN KEY (`educator_id`)
    REFERENCES `Educator` (`educator_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `votefeedback_feedback_id`
    FOREIGN KEY (`feedback_id`)
    REFERENCES `Feedback` (`feedback_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comments` ;

CREATE TABLE IF NOT EXISTS `Comments` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NOT NULL,
  `post_date` TIMESTAMP NOT NULL,
  `user_id` INT NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `comments_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `VoteDiscuss`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `VoteDiscuss` ;

CREATE TABLE IF NOT EXISTS `VoteDiscuss` (
  `votediscuss_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `educator_id` INT NOT NULL,
  `comment_id` INT NULL,
  PRIMARY KEY (`votediscuss_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `educator_id_idx` (`educator_id` ASC) VISIBLE,
  INDEX `comment_id_idx` (`comment_id` ASC) VISIBLE,
  CONSTRAINT `votediscuss_student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `votediscuss_educator_id`
    FOREIGN KEY (`educator_id`)
    REFERENCES `Educator` (`educator_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `votediscuss_comment_id`
    FOREIGN KEY (`comment_id`)
    REFERENCES `Comments` (`comment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Performance_Review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Performance_Review` ;

CREATE TABLE IF NOT EXISTS `Performance_Review` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `strengths` TEXT NOT NULL,
  `areas_for_improvement` TEXT NOT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `reviewperformance_student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `RespondReview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `RespondReview` ;

CREATE TABLE IF NOT EXISTS `RespondReview` (
  `response_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `performanceReview_id` INT NOT NULL,
  PRIMARY KEY (`response_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `performanceReview_id_idx` (`performanceReview_id` ASC) VISIBLE,
  CONSTRAINT `reviewrespond_student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `reviewrespond_performanceReview_id`
    FOREIGN KEY (`performanceReview_id`)
    REFERENCES `Performance_Review` (`review_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Meeting_Hour`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Meeting_Hour` ;

CREATE TABLE IF NOT EXISTS `Meeting_Hour` (
  `meeting_id` INT NOT NULL AUTO_INCREMENT,
  `educator_id` INT NOT NULL,
  `start_time` TIMESTAMP NOT NULL,
  `end_time` TIMESTAMP NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`meeting_id`),
  INDEX `educator_id_idx` (`educator_id` ASC) VISIBLE,
  CONSTRAINT `meethour_educator_id`
    FOREIGN KEY (`educator_id`)
    REFERENCES `Educator` (`educator_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Academic_History`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Academic_History` ;

CREATE TABLE IF NOT EXISTS `Academic_History` (
  `history_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `courses_taken` VARCHAR(255) NOT NULL,
  `grades` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`history_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  CONSTRAINT `academichist_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LinkOrganization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LinkOrganization` ;

CREATE TABLE IF NOT EXISTS `LinkOrganization` (
  `link_id` INT NOT NULL AUTO_INCREMENT,
  `academicHistory_id` INT NOT NULL,
  `academicOrganization_id` INT NOT NULL,
  PRIMARY KEY (`link_id`),
  INDEX `academicHistory_id_idx` (`academicHistory_id` ASC) VISIBLE,
  INDEX `academicOrganization_id_idx` (`academicOrganization_id` ASC) VISIBLE,
  CONSTRAINT `linkorg_academicHistory_id`
    FOREIGN KEY (`academicHistory_id`)
    REFERENCES `Academic_History` (`history_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `linkorg_academicOrganization_id`
    FOREIGN KEY (`academicOrganization_id`)
    REFERENCES `Academic_Organization` (`org_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Academic_Organization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Academic_Organization` ;

CREATE TABLE IF NOT EXISTS `Academic_Organization` (
  `org_id` INT NOT NULL AUTO_INCREMENT,
  `org_name` VARCHAR(255) NOT NULL,
  `org_type` VARCHAR(255) NOT NULL,
  `location` VARCHAR(255) NOT NULL,
  `LinkOrganization_link_id` INT NOT NULL,
  PRIMARY KEY (`org_id`),
  INDEX `fk_Academic Organization_LinkOrganization1_idx` (`LinkOrganization_link_id` ASC) VISIBLE,
  CONSTRAINT `fk_Academic Organization_LinkOrganization1`
    FOREIGN KEY (`LinkOrganization_link_id`)
    REFERENCES `LinkOrganization` (`link_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Educator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Educator` ;

CREATE TABLE IF NOT EXISTS `Educator` (
  `educator_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `department` VARCHAR(255) NOT NULL,
  `tenure_status` TINYINT NOT NULL,
  `specialty` VARCHAR(255) NOT NULL,
  `ReceivesSchedChange_receive_id` INT NULL,
  `TaughtBy_teaching_id` INT NULL,
  `VoteFeedback_votefeedback_id` INT NULL,
  `VoteDiscuss_votediscuss_id` INT NULL,
  `CreatesDiscuss_creation_id` INT NULL,
  `RespondReview_response_id` INT NULL,
  `Feedback_feedback_id` INT NULL,
  `Feedback_VoteFeedback_votefeedback_id` INT NULL,
  `Comments_comment_id` INT NULL,
  `Comments_VoteDiscuss_votediscuss_id` INT NULL,
  `Comments_CreatesDiscuss_creation_id` INT NULL,
  `Meeting Hour_meeting_id` INT NULL,
  `Academic Organization_org_id` INT NULL,
  PRIMARY KEY (`educator_id`),
  INDEX `fk_Educator_ReceivesSchedChange1_idx` (`ReceivesSchedChange_receive_id` ASC) VISIBLE,
  INDEX `fk_Educator_TaughtBy1_idx` (`TaughtBy_teaching_id` ASC) VISIBLE,
  INDEX `fk_Educator_VoteFeedback1_idx` (`VoteFeedback_votefeedback_id` ASC) VISIBLE,
  INDEX `fk_Educator_VoteDiscuss1_idx` (`VoteDiscuss_votediscuss_id` ASC) VISIBLE,
  INDEX `fk_Educator_CreatesDiscuss1_idx` (`CreatesDiscuss_creation_id` ASC) VISIBLE,
  INDEX `fk_Educator_RespondReview1_idx` (`RespondReview_response_id` ASC) VISIBLE,
  INDEX `fk_Educator_Feedback1_idx` (`Feedback_feedback_id` ASC, `Feedback_VoteFeedback_votefeedback_id` ASC) VISIBLE,
  INDEX `fk_Educator_Comments1_idx` (`Comments_comment_id` ASC, `Comments_VoteDiscuss_votediscuss_id` ASC, `Comments_CreatesDiscuss_creation_id` ASC) VISIBLE,
  INDEX `fk_Educator_Meeting Hour1_idx` (`Meeting Hour_meeting_id` ASC) VISIBLE,
  INDEX `fk_Educator_Academic Organization1_idx` (`Academic Organization_org_id` ASC) VISIBLE,
  CONSTRAINT `fk_Educator_ReceivesSchedChange1`
    FOREIGN KEY (`ReceivesSchedChange_receive_id`)
    REFERENCES `ReceivesSchedChange` (`receive_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Educator_TaughtBy1`
    FOREIGN KEY (`TaughtBy_teaching_id`)
    REFERENCES `TaughtBy` (`teaching_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Educator_VoteFeedback1`
    FOREIGN KEY (`VoteFeedback_votefeedback_id`)
    REFERENCES `VoteFeedback` (`votefeedback_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Educator_VoteDiscuss1`
    FOREIGN KEY (`VoteDiscuss_votediscuss_id`)
    REFERENCES `VoteDiscuss` (`votediscuss_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Educator_CreatesDiscuss1`
    FOREIGN KEY (`CreatesDiscuss_creation_id`)
    REFERENCES `CreatesDiscuss` (`creation_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Educator_RespondReview1`
    FOREIGN KEY (`RespondReview_response_id`)
    REFERENCES `RespondReview` (`response_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Educator_Feedback1`
    FOREIGN KEY (`Feedback_feedback_id`)
    REFERENCES `Feedback` (`feedback_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Educator_Comments1`
    FOREIGN KEY (`Comments_comment_id`)
    REFERENCES `Comments` (`comment_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Educator_Meeting Hour1`
    FOREIGN KEY (`Meeting Hour_meeting_id`)
    REFERENCES `Meeting_Hour` (`meeting_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Educator_Academic Organization1`
    FOREIGN KEY (`Academic Organization_org_id`)
    REFERENCES `Academic_Organization` (`org_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DiscussionThread`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DiscussionThread` ;

CREATE TABLE IF NOT EXISTS `DiscussionThread` (
  `thread_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `topic` VARCHAR(255) NOT NULL,
  `post_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`thread_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `discussionthread_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CreatesDiscuss`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CreatesDiscuss` ;

CREATE TABLE IF NOT EXISTS `CreatesDiscuss` (
  `creation_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NOT NULL,
  `educator_id` INT NOT NULL,
  `comment_id` INT NOT NULL,
  `discuss_id` INT NOT NULL,
  PRIMARY KEY (`creation_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `educator_id_idx` (`educator_id` ASC) VISIBLE,
  INDEX `comment_id_idx` (`comment_id` ASC) VISIBLE,
  INDEX `discuss_id_idx` (`discuss_id` ASC) VISIBLE,
  CONSTRAINT `creatediscuss_student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `creatediscuss_educator_id`
    FOREIGN KEY (`educator_id`)
    REFERENCES `Educator` (`educator_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `creatediscuss_comment_id`
    FOREIGN KEY (`comment_id`)
    REFERENCES `Comments` (`comment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `creatediscuss_discuss_id`
    FOREIGN KEY (`discuss_id`)
    REFERENCES `DiscussionThread` (`thread_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Academic_Club`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Academic_Club` ;

CREATE TABLE IF NOT EXISTS `Academic_Club` (
  `club_id` INT NOT NULL AUTO_INCREMENT,
  `club_name` VARCHAR(255) NOT NULL,
  `members_count` INT NOT NULL,
  PRIMARY KEY (`club_id`),
  UNIQUE INDEX `members_count_UNIQUE` (`members_count` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `JoinsClub`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `JoinsClub` ;

CREATE TABLE IF NOT EXISTS `JoinsClub` (
  `join_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `academicClub_id` INT NOT NULL,
  PRIMARY KEY (`join_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `academicClub_id_idx` (`academicClub_id` ASC) VISIBLE,
  CONSTRAINT `clubjoin_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `clubjoin_academicClub_id`
    FOREIGN KEY (`academicClub_id`)
    REFERENCES `Academic_Club` (`club_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LabEquipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LabEquipment` ;

CREATE TABLE IF NOT EXISTS `LabEquipment` (
  `equipment_id` INT NOT NULL AUTO_INCREMENT,
  `lab_id` INT NOT NULL,
  `equipment_name` VARCHAR(255) NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`equipment_id`),
  INDEX `lab_id_idx` (`lab_id` ASC) VISIBLE,
  CONSTRAINT `labequipment_lab_id`
    FOREIGN KEY (`lab_id`)
    REFERENCES `Lab` (`lab_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Lab`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Lab` ;

CREATE TABLE IF NOT EXISTS `Lab` (
  `lab_id` INT NOT NULL AUTO_INCREMENT,
  `lab_name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(255) NULL,
  `capacity` INT NULL,
  `BookLab_booking_id` INT NOT NULL,
  `LabHours_hour_id` INT NOT NULL,
  `LabEquipment_equipment_id` INT NULL,
  PRIMARY KEY (`lab_id`),
  INDEX `fk_Lab_BookLab1_idx` (`BookLab_booking_id` ASC) VISIBLE,
  INDEX `fk_Lab_LabHours1_idx` (`LabHours_hour_id` ASC) VISIBLE,
  INDEX `fk_Lab_LabEquipment1_idx` (`LabEquipment_equipment_id` ASC) VISIBLE,
  CONSTRAINT `fk_Lab_BookLab1`
    FOREIGN KEY (`BookLab_booking_id`)
    REFERENCES `BookLab` (`booking_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Lab_LabHours1`
    FOREIGN KEY (`LabHours_hour_id`)
    REFERENCES `LabHours` (`hour_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Lab_LabEquipment1`
    FOREIGN KEY (`LabEquipment_equipment_id`)
    REFERENCES `LabEquipment` (`equipment_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LabHours`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LabHours` ;

CREATE TABLE IF NOT EXISTS `LabHours` (
  `hour_id` INT NOT NULL AUTO_INCREMENT,
  `lab_id` INT NOT NULL,
  `start_time` TIMESTAMP NOT NULL,
  `end_time` TIMESTAMP NOT NULL,
  PRIMARY KEY (`hour_id`),
  INDEX `lab_id_idx` (`lab_id` ASC) VISIBLE,
  CONSTRAINT `labhours_lab_id`
    FOREIGN KEY (`lab_id`)
    REFERENCES `Lab` (`lab_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BookLab`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BookLab` ;

CREATE TABLE IF NOT EXISTS `BookLab` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `labHour_id` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `labHour_id_idx` (`labHour_id` ASC) VISIBLE,
  CONSTRAINT `labbook_student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `labbook_labHour_id`
    FOREIGN KEY (`labHour_id`)
    REFERENCES `LabHours` (`hour_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Student` ;

CREATE TABLE IF NOT EXISTS `Student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `major` VARCHAR(255) NOT NULL,
  `enrollment_year` DATE NOT NULL,
  `GPA` DECIMAL NOT NULL,
  `CreatesDiscuss_creation_id` INT NULL,
  `JoinsClub_join_id` INT NULL,
  `BookLab_booking_id` INT NULL,
  `VoteFeedback_votefeedback_id` INT NULL,
  `VoteDiscuss_votediscuss_id` INT NULL,
  `RespondReview_response_id` INT NULL,
  `Feedback_feedback_id` INT NULL,
  `Feedback_VoteFeedback_votefeedback_id` INT NULL,
  `Comments_comment_id` INT NULL,
  `Comments_VoteDiscuss_votediscuss_id` INT NULL,
  `Comments_CreatesDiscuss_creation_id` INT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `fk_Student_CreatesDiscuss1_idx` (`CreatesDiscuss_creation_id` ASC) VISIBLE,
  INDEX `fk_Student_JoinsClub1_idx` (`JoinsClub_join_id` ASC) VISIBLE,
  INDEX `fk_Student_BookLab1_idx` (`BookLab_booking_id` ASC) VISIBLE,
  INDEX `fk_Student_VoteFeedback1_idx` (`VoteFeedback_votefeedback_id` ASC) VISIBLE,
  INDEX `fk_Student_VoteDiscuss1_idx` (`VoteDiscuss_votediscuss_id` ASC) VISIBLE,
  INDEX `fk_Student_RespondReview1_idx` (`RespondReview_response_id` ASC) VISIBLE,
  INDEX `fk_Student_Feedback1_idx` (`Feedback_feedback_id` ASC, `Feedback_VoteFeedback_votefeedback_id` ASC) VISIBLE,
  INDEX `fk_Student_Comments1_idx` (`Comments_comment_id` ASC, `Comments_VoteDiscuss_votediscuss_id` ASC, `Comments_CreatesDiscuss_creation_id` ASC) VISIBLE,
  CONSTRAINT `fk_Student_CreatesDiscuss1`
    FOREIGN KEY (`CreatesDiscuss_creation_id`)
    REFERENCES `CreatesDiscuss` (`creation_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_JoinsClub1`
    FOREIGN KEY (`JoinsClub_join_id`)
    REFERENCES `JoinsClub` (`join_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_BookLab1`
    FOREIGN KEY (`BookLab_booking_id`)
    REFERENCES `BookLab` (`booking_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_VoteFeedback1`
    FOREIGN KEY (`VoteFeedback_votefeedback_id`)
    REFERENCES `VoteFeedback` (`votefeedback_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_VoteDiscuss1`
    FOREIGN KEY (`VoteDiscuss_votediscuss_id`)
    REFERENCES `VoteDiscuss` (`votediscuss_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_RespondReview1`
    FOREIGN KEY (`RespondReview_response_id`)
    REFERENCES `RespondReview` (`response_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Feedback1`
    FOREIGN KEY (`Feedback_feedback_id`)
    REFERENCES `Feedback` (`feedback_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Comments1`
    FOREIGN KEY (`Comments_comment_id`)
    REFERENCES `Comments` (`comment_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `InputSchedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `InputSchedule` ;

CREATE TABLE IF NOT EXISTS `InputSchedule` (
  `input_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `AIAlgorithm_id` INT NOT NULL,
  PRIMARY KEY (`input_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  INDEX `AIAlgorithm_id_idx` (`AIAlgorithm_id` ASC) VISIBLE,
  CONSTRAINT `inputsched_student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `inputsched_AIAlgorithm_id`
    FOREIGN KEY (`AIAlgorithm_id`)
    REFERENCES `AI_Algorithm` (`algorithm_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AI_Algorithm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AI_Algorithm` ;

CREATE TABLE IF NOT EXISTS `AI_Algorithm` (
  `algorithm_id` INT NOT NULL AUTO_INCREMENT,
  `version` VARCHAR(255) NOT NULL,
  `last_updated` TIMESTAMP NOT NULL,
  `function` TEXT NOT NULL,
  `InputSchedule_input_id` INT NULL,
  `DetectsTrend_detection_id` INT NULL,
  PRIMARY KEY (`algorithm_id`),
  INDEX `fk_AI Algorithm_InputSchedule1_idx` (`InputSchedule_input_id` ASC) VISIBLE,
  INDEX `fk_AI Algorithm_DetectsTrend1_idx` (`DetectsTrend_detection_id` ASC) VISIBLE,
  CONSTRAINT `fk_AI Algorithm_InputSchedule1`
    FOREIGN KEY (`InputSchedule_input_id`)
    REFERENCES `InputSchedule` (`input_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_AI Algorithm_DetectsTrend1`
    FOREIGN KEY (`DetectsTrend_detection_id`)
    REFERENCES `DetectsTrend` (`detection_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Course_Quality_Assessment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Course_Quality_Assessment` ;

CREATE TABLE IF NOT EXISTS `Course_Quality_Assessment` (
  `assessment_id` INT NOT NULL AUTO_INCREMENT,
  `AI_id` INT NOT NULL,
  `feedback_id` INT NOT NULL,
  PRIMARY KEY (`assessment_id`),
  UNIQUE INDEX `assessment_id_UNIQUE` (`assessment_id` ASC) VISIBLE,
  INDEX `feedback_id_idx` (`feedback_id` ASC) VISIBLE,
  INDEX `AI_id_idx` (`AI_id` ASC) VISIBLE,
  CONSTRAINT `assess_feedback_id`
    FOREIGN KEY (`feedback_id`)
    REFERENCES `Feedback` (`feedback_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `assess_AI_id`
    FOREIGN KEY (`AI_id`)
    REFERENCES `AI_Algorithm` (`algorithm_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ProvideFeedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ProvideFeedback` ;

CREATE TABLE IF NOT EXISTS `ProvideFeedback` (
  `provision_id` INT NOT NULL AUTO_INCREMENT,
  `feedback_id` INT NOT NULL,
  `courseQualityAssessment_id` INT NULL,
  PRIMARY KEY (`provision_id`),
  INDEX `feedback_id_idx` (`feedback_id` ASC) VISIBLE,
  INDEX `courseQualityAssessment_id_idx` (`courseQualityAssessment_id` ASC) VISIBLE,
  CONSTRAINT `providefeedback_feedback_id`
    FOREIGN KEY (`feedback_id`)
    REFERENCES `Feedback` (`feedback_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `providefeedback_courseQualityAssessment_id`
    FOREIGN KEY (`courseQualityAssessment_id`)
    REFERENCES `Course_Quality_Assessment` (`assessment_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HasSchedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HasSchedule` ;

CREATE TABLE IF NOT EXISTS `HasSchedule` (
  `has_id` INT NOT NULL AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `courseDetails_id` INT NULL,
  PRIMARY KEY (`has_id`),
  INDEX `course_id_idx` (`course_id` ASC) VISIBLE,
  INDEX `courseDetails_id_idx` (`courseDetails_id` ASC) VISIBLE,
  CONSTRAINT `hassched_course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `hassched_courseDetails_id`
    FOREIGN KEY (`courseDetails_id`)
    REFERENCES `CourseDetails` (`details_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `User` ;

CREATE TABLE IF NOT EXISTS `User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `registration_date` TIMESTAMP NOT NULL,
  `ProvideFeedback_provision_id` INT NULL,
  `LinkOrganization_link_id` INT NULL,
  `HasSchedule_has_id` INT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_User_ProvideFeedback1_idx` (`ProvideFeedback_provision_id` ASC) VISIBLE,
  INDEX `fk_User_LinkOrganization1_idx` (`LinkOrganization_link_id` ASC) VISIBLE,
  INDEX `fk_User_HasSchedule1_idx` (`HasSchedule_has_id` ASC) VISIBLE,
  CONSTRAINT `fk_User_ProvideFeedback1`
    FOREIGN KEY (`ProvideFeedback_provision_id`)
    REFERENCES `ProvideFeedback` (`provision_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_User_LinkOrganization1`
    FOREIGN KEY (`LinkOrganization_link_id`)
    REFERENCES `LinkOrganization` (`link_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_User_HasSchedule1`
    FOREIGN KEY (`HasSchedule_has_id`)
    REFERENCES `HasSchedule` (`has_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `System_Usage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `System_Usage` ;

CREATE TABLE IF NOT EXISTS `System_Usage` (
  `usage_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `last_active` TIMESTAMP NOT NULL,
  `total_hours` DECIMAL NOT NULL,
  `platform` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`usage_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `sysusage_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `System`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `System` ;

CREATE TABLE IF NOT EXISTS `System` (
  `system_id` INT NOT NULL AUTO_INCREMENT,
  `version` VARCHAR(255) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  `System Usage_usage_id` INT NOT NULL,
  PRIMARY KEY (`system_id`),
  INDEX `fk_System_System Usage1_idx` (`System Usage_usage_id` ASC) VISIBLE,
  CONSTRAINT `fk_System_System Usage1`
    FOREIGN KEY (`System Usage_usage_id`)
    REFERENCES `System_Usage` (`usage_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Prerequisite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Prerequisite` ;

CREATE TABLE IF NOT EXISTS `Prerequisite` (
  `prerequisite_id` INT NOT NULL AUTO_INCREMENT,
  `course_id` INT NOT NULL,
  `requirements` TEXT NOT NULL,
  PRIMARY KEY (`prerequisite_id`),
  INDEX `course_id_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `prerequisite_course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Department` ;

CREATE TABLE IF NOT EXISTS `Department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(255) NOT NULL,
  `head` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Privacy_Settings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Privacy_Settings` ;

CREATE TABLE IF NOT EXISTS `Privacy_Settings` (
  `settings_id` INT NOT NULL AUTO_INCREMENT,
  `visibility` VARCHAR(255) NOT NULL,
  `data_sharing` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`settings_id`),
  UNIQUE INDEX `visibility_UNIQUE` (`visibility` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AI_Suggestions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `AI_Suggestions` ;

CREATE TABLE IF NOT EXISTS `AI_Suggestions` (
  `suggestion_id` INT NOT NULL,
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `suggestion_reason` TEXT NOT NULL,
  `GeneratesCourse_generation_id` INT NOT NULL,
  PRIMARY KEY (`suggestion_id`),
  UNIQUE INDEX `course_id_UNIQUE` (`course_id` ASC) VISIBLE,
  INDEX `fk_AI Suggestions_GeneratesCourse1_idx` (`GeneratesCourse_generation_id` ASC) VISIBLE,
  CONSTRAINT `AIsuggestions_course_id`
    FOREIGN KEY (`course_id`)
    REFERENCES `Course` (`course_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_AI Suggestions_GeneratesCourse1`
    FOREIGN KEY (`GeneratesCourse_generation_id`)
    REFERENCES `GeneratesCourse` (`generation_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Performance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Performance` ;

CREATE TABLE IF NOT EXISTS `Performance` (
  `performance_id` INT NOT NULL AUTO_INCREMENT,
  `score` DECIMAL NOT NULL,
  `feedback` TEXT NOT NULL,
  PRIMARY KEY (`performance_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Curriculum_Adjustments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Curriculum_Adjustments` ;

CREATE TABLE IF NOT EXISTS `Curriculum_Adjustments` (
  `adjustment_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `suggested_changes` TEXT NOT NULL,
  `reason` TEXT NOT NULL,
  PRIMARY KEY (`adjustment_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `curradjustment_student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Academic_Work_Schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Academic_Work_Schedule` ;

CREATE TABLE IF NOT EXISTS `Academic_Work_Schedule` (
  `schedule_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL,
  `courses` TEXT NOT NULL,
  `extracurriculars` TEXT NOT NULL,
  PRIMARY KEY (`schedule_id`),
  INDEX `student_id_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `schedule_student_id`
    FOREIGN KEY (`student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Address_(Addressing an Issue)`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Address_(Addressing an Issue)` ;

CREATE TABLE IF NOT EXISTS `Address_(Addressing an Issue)` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `feedback_id` INT NOT NULL,
  `issue_description` TEXT NOT NULL,
  `resolution` TEXT NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `feedback_id_idx` (`feedback_id` ASC) VISIBLE,
  CONSTRAINT `addressing_feedback_id`
    FOREIGN KEY (`feedback_id`)
    REFERENCES `Feedback` (`feedback_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Device` ;

CREATE TABLE IF NOT EXISTS `Device` (
  `device_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `last_access` TIMESTAMP NOT NULL,
  `LoginToDevices_login_id` INT NOT NULL,
  PRIMARY KEY (`device_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_Device_LoginToDevices1_idx` (`LoginToDevices_login_id` ASC) VISIBLE,
  CONSTRAINT `device_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Device_LoginToDevices1`
    FOREIGN KEY (`LoginToDevices_login_id`)
    REFERENCES `LoginToDevices` (`login_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LoginToDevices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LoginToDevices` ;

CREATE TABLE IF NOT EXISTS `LoginToDevices` (
  `login_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `device_id` INT NULL,
  PRIMARY KEY (`login_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `device_id_idx` (`device_id` ASC) VISIBLE,
  CONSTRAINT `logindevice_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `logindevice_device_id`
    FOREIGN KEY (`device_id`)
    REFERENCES `Device` (`device_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Resources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Resources` ;

CREATE TABLE IF NOT EXISTS `Resources` (
  `resource_id` INT NOT NULL AUTO_INCREMENT,
  `resource_name` VARCHAR(255) NOT NULL,
  `resource_path` VARCHAR(255) NOT NULL,
  `resource_type` VARCHAR(100) NULL,
  `upload_timestamp` TIMESTAMP NOT NULL,
  `uploader_id` INT NOT NULL,
  `DownloadResource_download_id` INT NULL,
  PRIMARY KEY (`resource_id`),
  INDEX `uploader_id_idx` (`uploader_id` ASC) VISIBLE,
  INDEX `fk_Resources_DownloadResource1_idx` (`DownloadResource_download_id` ASC) VISIBLE,
  CONSTRAINT `resource_uploader_id`
    FOREIGN KEY (`uploader_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Resources_DownloadResource1`
    FOREIGN KEY (`DownloadResource_download_id`)
    REFERENCES `DownloadResource` (`download_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DownloadResource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DownloadResource` ;

CREATE TABLE IF NOT EXISTS `DownloadResource` (
  `download_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `resource_id` INT NOT NULL,
  PRIMARY KEY (`download_id`),
  INDEX `resource_id_idx` (`resource_id` ASC) VISIBLE,
  INDEX `resourcedownload_user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `resourcedownload_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `resourcedownload_resource_id`
    FOREIGN KEY (`resource_id`)
    REFERENCES `Resources` (`resource_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UserType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UserType` ;

CREATE TABLE IF NOT EXISTS `UserType` (
  `userType_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  PRIMARY KEY (`userType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `UserRoles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `UserRoles` ;

CREATE TABLE IF NOT EXISTS `UserRoles` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `userType_id` INT NOT NULL,
  PRIMARY KEY (`role_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `userroles_usertype_id_idx` (`userType_id` ASC) VISIBLE,
  CONSTRAINT `userroles_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `userroles_usertype_id`
    FOREIGN KEY (`userType_id`)
    REFERENCES `UserType` (`userType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Account` ;

CREATE TABLE IF NOT EXISTS `Account` (
  `account_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `account_status` VARCHAR(255) NOT NULL,
  `last_login` TIMESTAMP NOT NULL,
  `Privacy Settings_settings_id` INT NULL,
  `Academic History_history_id` INT NULL,
  `Academic Work Schedule_schedule_id` INT NULL,
  `Address (Addressing an Issue_address_id` INT NULL,
  `LoginToDevices_login_id` INT NULL,
  `DownloadResource_download_id` INT NULL,
  `UserRoles_role_id` INT NULL,
  `GeneratesCourse_generation_id` INT NULL,
  `UserType_userType_id` INT NULL,
  `UserType_UserRoles_role_id` INT NULL,
  PRIMARY KEY (`account_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_Account_Privacy Settings1_idx` (`Privacy Settings_settings_id` ASC) VISIBLE,
  INDEX `fk_Account_Academic History1_idx` (`Academic History_history_id` ASC) VISIBLE,
  INDEX `fk_Account_Academic Work Schedule1_idx` (`Academic Work Schedule_schedule_id` ASC) VISIBLE,
  INDEX `fk_Account_Address (Addressing an Issue1_idx` (`Address (Addressing an Issue_address_id` ASC) VISIBLE,
  INDEX `fk_Account_LoginToDevices1_idx` (`LoginToDevices_login_id` ASC) VISIBLE,
  INDEX `fk_Account_DownloadResource1_idx` (`DownloadResource_download_id` ASC) VISIBLE,
  INDEX `fk_Account_UserRoles1_idx` (`UserRoles_role_id` ASC) VISIBLE,
  INDEX `fk_Account_GeneratesCourse1_idx` (`GeneratesCourse_generation_id` ASC) VISIBLE,
  INDEX `fk_Account_UserType1_idx` (`UserType_userType_id` ASC, `UserType_UserRoles_role_id` ASC) INVISIBLE,
  CONSTRAINT `account_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Account_Privacy Settings1`
    FOREIGN KEY (`Privacy Settings_settings_id`)
    REFERENCES `Privacy_Settings` (`settings_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Account_Academic History1`
    FOREIGN KEY (`Academic History_history_id`)
    REFERENCES `Academic_History` (`history_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Account_Academic Work Schedule1`
    FOREIGN KEY (`Academic Work Schedule_schedule_id`)
    REFERENCES `Academic_Work_Schedule` (`schedule_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Account_Address (Addressing an Issue1`
    FOREIGN KEY (`Address (Addressing an Issue_address_id`)
    REFERENCES `Address_(Addressing an Issue)` (`address_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Account_LoginToDevices1`
    FOREIGN KEY (`LoginToDevices_login_id`)
    REFERENCES `LoginToDevices` (`login_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Account_DownloadResource1`
    FOREIGN KEY (`DownloadResource_download_id`)
    REFERENCES `DownloadResource` (`download_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Account_UserRoles1`
    FOREIGN KEY (`UserRoles_role_id`)
    REFERENCES `UserRoles` (`role_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Account_GeneratesCourse1`
    FOREIGN KEY (`GeneratesCourse_generation_id`)
    REFERENCES `GeneratesCourse` (`generation_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Account_UserType1`
    FOREIGN KEY (`UserType_userType_id`)
    REFERENCES `UserType` (`userType_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tutorials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Tutorials` ;

CREATE TABLE IF NOT EXISTS `Tutorials` (
  `tutorial_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `content` TEXT NOT NULL,
  `creation_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`tutorial_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Parent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Parent` ;

CREATE TABLE IF NOT EXISTS `Parent` (
  `parent_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `child_student_id` INT NOT NULL,
  `contact_number` VARCHAR(255) NOT NULL,
  `relationship` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`parent_id`),
  INDEX `child_student_id_idx` (`child_student_id` ASC) VISIBLE,
  CONSTRAINT `child_student_id`
    FOREIGN KEY (`child_student_id`)
    REFERENCES `Student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FileUpload`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FileUpload` ;

CREATE TABLE IF NOT EXISTS `FileUpload` (
  `file_id` INT NOT NULL AUTO_INCREMENT,
  `task_id` INT NOT NULL,
  `file_path` VARCHAR(255) NOT NULL,
  `upload_timestamp` TIMESTAMP NOT NULL,
  PRIMARY KEY (`file_id`),
  INDEX `task_id_idx` (`task_id` ASC) VISIBLE,
  CONSTRAINT `fileupload_task_id`
    FOREIGN KEY (`task_id`)
    REFERENCES `Group_Task` (`task_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LabTechnician`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LabTechnician` ;

CREATE TABLE IF NOT EXISTS `LabTechnician` (
  `technician_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `lab_id` INT NULL,
  `qualifications` TEXT NOT NULL,
  PRIMARY KEY (`technician_id`),
  INDEX `lab_id_idx` (`lab_id` ASC) VISIBLE,
  CONSTRAINT `labtechnician_lab_id`
    FOREIGN KEY (`lab_id`)
    REFERENCES `Lab` (`lab_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ViewPerformance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ViewPerformance` ;

CREATE TABLE IF NOT EXISTS `ViewPerformance` (
  `view_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `performance_id` INT NULL,
  PRIMARY KEY (`view_id`),
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `performance_id_idx` (`performance_id` ASC) VISIBLE,
  CONSTRAINT `performanceview_user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `User` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `performanceview_performance_id`
    FOREIGN KEY (`performance_id`)
    REFERENCES `Performance` (`performance_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ModerateDiscuss`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ModerateDiscuss` ;

CREATE TABLE IF NOT EXISTS `ModerateDiscuss` (
  `moderation_id` INT NOT NULL AUTO_INCREMENT,
  `admin_id` INT NULL,
  `discussionThread_id` INT NULL,
  PRIMARY KEY (`moderation_id`),
  INDEX `admin_id_idx` (`admin_id` ASC) VISIBLE,
  INDEX `discusstionThread_id_idx` (`discussionThread_id` ASC) VISIBLE,
  CONSTRAINT `moderatediscuss_admin_id`
    FOREIGN KEY (`admin_id`)
    REFERENCES `Admin` (`admin_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `moderatediscuss_discusstionThread_id`
    FOREIGN KEY (`discussionThread_id`)
    REFERENCES `DiscussionThread` (`thread_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
