package com.course.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.course.entity.Course;
import com.course.repository.CourseRepo;

@Service
public class CourseservicesImpl implements CourseService
{
    @Autowired
	private CourseRepo courseRepo;
	
	@Override
	public List<Course> getCourses() {
		// TODO Auto-generated method stub
		return courseRepo.findAll();
	}

	@Override
	public Course getCourses(long courseId) {
		// TODO Auto-generated method stub
		return courseRepo.getOne(courseId);
	}

	@Override
	public Course updateCourse(Course course) {
		// TODO Auto-generated method stub
		courseRepo.save(course);
		return course;
	}

	@Override
	public Course addCourse(Course course) {
		// TODO Auto-generated method 
       
		courseRepo.save(course);
		return course;
	}

	@Override
	public void deleteCourse(Long parseLong) {
		
		 Course entity = courseRepo.getOne(parseLong);
	      courseRepo.delete(entity);
		// TODO Auto-generated method stub
		
	}
	
	
	

}
