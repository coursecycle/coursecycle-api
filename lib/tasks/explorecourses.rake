namespace :explorecourses do

  desc "Import an ExploreCourses XML dump into the database"
  task :import, [:path] => :environment do |t, args|

    # Load the file into a Nokogiri object
    f = File.open(Rails.root.join(args[:path]))
    doc = Nokogiri::XML(f)
    f.close

    # Find all of the class objects
    courses = doc.css("course")
    courses.each do |course|
      import_course(course)
    end

  end

  private

  # Create a course from the XML description, or update an existing course
  def import_course(course_xml)

    # Scan the course for <courseId>, <subject>, and <code> which together form a course entity
    # We do this because a single courseId could correspond to multiple cross-listed courses
    admin_information = course_xml.css("administrativeInformation")
    ecid = admin_information.css("courseId").first.content.to_i
    subject = course_xml.css("subject").first.content
    code = course_xml.css("code").first.content

    # Attempt to find the course; if it doesn't exist, create it
    identifier = { :ecid => ecid, :subject => subject, :code => code }
    course = Course.find_by(identifier)
    if course.nil?
      course = Course.new(identifier)
    end

    # Fill in the rest of the information
    course.title = course_xml.css("title").first.content
    course.description = course_xml.css("description").first.content
    puts "#{course.subject} #{course.code} #{course.title}"

    # Save the updated course information
    course.save

    # Iterate through all of the associated sections
    sections = course_xml.css("section")
    sections.each do |section|
      import_section(course, section)
    end
  end

  # Create a section from the XML description, or update an existing section
  # There is a bit of a conflict as to what a section is unfortunately
  # - ExploreCourses defines a "Section" as a seasonal course, of which there could be many sessions
  # - Coursecycle's definition of a "Section" is a specific instance of a course
  def import_section(course, section_xml)

    # Get section information from <section>
    year, season = section_xml.css("term").first.content.split()   
    component = section_xml.css("component").first.content 

    # Scan through all of the schedules
    schedules = section_xml.css("schedule")
    schedules.each do |schedule_xml|

      # Get content about the schedule
      start_date = schedule_xml.css("startDate").first.content
      end_date = schedule_xml.css("endDate").first.content
      start_time = schedule_xml.css("startTime").first.content
      end_time = schedule_xml.css("endTime").first.content
      location = schedule_xml.css("location").first.content

      # HACKHACK: Every once in a while a date like Jul 2, 20131013 gets parsed out
      # Unsure why this is happening, even with an explicit formatter string
      if start_date.length > 12 or end_date.length > 12
        puts "ISSUE WITH THIS CLASS"
        next
      end

      # Corresponds to the concatenation of start_date and start_time with a space
      begin
        formatter = "%b %e, %Y %l:%M:%S %p"
        start_datetime = DateTime.strptime([start_date, start_time].join(" "), formatter)
        end_datetime = DateTime.strptime([end_date, end_time].join(" "), formatter)
      rescue
        next
      end

      # A section is uniquely identified by the time it takes place and the course it is associated with
      section_identifier = { :start => start_datetime, :end => end_datetime, :ecid => course.ecid }
      section = Section.find_by(section_identifier)
      if section.nil?
        section = Section.new(section_identifier)
      end

      # Add details as needed for the section
      section.location = location
      section.year = year
      section.season = season
      section.component = component

      # Iterate through all the instructors
      instructors = schedule_xml.css("instructor")
      instructors.each do |instructor_xml|

        # We can assume that an instructor is uniquely identified by their SUNetID
        sunet = instructor_xml.css("sunet").first.content
        instructor_identifier = { :sunet => sunet }
        instructor = Instructor.find_by(instructor_identifier)
        if instructor.nil?
          instructor = Instructor.new(instructor_identifier)
        end

        # Add attributes for the instructor as needed
        instructor.name = instructor_xml.css("name").first.content if instructor.name.nil?
        instructor.first_name = instructor_xml.css("firstName").first.content if instructor.first_name.nil?
        instructor.middle_name = instructor_xml.css("middleName").first.content if instructor.middle_name.nil?
        instructor.last_name = instructor_xml.css("lastName").first.content if instructor.last_name.nil?
        instructor.role = instructor_xml.css("role").first.content if instructor.role.nil?

        # Save the instructor object
        instructor.save

        # Add the instructor to the section
        section.instructors << instructor

      end

      # Save the section, then add the section to the course
      section.save

    end

  end

end
