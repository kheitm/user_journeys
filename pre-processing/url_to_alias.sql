SET SQL_SAFE_UPDATES = 0;

UPDATE user_journey_data.front_interactions 

-- Use regex to replace the URLs with aliases
SET  
event_destination_url=REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(
					REGEXP_REPLACE(event_destination_url,'^example.com/$','Homepage')
	    ,'example.com/signup(?:\/.*)?$','Sign up')
        ,'example.com/resources-center(?:\/.*)?$','Resources center')
        ,'example.com/courses(?:\/.*)?$','Courses')
        ,'example.com/career-tracks(?:\/.*)?$','Career tracks')
        ,'example.com/upcoming-courses(?:\/.*)?$','Upcoming courses')
        ,'example.com/career-track-certificate(?:\/.*)?$','Career track certificate')
        ,'example.com/success-stories(?:\/.*)?$','Success stories')
        ,'example.com/blog(?:\/.*)?$','Blog')
        ,'example.com/pricing(?:\/.*)?$','Pricing')
        ,'example.com/about-us(?:\/.*)?$','About us')
        ,'example.com/course-certificate(?:\/.*)?$','Course certificate')
        ,'example.com/instructors(?:\/.*)?$','Instructors')
        ,'example.com/checkout(?:\/.*)?$','Checkout')
        ,'example.com/login(?:\/.*)?$','Log in');

-- Use a single query to replace the remaining URLS with Other
SET  event_destination_url=REGEXP_REPLACE(event_destination_url,'example.com(?:\/.*)?$','Other');

SET SQL_SAFE_UPDATES = 1;



