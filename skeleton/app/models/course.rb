class Course < ActiveRecord::Base
  has_many :enrollments,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Enrollment

  has_many :enrolled_students,
    through: :enrollments,
    source: :user

  belongs_to :prerequisite,
    class_name: :Course,
    foreign_key: :prereq_id,
    primary_key: :id

  has_many :next_courses,
    primary_key: :id,
    foreign_key: :prereq_id,
    class_name: :Course

  belongs_to :instructor,
    class_name: :User,
    foreign_key: :instructor_id,
    primary_key: :id
end
