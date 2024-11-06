package com.course.service;

import java.util.List;

import com.course.entity.Course;

public interface CourseService {

	List<Course> getCourses();

	Course getCourses(long courseId);

	Course updateCourse(Course course);

	Course addCourse(Course course);

	void deleteCourse(Long parseLong);

}
