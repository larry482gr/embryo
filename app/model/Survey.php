<?php 
	class ModelSurvey extends Model {
		public function findAll($lang_id) {
			$query = "SELECT * FROM surveys WHERE lang_id = ".$lang_id;
			$result = $this->db_survey->query($query);
			return $result->rows;
		}
		
		public function findSurvey($id) {
			$query = "SELECT id, title, is_public FROM surveys WHERE id = ".$id;
			$result = $this->db_survey->query($query);
			return $result->row;
		}
		
		public function findPageSurvey($lang_id, $alias) {
			$query = "SELECT id FROM surveys WHERE lang_id = ".$lang_id." AND alias = '".$alias."' AND is_public = 1 AND is_active = 1 AND has_errors = 0";
			$result = $this->db_survey->query($query);
			return !empty($result->row) ? $result->row : false;
		}
		
		public function findPublicSurvey($id) {
			$query = "SELECT id, title FROM surveys WHERE id = ".$id." AND is_public = 1 AND is_active = 1 AND has_errors = 0";
			$result = $this->db_survey->query($query);
			return isset($result->row) ? $result->row : false;
		}
		
		public function findSurveyCategories($survey_id) {
			$query = "SELECT * FROM categories WHERE survey_id = ".$survey_id;
			$result = $this->db_survey->query($query);
			return $result->rows;
		}
		
		public function findSurveySubcategories($category_id) {
			$query = "SELECT * FROM subcategories WHERE cat_id = ".$category_id;
			$result = $this->db_survey->query($query);
			return $result->rows;
		}
		
		public function findSurveyQuestions($subcategory_id) {
			$query = "SELECT * FROM questions WHERE subcat_id = ".$subcategory_id;
			$result = $this->db_survey->query($query);
			return $result->rows;
		}
		
		public function findSurveyQuestion($question_id) {
			$query = "SELECT * FROM questions WHERE id = ".$question_id;
			$result = $this->db_survey->query($query);
			return (isset($result->row) && !empty($result->row)) ? $result->row : false;
		}
		
		public function findSurveyQuestionsBySurveyId($survey_id) {
			$query	= "SELECT quest.id AS id, quest.answer_options AS answer_options FROM surveys AS survey, categories AS cat, subcategories AS subcat, questions AS quest ";
			$query .= "WHERE survey.id = ".$survey_id." AND cat.survey_id = survey.id AND subcat.cat_id = cat.id AND quest.subcat_id = subcat.id";
			$result = $this->db_survey->query($query);
			return !empty($result->rows) ? $result->rows : false;
		}
		
		public function findQuestionTypes() {
			$query = "SELECT * FROM question_types";
			$result = $this->db_survey->query($query);
			return $result->rows;
		}
		
		public function createSurvey($lang_id, $surveyTitle, $surveyAlias, $surveyIsPublic) {
			$surveyAlias = empty($surveyAlias) ? 'NULL' : "'".$surveyAlias."'";
			$query = "INSERT INTO surveys (title, lang_id, alias, is_public)
					  VALUES ('".$surveyTitle."', ".$lang_id.", ".$surveyAlias.", ".$surveyIsPublic.")";
			$this->db_survey->query($query);
			return $this->db_survey->getLastId();
		}
		
		public function createSurveyCategory($surveyId, $categoryLabel) {
			$query = "INSERT INTO categories (survey_id, label)
					  VALUES (".$surveyId.", '".$categoryLabel."')";
			$this->db_survey->query($query);
			return $this->db_survey->getLastId();
		}
		
		public function createSurveySubcategory($surveyCatId, $subcategoryHeader, $subcategoryLabel) {
			$subcategoryHeader = empty($subcategoryHeader) ? 'NULL' : "'".$subcategoryHeader."'";
			$query = "INSERT INTO subcategories (cat_id, header, label)
					  VALUES (".$surveyCatId.", ".$subcategoryHeader.", '".$subcategoryLabel."')";
			$this->db_survey->query($query);
			return $this->db_survey->getLastId();
		}
		
		public function createSurveyQuestion($surveySubcatId, $question) {
			$query = "INSERT INTO questions (subcat_id, type, text, help, answer_options, has_other, has_comment)
					  VALUES (".$surveySubcatId.", ".$question['type'].", ".$question['text'].", ".$question['help'].", ".$question['answer_options'].", ".$question['has_other'].", ".$question['has_comment'].")";
			$this->db_survey->query($query);
		}
		
		public function alreadyCompleted($title, $email) {
			$query	= "SELECT map.* FROM survey_user_map AS map, users AS user, surveys AS survey ";
			$query .= "WHERE survey.title = '".$title."' AND user.email = '".$email."' AND survey.id = map.survey_id AND user.id = map.user_id";
			$result = $this->db_survey->query($query);
			return empty($result->row) ? 0 : 1;
		}
		
		public function findSubmittedDateTime($survey_id, $email) {
			$query	= "SELECT map.date_time FROM survey_user_map AS map, users AS user, surveys AS survey ";
			$query .= "WHERE survey.id = '".$survey_id."' AND user.email = '".$email."' AND survey.id = map.survey_id AND user.id = map.user_id";
			$result = $this->db_survey->query($query);
			return (isset($result->row) && !empty($result->row)) ? $result->row : false;
		}
		
		public function findSurveyByQuestionId($question_id) {
			$query	= "SELECT survey.id AS id, survey.title AS title FROM surveys AS survey, categories AS cat, subcategories AS subcat, questions AS quest ";
			$query .= "WHERE quest.id = ".$question_id." AND quest.subcat_id = subcat.id AND subcat.cat_id = cat.id AND cat.survey_id = survey.id";
			$result = $this->db_survey->query($query);
			return !empty($result->row) ? $result->row : false;
		}
		
		public function createUser($fname, $lname, $email) {
			$query = "INSERT INTO users (first_name, last_name, email)
					  VALUES ('".$fname."', '".$lname."', '".$email."')";
			$this->db_survey->query($query);
			return $this->db_survey->getLastId();
		}
		
		public function createSurveyUserMap($survey_id, $user_id) {
			$query = "INSERT INTO survey_user_map (survey_id, user_id)
					  VALUES (".$survey_id.", ".$user_id.")";
			$this->db_survey->query($query);
			return $this->db_survey->countAffected();
		}
		
		public function createSurveyAnswer($user_id, $question_id, $answer = "NULL", $other = "NULL", $comment = "NULL") {
			$query = "INSERT INTO survey_answers (user_id, question_id, answer, other, comment)
					  VALUES (".$user_id.", ".$question_id.", ".$answer.", ".$other.", ".$comment.")";
			$this->db_survey->query($query);
			return $this->db_survey->countAffected();
		}
	}
?>